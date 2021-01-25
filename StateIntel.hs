{-# OPTIONS -cpp #-}
{-# LANGUAGE UndecidableInstances, TypeSynonymInstances, FlexibleInstances,
      GeneralizedNewtypeDeriving, UndecidableInstances,
      ScopedTypeVariables, MultiParamTypeClasses
  #-}

{- monad for the Intel simulator

   Organization of instructions:

   - read-only access to the frames, each organized as a finite map of blocks

       - each block begins with a label and ends with a jump or ret
       - first block: prologue (label = frame name)
       - last block : ends with ret

   Organization of memory:

   - the memory layout remains abstract, access via symbolic addresses

   - an address is either a heap or a stack address

   Organization of heap :

     - finite map from symbolic adresses to arrays

     - an address is a symbol plus an offset

     - computing an address which points outside of the array raises an
       exception

   Organization of the stack:

     - stack layout

         ebp[+4(n+2)]  arg_n
         ...           ...
         ebp[+12]      arg_1
         ebp[+8]       arg_0 (usually this)
         ebp[+4]       ret addr
         ebp[+0]       saved ebp
         ebp[-4]       param_0
         ...           ...
         ebp[-4(n+1)]  param_n

     - the stack is implemented simply by a map from addresses to entries

     - stack entries:
       * integer
       * heap address
       * stack address
       * return address (which is just the name of the current function,
                         "call" and "ret" are specials)

     - additing to esp will shrink the stack (as well as pop, leave, ret)
     - subtracting from esp will grow the stack (as well as push, call)

     - strict stack checking: errors are

       - reading from uninitialized cell (definitive!)

       - reading/writing above stack top (definitive!)

       - reading/writing below esp (stack bottom)

       - reading/writing return address

       - writing over saved ebp

   Organization of registers:

     - mutable register file, including map for temps

     - optional : calling saves reg.file, returning restores (except ebp, esp)

 -}

module StateIntel where

import Prelude hiding (not,print)
import qualified Prelude as Prelude

import Control.Monad.Error
import Control.Monad.Reader
import Control.Monad.Writer
import Control.Monad.State

import Data.Bits
import Data.Char
import Data.Int
import Data.Functor
import Data.Maybe -- fromJust
import Data.Map (Map)
import qualified Data.Map as Map
import Data.IntMap (IntMap)
import qualified Data.IntMap as IntMap

import Debug.Trace

import Util -- fmap2
import GenSym hiding (St,initSt)
import Frame -- (wordSize,Acc(..))
import Intel
import FrameIntel

----------------------------------------------------------------------
-- Values
----------------------------------------------------------------------

type StackAddr = Int

type Symbolic = Int
data HeapAddr = HeapAddr { base :: Symbolic , disp :: Int }
              deriving (Eq)

data Val
  = I !Int32      -- 32bit signed (Doubleword)
  -- | Q !Int64      -- 64bit signed (Quadword)
  | R !Label      -- return address
  | S !StackAddr  -- stack address (linear)
  | H !HeapAddr   -- heap address (symbolic)
    deriving (Eq)

type Addr = Val

isStackAddr :: Val -> Maybe StackAddr
isStackAddr (S a) = Just a
isStackAddr _     = Nothing


instance Show HeapAddr where
    show (HeapAddr base disp)
        | disp >= 0  = "h" ++ show base ++ ":+" ++ show disp
        | otherwise  = "h" ++ show base ++ ":-" ++ show (-disp)

instance Show Val where
    show (I i) = "integer " ++ show i
{- why absolute value?:
    show (I i) | i >= 0    = "integer " ++ show i
               | otherwise = "I " ++ show (-i)
-}
--    show (Q i) | i >= 0    = "I " ++ show i
--               | otherwise = "I " ++ show (-i)
    show (R l) = "return address " ++ l
    show (S a) = "stack address " ++ show a
    show (H h) = "heap address " ++ show h

-- value arithmetic

max32bit :: Int32
max32bit = maxBound

min32bit :: Int32
min32bit = minBound

plus :: Monad m => Val -> Val -> m Val
plus (I i) (I j) = return $ I $ i + j
plus (I i) (S a) = return $ S $ a + fromIntegral i
plus (S a) (I i) = return $ S $ a + fromIntegral i
plus (I i) (H a) = return $ H $ a { disp = (disp a) + fromIntegral i }
plus (H a) (I i) = return $ H $ a { disp = (disp a) + fromIntegral i }
plus x y = fail $ "cannot add " ++ show x ++ " and " ++ show y

minus :: Monad m => Val -> Val -> m Val
minus (I i) (I j) = return $ I $ i - j
minus (S a) (I i) = return $ S $ a - fromIntegral i
minus (H a) (I i) = return $ H $ a { disp = (disp a) - fromIntegral i }
minus x y = fail $ "cannot subtract " ++ show y ++ " from " ++ show x

-- this should be 32bit unsigned multiplication (for address scaling)
-- but not yet implemented
times :: Monad m => Val -> Val -> m Val
times x@(I i) y@(I j) = do
  let r = (toInteger i) * (toInteger j)
  if r <= toInteger max32bit && r >= toInteger min32bit then return $ I $ fromIntegral r
   else fail $ "overflow in multiplication of " ++ show x ++ " and " ++ show y
  -- return $ Q $ fromIntegral r
times x y = fail $ "cannot multiply " ++ show x ++ " and " ++ show y

-- divBy :: Monad m => Val -> Val -> m Val
-- divBy (Q i) (I j) | j /= 0 = return $ I $ i `div` j -- (toInteger j)
-- divBy x y = fail $ "cannot divide " ++ show x ++ " by " ++ show y

sal :: Monad m => Val -> Val -> m Val
sal (I i) (I j) = return $ I $ i `shiftL` (fromIntegral j)
sal x y = fail $ "cannot shift left " ++ show x ++ " by " ++ show y

sar :: Monad m => Val -> Val -> m Val
sar (I i) (I j) = return $ I $ i `shiftR` (fromIntegral j)
sar x y = fail $ "cannot shift right " ++ show x ++ " by " ++ show y

data LogOp = And | Or | Xor

toInt :: Bool -> Int32
toInt True = 1
toInt False = 0

logical :: Monad m => LogOp -> Val -> Val -> m Val
logical op (I i) (I j) =
  return (I (exec op i j))
  where exec And = (.&.)
        exec Or  = (.|.)
        exec Xor = (xor)
logical _ x y = fail $ "cannot perform logical operation on " ++ show x ++ " by " ++ show y

neg :: Monad m => Val -> m Val
neg (I i) = return $ I $ -i
neg x = fail $ "cannot negate " ++ show x

not :: Monad m => Val -> m Val
not (I i) = return (I (complement i))
not x = fail $ "cannot logically negate " ++ show x

inc :: Monad m => Val -> m Val
inc (I i) = return $ I $ i + 1
inc x = fail $ "cannot increase " ++ show x

dec :: Monad m => Val -> m Val
dec (I i) = return $ I $ i - 1
dec x = fail $ "cannot decrease " ++ show x

cmp :: Monad m => Val -> Val -> m Ordering
cmp (I i) (I j) = return $ compare i j
cmp x y = fail $ "cannot compare " ++ show x ++ " with " ++ show y

splitQ :: Int64 -> (Int32, Int32)
splitQ q = ( fromIntegral $ q `shiftR` 32
           , fromIntegral $ q .&. ((1 `shiftL` 32) - 1)
           )

joinQ :: (Int32, Int32) -> Int64
joinQ (h,l) = ((fromIntegral h) `shiftL` 32) .|. (fromIntegral l)

-- convert double word into quadword
cdq :: Monad m => Val -> m (Val, Val)
cdq (I i) = return $ fmap2 I $ splitQ (fromIntegral i)
cdq x = fail $ "cannot convert signed " ++ show x ++ " from 32bit to 64bit"

cqd :: Monad m => (Val,Val) -> m Val
cqd (I h, I l) = let i = joinQ (h, l) in
                 if  i >= fromIntegral min32bit && i <= fromIntegral max32bit then return $ I $ fromIntegral i
                  else fail $ "value " ++ show i ++ " does not fit into 32 bit"
cqd x = fail $ "cannot convert signed " ++ show x ++ " from 64bit to 32bit"

imul :: Monad m => Val -> Val -> m (Val, Val)
imul (I i) (I j) = do
  let r :: Int64 = fromIntegral $ (toInteger i) * (toInteger j)
  let (h,l) = splitQ r
  return (I h, I l)
imul x y = fail $ "cannot multiply " ++ show x ++ " and " ++ show y

idiv :: Monad m => (Val, Val) -> Val -> m Val
idiv (I h, I l) (I j) | j /= 0 =
  return $ I $ fromIntegral $ joinQ (h, l) `div` fromIntegral j
idiv x y = fail $ "cannot divide " ++ show x ++ " by " ++ show y

----------------------------------------------------------------------
-- Memory strips
----------------------------------------------------------------------

-- | Maps displacements (multiples of wordSize) to values.
type Mem = IntMap Val

-- | Checks validity of address indirectly by reporting
--   read of uninitialized cell.
memLookup :: (Monad m) => Int -> Mem -> m Val
memLookup a m
  | (a `mod` wordSize) /= 0 = fail "read: address not 32bit aligned"
  | otherwise =
      maybe (fail $ "trying to read from invalid memory address " ++ show a)
        return $ IntMap.lookup a m

-- | Warning: does not check validity of address, should be done before.
memInsert :: (Monad m) => Int -> Val -> Mem -> m Mem
memInsert a v m | (a `mod` wordSize) == 0 = return $ IntMap.insert a v m
                | otherwise = fail "write: address not 32bit aligned"

----------------------------------------------------------------------
-- Heap
----------------------------------------------------------------------

data HeapStrip                            -- size: # bytes
  = Block { size :: Int, strip :: Mem }
    deriving Show

stripLookup :: Monad m => Int -> HeapStrip -> m Val
stripLookup disp (Block _ strip) = memLookup disp strip

stripBlockInit :: Int -> HeapStrip
stripBlockInit size = Block size $ IntMap.fromList $
   map (\ i -> (i * wordSize, I 0)) $ [ 0 .. (size `div` wordSize) ]
   -- initialize class id (disp=0) as well (this is more liberal)


type FreeList = [Symbolic]

data Heap = Heap { hmap :: Map Symbolic HeapStrip , free :: FreeList }

emptyHeap :: Heap
emptyHeap = Heap { hmap = Map.empty , free = [ 0 .. ] }

heapLookup :: Monad m => HeapAddr -> Heap -> m Val
heapLookup a heap = do
    case Map.lookup (base a) (hmap heap) of   -- get heap strip
      Nothing -> fail $ "heapLookup: not a valid cell id " ++ show (base a)
      Just h -> do
        let i = (disp a)
        case stripLookup i h of
          Nothing -> fail $ "heapLookup failed for address " ++ show a ++ " in cell " ++ show h
          Just v -> return v

heapInsert :: Monad m => HeapAddr -> Val -> Heap -> m Heap
heapInsert a v heap = do
    (h :: HeapStrip) <- maybe (fail $ "when trying to write to memory: invalid address " ++ show a) return $
           Map.lookup (base a) (hmap heap)     -- get heap strip
    let i = disp a
    -- check whether we are in bounds of the heap strip
    when (i < 0 || i >= size h) $
      fail $ "attempted write of " ++ show v ++ " to invalid heap address " ++ show a
    m' <- memInsert i v (strip h)     -- modify strip
    let h' = h { strip = m' }         -- insert back into heap
    return $ heap { hmap = Map.insert (base a) h' (hmap heap) }


-- | Entry point for simulator.
heapAllocBlock :: Int -> Heap -> (HeapAddr, Heap)
heapAllocBlock size = heapAlloc (Block size IntMap.empty)
  where
    heapAlloc :: HeapStrip -> Heap -> (HeapAddr, Heap)
    heapAlloc o (Heap h (x:xs)) = (HeapAddr x 0, Heap (Map.insert x o h) xs)
    heapAlloc _ (Heap _ []) = error "impossible: heapAlloc: out of heap space"

heapInitBlock :: Monad m => HeapAddr -> Int -> Heap -> m Heap
heapInitBlock a size heap = do
  case Map.lookup (base a) (hmap heap) of
    Nothing -> fail $ "heapInitObj: not a valid cell id " ++ show (base a)
    Just (Block size' _) | size /= size' -> fail $ "heapInitObj: object at " ++ show (base a) ++ " has size " ++ show size' ++ " but it was requested to initialize " ++ show size ++ " bytes"
    Just (Block _ _) -> return $
      heap { hmap = Map.insert (base a) (stripBlockInit size) (hmap heap) }



----------------------------------------------------------------------
-- Stack
----------------------------------------------------------------------

type Stack = Mem

stackTop :: Int
stackTop = 0

-- stack operations

type StackBounds = (Int, Int)  -- top address, current esp

stackLookup :: (Monad m) => StackBounds -> StackAddr -> Mem -> m Val
stackLookup (top , bot) a m
  | a <= top && a >= bot =
#if __GLASGOW_HASKELL__ == 606
                IntMap.lookup a m
#else
                case IntMap.lookup a m of
                   Nothing -> fail $ "failed to lookup stack address (uninitialized stack location?): " ++ show a
                   Just x  -> return x
#endif
  | otherwise = fail $ "read from invalid stack address" ++ show a ++ "; valid range is " ++ show bot ++ " to " ++ show top

stackInsert :: (Monad m) => StackBounds -> StackAddr -> Val -> Mem -> m Mem
stackInsert  (top , bot) a v m
  | a <= top && a >= bot = return $ IntMap.insert a v m
  | otherwise = fail $ "write to invalid stack address" ++ show a ++ "; valid range is " ++ show bot ++ " to " ++ show top

-- shrinking a stack will cause deletion of stack entries
stackResize :: StackAddr -> StackAddr -> Mem -> Mem
stackResize oldsp newsp m
  | newsp >= oldsp = m
  | otherwise      = stackResize oldsp (newsp + wordSize) (IntMap.delete newsp m)

----------------------------------------------------------------------
-- Register file
----------------------------------------------------------------------

{-
-- caller saved registers
data CoreRegs = CoreRegs { _eax , _ebx , _ecx , _edx , _esi , _edi  :: Val }
data CoreRegFile = CoreRegFile { coreRegs :: CoreRegs , temps :: Map Temp Val }

-- all registers
-- data RegFile = RegFile { coreRegFile :: CoreRegFile , _ebp , _esp :: Val }
-}

type TempFile = Map Temp  Val  --optimize: IntMap
type Regs     = Map Reg32 Val

data RegFile = RegFile
  { regs  :: Regs
  , temps :: TempFile
  }

initRegFile :: RegFile
initRegFile =
  RegFile { regs = Map.fromList
                   [ (esp, S stackTop)
                   , (ebp, S stackTop)
                   , (eax, I 0)
                   , (ebx, I 0)
                   , (ecx, I 0)
                   , (edx, I 0)
                   , (esi, I 0)
                   , (edi, I 0)
                   ]
          , temps = Map.empty
          }

updateRegs :: (Regs -> Regs) -> RegFile -> RegFile
updateRegs f rf = rf { regs = f (regs rf) }

updateTemps :: (TempFile -> TempFile) -> RegFile -> RegFile
updateTemps f rf = rf { temps = f (temps rf) }

-- register operations

regLookup :: (Monad m) => Reg -> RegFile -> m Val
regLookup (Fixed r) rf =
  case Map.lookup r (regs rf) of
     Just x -> return x
     Nothing -> fail ("register " ++ show r ++ " is dirty, has possibly undefined value")
regLookup (Flex t)  rf =
  case Map.lookup t (temps rf) of
     Just x -> return x
     Nothing -> fail ("unknown temporary '" ++ show t ++ "'")

-- can only write stack addresses to bp, sp
regInsert :: (Monad m) => Reg -> Val -> RegFile -> m RegFile
regInsert dest v =
  case dest of
    Fixed (Reg32 n) | isStackReg n, isNothing (isStackAddr v) ->
      const $ fail "write of non-stack address to stack register"
    Fixed r -> return . updateRegs  (Map.insert r v)
    Flex  t -> return . updateTemps (Map.insert t v)
  where isStackReg n = n == ebp || n == esp

regDelete :: Reg -> RegFile -> RegFile
regDelete (Fixed r) = updateRegs  $ Map.delete r
regDelete (Flex t)  = updateTemps $ Map.delete t

----------------------------------------------------------------------
-- Flags
----------------------------------------------------------------------

type Flags = Ordering -- imperfect implementation for now

trueCond :: Cond -> Flags -> Bool
trueCond Intel.E  EQ = True
trueCond Intel.NE LT = True
trueCond Intel.NE GT = True
trueCond Intel.L  LT = True
trueCond Intel.LE LT = True
trueCond Intel.LE EQ = True
trueCond Intel.G  GT = True
trueCond Intel.GE EQ = True
trueCond Intel.GE GT = True
trueCond _ _ = False

----------------------------------------------------------------------
-- State of the Simulator
----------------------------------------------------------------------

data St = St { regFile :: RegFile
             , eflags :: Flags
             , stack :: Stack
             , heap :: Heap
             , rfStack :: [TempFile]
--             , epc :: [Instr]
             }

initSt :: St
initSt = St initRegFile EQ IntMap.empty emptyHeap []

----------------------------------------------------------------------
-- Memory State       (all forms of memory : register, heap, stack) --
----------------------------------------------------------------------

-- all ops can raise exception
class Monad m => MonadMemSt m where

  getReg  :: Reg -> m Val
  getReg' :: Reg -> m (Maybe Val)
  setReg  :: Reg -> Val -> m ()
  polluteReg :: Reg -> m ()
  polluteCallerSave :: m ()

  getFlags :: m Flags
  setFlags :: Flags -> m ()

  getAddr :: Addr -> m Val
  setAddr :: Addr -> Val -> m ()

  getArg           :: Int -> m Val -- inspect argument in procedure (after call)
  getArgBeforeCall :: Int -> m Val -- inspect argument before call has happened

  saveRegs    :: m ()             -- save temporaries
  restoreRegs :: m ()             -- restore temporaries


-- , MonadError String m
instance (MonadState St m) => MonadMemSt m where

  -- reading/writing a register

  getReg r = do
    st <- get
    regLookup r (regFile st)

  getReg' r = do
    st <- get
    return (regLookup r (regFile st))

  setReg r v = do
    st <- get
    rf <- regInsert r v (regFile st)
    put $ st { regFile = rf }

  polluteReg r = do
    st <- get
    put $ st { regFile = regDelete r (regFile st) }

  polluteCallerSave = mapM_ polluteReg callerSave

  -- reading/writing flags

  getFlags = gets eflags

  setFlags f = do
    st <- get
    put $ st { eflags = f }

  -- reading from memory

  getAddr (H a) = do
    st <- get
    heapLookup a (heap st)

  getAddr (S a) = do
    st <- get
    S sp <- regLookup esp (regFile st)
    v  <- stackLookup (stackTop, sp) a (stack st)
    return v

  getAddr a =
    fail $ "memory lookup failure: " ++ show a ++ " is not an address"

  -- writing to memory

  setAddr (H a) v = do
    st <- get
    heap' <- heapInsert a v (heap st)
    put $ st { heap = heap' }

  setAddr (S a) v = do
    st <- get
    S sp <- regLookup esp (regFile st)
    stack' <-  stackInsert (stackTop, sp) a v (stack st)
    put $ st { stack = stack' }

  setAddr a _ =
    fail $ "memory write failure: " ++ show a ++ " is not an address"

  -- getting the nth procedure argument

  getArg n = do
    bp <- getReg ebp
    plus bp (I $ fromIntegral $ (n+2)*wordSize) >>= getAddr

  getArgBeforeCall n = do
    sp <- getReg esp
    plus sp (I $ fromIntegral $ n * wordSize) >>= getAddr


  -- pushing/popping register file

  saveRegs = do
    st <- get
    put $ st { rfStack = (temps $ regFile st) : (rfStack st) }

  -- restore register file except stack registers bp, sp
  restoreRegs = do
    st <- get
    when (null (rfStack st)) $
      fail "restore failed: register file stack empty"
    let (tf : tfs) = (rfStack st)
{-
    bp <- regLookup ebp (regFile st)
    sp <- regLookup esp (regFile st)
    let rf'  = Map.insert ebp bp rf
    let rf'' = Map.insert esp sp rf
-}
    let rf' = (regFile st) { temps = tf }
    put $ st { regFile = rf' , rfStack = tfs }

-- evaluating expressions (registers or effectively addressed cells)

class Eval m a where
  eval :: a -> m Val

instance Monad m => Eval m Int32 where
  eval i = return $ I i

instance Monad m => Eval m Scale where
  eval S2 = return $ I 2
  eval S4 = return $ I 4
  eval S8 = return $ I 8

instance Monad m => Eval m (Maybe Scale) where
  eval Nothing = return $ I 1
  eval (Just s) = eval s

instance MonadMemSt m => Eval m Reg where
  eval r = getReg r

-- a non-spec reg evals to 0 in an effective address
instance MonadMemSt m => Eval m (Maybe Reg) where
  eval Nothing = return $ I 0
  eval (Just r) = eval r

instance MonadMemSt m => Eval m EA where
  eval (r, ms, mr, i) = do
    base  <- eval mr
--    scale <- eval ms
    index <- eval r
    disp  <- eval i
    sci   <- flip (maybe (return index)) ms $ \ s ->
      times index =<< eval s
    offs  <- plus sci disp
    plus base offs

instance MonadMemSt m => Eval m Dest where
  eval (Reg r) = eval r
  eval (Mem r ms mr i) = do
    addr  <- eval (r, ms, mr, i)
    getAddr addr

instance MonadMemSt m => Eval m Src where
  eval (Imm i) = return $ I i
  eval (Dest d) = eval d

-- execute control-free statements

class ControlFree m where
  writeDest :: Dest -> Val -> m ()
  push      :: Val -> m ()
  pop       :: m Val

  execMov   :: Dest -> Src -> m ()
  execBin   :: DS -> Dest -> Src -> m ()
  execShift :: DS -> Dest -> Src -> m ()
  execLea   :: Reg -> EA -> m ()
  execCmp   :: Dest -> Src -> m ()
  execPop   :: Dest -> m ()
  execUn    :: D -> Dest -> m ()
  execPush  :: Src -> m ()
  execIMul  :: Src' -> m ()
  execIDiv  :: Src' -> m ()
  execCDQ   :: m ()
  execEnter :: Int32 -> m ()
  execLeave :: m ()

  execControlFree :: Instr -> m ()

instance MonadMemSt m => ControlFree m where

  writeDest (Reg r)         v = setReg r v
  writeDest (Mem r ms mr i) v = do
    addr <- eval (r, ms, mr, i)
    setAddr addr v

  execMov d s = eval s >>= writeDest d

  -- special case for XOR dest, dest
  -- this sets dest := 0 even if dest was undefined
  execBin XOR d (Dest d') | d == d' = writeDest d (I 0)

  -- can be optimized using LVal :
  execBin op d s = do
    x <- eval d
    y <- eval s
    let f = case op of
              ADD -> plus
              SUB -> minus
              IMUL2 -> times
              AND -> logical And
              OR  -> logical Or
              XOR -> logical Xor
              _   -> fail "internal error: execBin called with wrong first argument"
    f x y >>= writeDest d
   -- shorter: liftM2 f (eval d) (eval s) >>= writeDest d

  execShift op d (Imm i) = do
    x <- eval d
    let f = case op of
              SHL -> sal
              SHR -> sar -- unsigned shifts not properly supported by Haskell
              SAL -> sal -- no typo!  sal == shl
              SAR -> sar
              _   -> fail "internal error: execShift called with wrong first argument"
    f x (I i) >>= writeDest d

  execShift _ _ _ =
    fail "execShift: shift operations (shl, shr, sal, sar) only supported when second operand is an immediate number."

  execLea r ea = do
    x <- eval ea
    setReg r x

  execCmp d s = do
    x <- eval d
    y <- eval s
    r <- cmp x y
    setFlags r

  pop = do
    sp <- getReg esp
    v  <- getAddr sp
    sp' <- plus sp (I $ fromIntegral wordSize)
    setReg esp sp'
    return v

  execPop d = pop >>= writeDest d

  push v = do
    sp <- getReg esp
    sp' <- minus sp (I $ fromIntegral wordSize)
    setReg esp sp'
    setAddr sp' v

  execPush s = eval s >>= push

  execUn op d = do
    v <- eval d
    let f = case op of
              NEG -> neg
              NOT -> not
              INC -> inc
              DEC -> dec
              _   -> fail "internal error: execUn called with wrong first argument"
    f v >>= writeDest d

  execIMul s = do
    x <- eval s
    y <- getReg eax
    (dx,ax) <- imul x y
    setReg eax ax
    setReg edx dx
    -- also OF and CF need to be cleared if result is 32bit

{-
    z <- times x y
    setReg eax z     -- simplified treatment of overflow
    polluteReg edx   -- just destroy edx
-}

  execIDiv s = do
    h <- getReg edx
    l <- getReg eax
    y <- eval s
    z <- (h,l) `idiv` y
    setReg eax z
    polluteReg edx -- remainder sits in edx, we do not simulate this

  execCDQ = do
    x <- getReg eax
    (h,l) <- cdq x
    setReg edx h
    setReg eax l

{- not a intel instruction
  execCQD = do
    h <- getReg edx
    l <- getReg eax
    x <- cqd (h,l)
    setReg eax x
-}

  execEnter n = execPush ebp >> execMov ebp esp >> execBin SUB esp (Imm n)

  execLeave = execMov esp ebp >> execPop ebp

  execControlFree i =
--    trace ("executing " ++ show i) $
      case i of
        (LEA r ea)   -> execLea r ea
        (CMP d s)    -> execCmp d s
        (DS MOV d s) -> execMov d s
        (DS b d s)   -> if isShift b then execShift b d s else execBin b d s
        (D POP d)    -> execPop d
        (D u d)      -> execUn u d
        (PUSH s)     -> execPush s
        (IMUL s)     -> execIMul s
        (IDIV s)     -> execIDiv s
        (CDQ)        -> execCDQ
        (ENTER n)    -> execEnter n
        (LEAVE)      -> execLeave
        (NOP)        -> return ()
        _            -> fail "internal error: execControlFree called with control instruction"

--  execDS instr d s = do



----------------------------------------------------------------------
-- Control
----------------------------------------------------------------------

-- handling of code, PC
-- handling of flags

-- reader monad : frames, blocks
-- state  monad : current block (instr list), flags

{-
data ControlSt = ControlSt { epc :: [Instr] , mem :: MemSt }

instance MonadState ControlSt m => MonadState MemSt m where
  get = (gets mem :: m MemSt)
  put m = do
    st <- get :: m ControlSt
    put $ st { mem = m }
-}


class BlockServer m where
  getFrame :: Label -> m IBlockFrame
  getBlock :: Label -> m IBlock
  loadFrame :: Label -> m a -> m a

data FlowChart = FlowChart { frames       :: FrameMap
                           , currentFrame :: Label
                           }

instance (MonadReader FlowChart m) => BlockServer m where

  getFrame l = do
    fs <- asks frames
    maybe (fail $ "not a valid fragment label: " ++ show l) return $ Map.lookup l fs

  getBlock l = do
    st <- ask
    let IBlockFrame _ _ blocks = fromJust $ Map.lookup (currentFrame st) (frames st)
    maybe (fail $ "not a valid local label: " ++ show l) return $ Map.lookup l blocks

  loadFrame l = local (\ st -> st { currentFrame = l })

{-
data FlowChart = FlowChart { frames :: FrameMap
                           , blocks :: IBlockMap
                           }

instance (MonadReader FlowChart m) => BlockServer m where
  getFrame l = asks frames >>= Map.lookup l
  getBlock l = asks blocks >>= Map.lookup l
  loadFrame l = local (
-}

{-
-- execute control-flow statements

class ControlFlow m where
  jump :: Label -> m ()
  cjump :: Cond -> Label -> m ()
  call :: Label -> m ()
  ret :: Label -> m ()

-- etc

instance (BlockServer m, MonadState St m) => ControlFlow m where

  -- local jump within the same frame
  jump l = do
    st <- get
    block <- getBlock l
    put $ st { epc = block }

  cjump c l = do
   flags <- getFlags
   if trueCond c flags then jump l else return ()

  call l = do
    saveRegs
    saveReturn
    frame <- getFrame l
-}

----------------------------------------------------------------------
-- Runtime environment
----------------------------------------------------------------------

type Output = [String]
data CharOrInt = Char | Int

class Runtime m where

  print :: CharOrInt -> Val -> m ()
  allocBlock :: Val -> m Val
  initBlock :: Val -> Val -> m ()

instance (MonadWriter Output m, MonadState St m) => Runtime m where

  -- print = tell . show
  print Char (I i) = tell $ [[chr . fromIntegral . toInteger $ i]]
  print Int  (I i) = tell $ [show i ++ "\n"]
  print _ x = fail $ "cannot print " ++ show x

  allocBlock (I i) = do
    st <- get
    let (addr, heap') = heapAllocBlock (fromIntegral i) (heap st)
    put $ st { heap = heap' }
    return $ H addr

  allocBlock x = fail $ "cannot allocate object of size " ++ show x

  initBlock (H addr) (I i) = do
    st <- get
    heap' <- heapInitBlock addr (fromIntegral i) (heap st)
    put $ st { heap = heap' }

  initBlock x y = fail $ "cannot init " ++ show y ++
                       " bytes of object " ++ show x


----------------------------------------------------------------------
-- Simulator
----------------------------------------------------------------------

getArgsBeforeCall :: MonadMemSt m => [Acc] -> m [Val]
getArgsBeforeCall [] = return []
getArgsBeforeCall (InFrame i : acc) = do
  v <- getArgBeforeCall (i `div` wordSize)
  vs <- getArgsBeforeCall acc
  return (v : vs)
getArgsBeforeCall (InReg t : acc) = do
  v <- getReg (temp t)
  vs <- getArgsBeforeCall acc
  return (v : vs)

traceCall :: (BlockServer m, MonadMemSt m) => Label -> m a -> m a
traceCall l cmd = do
  IBlockFrame _ dat _ <- getFrame l
  args <- getArgsBeforeCall (parameters dat)
  trace ("calling " ++ show l ++ show args) $ cmd

traceReturn :: (MonadMemSt m) => m a -> m a
traceReturn cmd = do
  sp <- getReg esp
  addr <- getAddr sp
  case addr of
     R l -> do
        v <- getReg' eax -- may not return something
        trace (show l ++ " returns " ++ show v) $ cmd
     _    ->
        fail "trying to execute 'ret' when the stack does not contain a return address"

class Simulator m where
  exec :: IBlock -> m ()
  exec' :: Instr -> IBlock -> m ()
  doPrint :: CharOrInt -> IBlock -> m ()

instance (BlockServer m, MonadMemSt m, ControlFree m, Runtime m) => Simulator m where

  exec [] = return ()
  exec (i : is) = do
    trace ("executing " ++ show i) $
     exec' i is

  doPrint coi is = do
    v <- getArgBeforeCall 0
    print coi v
    polluteCallerSave
    setReg eax (I 0) -- ULI: void gibt es bei uns nicht
    exec is

  exec' (CALL "L_raise") _ = do
    v <- getArgBeforeCall 0
    fail $ "exception " ++ show v ++ " raised"

  exec' (CALL "L_println_int") is = doPrint Int is
  exec' (CALL "L_print_char")  is = doPrint Char is

  exec' (CALL "L_halloc") is = do
    v <- getArgBeforeCall 0
    a <- allocBlock v
    initBlock a v
    polluteCallerSave
    setReg eax a
    exec is

  exec' (CALL l) is = traceCall l $ do
    saveRegs
    push (R l)  -- push return address
    loadFrame l $ do
      pc <- getBlock l -- retrieve first block of new frame
      exec pc          -- run proc. code (Haskell call)
    exec is

  -- NOTE: traceReturn ensures that there is a return address on top
  -- of stack
  exec' (RET) _ = traceReturn $ do
    (R _) <- pop -- pop return address
    restoreRegs  -- and return (Haskell return)

{-
  exec' (RET) _ = traceReturn $ do
    a <- pop -- pop return address
    case a of
      R{} -> return ()
      _   -> fail $ "RET: expected return address on top of stack, but found " ++ show a
    restoreRegs  -- and return (Haskell return)
-}

  exec' (JMP l) _ = do
    pc <- getBlock l
    exec pc

  exec' (J c l) is = do
    flags <- getFlags
    if trueCond c flags then getBlock l >>= exec else exec is

  exec' i is = execControlFree i >> exec is

-- simulator Monad

newtype Sim a = Sim { unSim ::
                         (StateT St
                          (ReaderT FlowChart
                            (ErrorT String
                             (Writer Output)))) a }
  deriving (Monad, MonadReader FlowChart, MonadState St)

run :: FrameMap -> Label -> (Either String (), Output)
run fs l = runWriter $ runErrorT $
  exec [CALL l] `evalStateT` initSt `runReaderT` (FlowChart fs l)
