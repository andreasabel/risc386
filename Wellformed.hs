{-# LANGUAGE FlexibleInstances #-}

module Wellformed where

import qualified Data.Foldable as Fold
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Monoid


import Frame
import Intel

-- | Check if expression is well-formed.
--   If not fail with some meaningfull error messages
class Wellformed a where
  wellformed :: a -> Either String ()

enter :: Monoid a => a -> Either a b -> Either a b
enter msg = either (Left . (msg `mappend`)) Right

instance Wellformed (Dest, Src) where
  wellformed p =
    case p of
      (Mem{}, Dest(Mem{})) -> Left "at most one operand can access the memory, the other must be a register or immediate (source only)"
      _ -> return ()

instance Wellformed Instr where
  wellformed i = enter (show i ++ "\n") $
    case i of
      DS ds d s -> wellformed (d,s)
      CMP d s   -> wellformed (d,s)
      _         -> return ()

instance Wellformed a => Wellformed [a] where
  wellformed = mapM_ wellformed

instance Wellformed a => Wellformed (Frame a) where
  wellformed (Frame name _ a) = enter (name ++ ":\n") $ wellformed a

instance Wellformed a => Wellformed (Map k a) where
  wellformed = Fold.mapM_ wellformed
