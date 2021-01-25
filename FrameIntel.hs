{-# LANGUAGE UndecidableInstances, TypeSynonymInstances, FlexibleInstances,
      GeneralizedNewtypeDeriving #-}

-- this module is part of the risc386 simulator (IntelMain)

module FrameIntel where

-- import Data.List -- reverse
import Data.Map (Map)
import qualified Data.Map as Map
import Text.PrettyPrint

import Util -- splitmap
import GenSym
import Frame
import Intel
-- import TreePrinter (Pretty(..))

type IntelFrame = Frame [Instr]

-- data IntelFrame = IntelFrame String [Acc] [Instr]

instance Pretty IntelFrame where
    ppr (Frame f dat il) = 
      nest 8 (text ".global" <+> nest 8 (text f))
      $+$ nest 8 (text ".type" <+> nest 8 (text f <> comma <+> text "@function"))
      $+$ text f <> colon
      $+$ nest 8 (text "#args" <+> (hsep $ punctuate comma $ map ppr (parameters dat)))
      $+$ ppr il

instance Pretty [IntelFrame] where
   ppr fs = nest 8 (text ".intel_syntax")
            $+$ (vcat $ map ppr fs)

{- The code of each function is split up into a collection of blocks,
   beginning with a LABEL, ending with a JMP or RET.

   No LABEL within a block.

-}

type IBlock = [Instr]
type IBlockMap = Map Label IBlock

data IBlockFrame = IBlockFrame 
  String      -- name of the function 
  FrameData  -- list of parameters
  IBlockMap  -- map from labels to blocks (contains at least first label)

type FrameMap = Map Label IBlockFrame

instance Pretty IBlockFrame where
    ppr (IBlockFrame f dat blocks) 
        | Just (b1, rest) <- splitMap f blocks = 
      nest 8 (text ".global" <+> nest 8 (text f))
      $+$ nest 8 (text ".type" <+> nest 8 (text f <> comma <+> text "@function"))
      $+$ text f <> colon
      $+$ nest 8 (text "#args" <+> (hsep $ punctuate comma $ map ppr (parameters dat)))
      $+$ ppr b1 
      $+$ ppr (Map.foldrWithKey (\ k rs ss -> LABEL k : rs ++ ss) [] rest)

instance Pretty [IBlockFrame] where
   ppr fs = vcat $ map ppr fs

-- divide a frame into blocks ;  
-- the first block inherits its label from the frame
iBlocksFrame :: IntelFrame -> IBlockFrame
iBlocksFrame (Frame f dat ss) =
  (IBlockFrame f dat (insertIBlocks (LABEL f : ss) Map.empty))

  
-- insertBlocks (ss, map_acc) = map
insertIBlocks :: [Instr] -> IBlockMap -> IBlockMap
insertIBlocks [] acc = acc
insertIBlocks (LABEL l : ss) acc =
  let (block, rest) = chopOffIBlock ss
  in insertIBlocks rest (Map.insert l block acc)  
insertIBlocks ss acc = insertIBlocks (LABEL ("Ldummy" ++ show (length ss))  : ss) acc

-- chopOffBlock (l', ss) = (l, block, rest)
-- Precondition: ss begins with LABEL l
chopOffIBlock :: [Instr] -> ([Instr], [Instr])
chopOffIBlock ss =    
  let (block, rest) = chopOffIBlock' ss []
  in  (reverse block, rest)

-- chopOffBlock' ss block_acc = (rev_block, ss_rest)
chopOffIBlock' :: [Instr] -> [Instr] -> ([Instr], [Instr])
chopOffIBlock' [] acc = error "Reached the end of a block that does not end with a label or a jump. The last instruction must be a jump, typically 'ret'."
chopOffIBlock' ss@(LABEL l : _) acc = (JMP l : acc, ss) -- insert artificial jump 
chopOffIBlock' (s@RET : ss) acc =  (s : acc, ss)
chopOffIBlock' (s@(JMP _) : ss) acc =  (s : acc, ss)
-- conditional jump not the end of a block
-- chopOffIBlock' (s@(J _ _) : ss) acc = (s : acc, ss) 
chopOffIBlock' (s : ss) acc = chopOffIBlock' ss (s : acc)  
 
