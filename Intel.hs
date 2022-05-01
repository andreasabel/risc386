{-# LANGUAGE UndecidableInstances, TypeSynonymInstances, FlexibleInstances,
      GeneralizedNewtypeDeriving #-}

-- Intel Machine Instructions 386 32bit

-- we use only
--   32Bit Registers, signed 32Bit values

module Intel where

import Prelude hiding ((<>))

import Data.Char -- toLower
import Data.Int
import Data.List -- elemIndex
import Text.PrettyPrint

import GenSym
import Util  -- class Pretty

class Register a where
  eax :: a
  ebx :: a
  ecx :: a
  edx :: a
  esi :: a
  edi :: a
  ebp :: a
  esp :: a

instance Register Int where
  eax = 0  -- accumulator for MUL and DIV
  ebx = 1
  ecx = 2
  edx = 3  -- holds upper half of MUL/DIV result
  esi = 4
  edi = 5
  ebp = 6  -- frame pointer
  esp = 7  -- stack pointer

newtype Reg32 = Reg32 Int
    deriving (Eq, Ord)

regNames =  ["eax", "ebx", "ecx", "edx", "esi", "edi", "ebp", "esp"]

instance Show Reg32 where
  show (Reg32 r) = regNames !! (fromIntegral r)

instance Read Reg32 where
  readsPrec n s = case (elemIndex name regNames) of
                    Just r -> [(Reg32 $ fromIntegral r,rest)]
                    Nothing -> []
                  where (name, rest) = splitAt 3 s

instance Register Reg32 where
  eax = Reg32 eax
  ebx = Reg32 ebx
  ecx = Reg32 ecx
  edx = Reg32 edx
  esi = Reg32 esi
  edi = Reg32 edi
  ebp = Reg32 ebp
  esp = Reg32 esp


-- Intel specific implementation

callerSave :: Register a => [a]
callerSave = [ eax , ecx , edx ]

calleeSave :: Register a => [a]
calleeSave = [ ebx , esi , edi ]



-- temporaries

data Reg = Fixed { unFixed :: Reg32 } -- fixed register, cannot be changed
         | Flex  { unFlex  :: Temp  } -- a register to be assigned later
           deriving (Eq, Ord)

isReg32 :: Reg -> Bool
isReg32 (Fixed _) = True
isReg32 (Flex _)  = False

isTemp :: Reg -> Bool
isTemp (Fixed _) = False
isTemp (Flex _)  = True

instance Show Reg where
  show (Fixed r) = show r
  show (Flex t)  = show t

instance Temporary Reg where
  temp = Flex

instance Register Reg where
  eax = Fixed eax
  ebx = Fixed ebx
  ecx = Fixed ecx
  edx = Fixed edx
  esi = Fixed esi
  edi = Fixed edi
  ebp = Fixed ebp
  esp = Fixed esp

data Scale = S2 | S4 | S8 -- possible scaling values for effective addressing
           deriving (Eq)

toScale :: (Eq a, Num a) => a -> Maybe Scale
toScale 2 = Just S2
toScale 4 = Just S4
toScale 8 = Just S8
toScale _ = Nothing

-- parts of e.a.

type EA = (Reg, Maybe Scale, Maybe Reg, Int32)
type BiLinEA = (Reg, Maybe Scale, Maybe Reg)
type AffineEA = (Maybe Reg, Maybe Scale, Int32)
type LinEA = (Reg, Maybe Scale)

data Dest = Reg Reg     -- ^ a register
          |
            -- | full effective address
            Mem Reg                    -- @index@
                (Maybe Scale)          -- @* scale@
                (Maybe Reg)            -- @+ base@
                Int32                  -- @+ Displacement (8, 16, or) 32 bit@
            deriving (Eq)

instance Temporary Dest where
  temp = Reg . temp

instance Register Dest where
  eax = Reg eax
  ebx = Reg ebx
  ecx = Reg ecx
  edx = Reg edx
  esi = Reg esi
  edi = Reg edi
  ebp = Reg ebp
  esp = Reg esp

data Src = Imm Int32      -- immediate value
         | Dest Dest      -- or register or eff.addr.
           deriving (Eq)

type Src' = Dest   -- src which cannot be immed.

instance Temporary Src where
  temp = Dest . temp

instance Register Src where
  eax = Dest eax
  ebx = Dest ebx
  ecx = Dest ecx
  edx = Dest edx
  esi = Dest esi
  edi = Dest edi
  ebp = Dest ebp
  esp = Dest esp

data Cond = E | NE | L | LE | G | GE
               deriving (Eq, Show)

-- destructive instruction with dest. and source
data DS = MOV      -- dest := src, at least one of them a register
        | ADD      -- dest += src, flags carry
        | SUB      -- dest -= src
        | IMUL2    -- dest *= src
        | SHL      -- dest <<= imm
        | SHR      -- dest >>= imm
        | SAL      -- dest <<= imm (synonym to shl)
        | SAR      -- dest >>= imm (arithmetic right shift)
        | AND      -- dest &= src
        | OR       -- dest |= src
        | XOR      -- dest xor= src
               deriving (Eq, Show)

isShift :: DS -> Bool
isShift i = i `elem` [SHL,SHR,SAL,SAR]

-- destructive instruction with dest only
data D  = POP      -- pop off stack into dest, adding 4 to ESP
        | NEG      -- dest = -dest
        | NOT      -- dest := !dest
        | INC      -- dest++
        | DEC      -- dest--
               deriving (Eq, Show)

data Instr
  = DS DS Dest Src -- dest ?= src, not two mems
  | D  D  Dest     -- modifies dest
  | LEA Reg EA     -- load effective address into register
  | CMP Dest Src   -- not two mems, non-destructive
  | PUSH Src       -- push src onto stack, subtracting 4 from ESP
  | IMUL Src'      -- (edx, eax) := eax * src
  | IDIV Src'      -- eax := (edx, eax) div src,  edx := (edx,eax) mod src
  | CDQ            -- convert between signed 32bit and signed 64bit
--  | CQD            -- Convert Quadword Doubleword
  | JMP Label      -- jump, resolved by the assembler
  | J Cond Label   -- conditional jump
  | CALL Label     -- function call
  | RET            -- return from function call
  | ENTER Int32    -- set up local variables
  | LEAVE          -- esp := ebp, pop ebp
  | NOP            -- do nothing
  | LABEL Label

instance Pretty Reg32 where
  ppr = text . ('%':) . map toLower . show

instance Pretty Reg where
  ppr (Fixed r) = ppr r
  ppr (Flex  t) = ppr t

instance Pretty Scale where
  ppr S2 = text "2"
  ppr S4 = text "4"
  ppr S8 = text "8"

instance Pretty a => Pretty (Maybe a) where
  ppr Nothing  = empty
  ppr (Just a) = ppr a

ppr_displacement n
  | n == 0 = empty
  | n >  0 = text "+" <> text (show n)
  | n <  0 = text "-" <> text (show (-n))

sepBy :: Doc -> Doc -> Doc -> Doc
sepBy sep d1 d2 | isEmpty d2 = d1
                | isEmpty d1 = d2
                | otherwise  = d1 <> sep <> d2

instance Pretty EA where
  ppr (r, ms, mr, n) =
    (sepBy (text "+") (sepBy (text "*") (ppr r) (ppr ms)) (ppr mr))
      <> ppr_displacement n

instance Pretty Dest where
  ppr (Reg r)         = ppr r
  ppr (Mem r ms mr n) = text "DWORD PTR [" <> ppr (r,ms,mr,n) <> text "]"

instance Pretty Src where
  ppr (Dest d) = ppr d
  ppr (Imm i)  = text $ show i

instance Pretty Cond where
  ppr = text . map toLower . show

instance Pretty DS where
  ppr IMUL2 = text "imul"
  ppr ds    = text . map toLower . show $ ds

instance Pretty D where
  ppr = text . map toLower . show

instance Pretty Instr where
  ppr (DS c d s) = nest 8 $ ppr c $$ (nest 8 $ ppr d <> comma <+> ppr s)
  ppr (D c  d)   = nest 8 $ ppr c $$ (nest 8 $ ppr d)
  ppr (LEA r ea) = nest 8 $ text "lea"  $$ (nest 8 $ ppr r <> comma <+> (text "DWORD PTR [" <> ppr ea <> text "]"))
  ppr (CMP d s)  = nest 8 $ text "cmp"  $$ (nest 8 $ ppr d <> comma <+> ppr s)
  ppr (PUSH s)   = nest 8 $ text "push" $$ (nest 8 $ ppr s)
  ppr (IMUL s)   = nest 8 $ text "imul" $$ (nest 8 $ ppr s)
  ppr (IDIV s)   = nest 8 $ text "idiv" $$ (nest 8 $ ppr s)
  ppr (CDQ)      = nest 8 $ text "cdq"
--  ppr (CQD)      = nest 8 $ text "cqd"
  ppr (JMP l)    = nest 8 $ text "jmp"  $$ (nest 8 $ ppr l)
  ppr (J c l)    = nest 8 $ text "j" <> ppr c $$ (nest 8 $ ppr l)
  ppr (CALL l)   = nest 8 $ text "call" $$ (nest 8 $ ppr l)
  ppr (RET)      = nest 8 $ text "ret"
  ppr (ENTER i)  = nest 8 $ text "enter" $$ (nest 8 $ text (show i) <> comma <+> text "0")
  ppr (LEAVE)    = nest 8 $ text "leave"
  ppr (NOP)      = nest 8 $ text "nop"
  ppr (LABEL l)  = ppr l <> text ":"

instance Pretty [Instr] where
    ppr [] = empty
    ppr (s:ss) = (ppr s) $$ ppr ss


comment :: Doc -> Doc
comment d = text "/*" <+> d <+> text "*/"


instance Show Instr where
  show = render . ppr
