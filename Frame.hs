{- Abstract frames

* store how to access parameters (in frame or in reg)
* how many registers (of the callee saves) are pushed on the stack upon entry
* how many local variables are in the stack

-}

module Frame where

import Data.Map (Map)
import qualified Data.Map as Map
import Text.PrettyPrint

import Util

import GenSym -- Label, Temp

-- data structures for top level

wordSize = 4

mkName c m = "L"++c++"$"++m


-- parameter

data Acc = InReg Temp
         | InFrame Int

instance Pretty Acc where
    ppr (InReg t)   = text "REG" <+> ppr t
    ppr (InFrame i) = text "LOC" <+> int i

instance Show Acc where
    show = render . ppr


-- create a new formal parameter (register/stack frame)

mkPar :: [Temp] -> Int -> Acc
mkPar argRegs n | n < (length argRegs) = let r = argRegs !! n in InReg r
                | otherwise = InFrame (wordSize * n)


mkParams :: [Temp] ->  [a] -> [Acc]
mkParams argRegs ps = loop 0 ps
    where loop _ [] = []
          loop n (_:l) = mkPar argRegs n : loop (n+1) l

-- function

data FrameData = FrameData { parameters :: [Acc]
                           , numSaves   :: Int
                           , locals     :: Map Temp Int -- numbered form 0
                           }
               deriving Show

numLocals :: FrameData -> Int
numLocals dat = length (Map.elems (locals dat))

mkFrameData :: [Acc] -> FrameData
mkFrameData acc = FrameData acc 0 Map.empty

addLocal :: Temp -> FrameData -> FrameData
addLocal t dat = dat { locals = Map.insert t (numLocals dat) (locals dat) }

data Frame a = Frame { frameName :: String,
                       frameData :: FrameData,
                       frameContent :: a
                     }

-- program

data FrameColl a = FrameColl (Map String (Frame a))

