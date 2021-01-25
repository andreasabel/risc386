{-# LANGUAGE UndecidableInstances, TypeSynonymInstances, FlexibleInstances,
      GeneralizedNewtypeDeriving #-}

module GenSym where

import Control.Monad.State
import Text.PrettyPrint
import Util

-- temps

newtype Temp = Temp Int deriving (Eq, Ord, Enum)

instance Show Temp where
    show (Temp i) = "t" ++ show i

instance Pretty Temp where
    ppr t = text $ show t

class Temporary a where
    temp :: Temp -> a

instance Temporary Temp where
    temp = id

-- labels

newtype TempLabel = TempLabel Int deriving (Show, Eq, Ord, Enum)

type Label = String

mkLabel :: TempLabel -> Label
mkLabel (TempLabel i) = "L" ++ show i

instance Pretty Label where
    ppr l = text l


-- the mutable state of the translation process

data St = St { nextFreeTemp  :: Temp          -- next free temp
             , nextFreeLabel :: TempLabel }   -- next free label

initSt :: St
initSt = St (Temp 1000) (TempLabel 0)

-- class (Enum a, MonadState a m) => MonadGenSym m 
-- (too much abstraction:)

class MonadSt m where
    nextTemp  :: m Temp
    nextLabel :: m Label

instance MonadState St m => MonadSt m where
    nextTemp  = do St t l <- get
                   put $ St (succ t) l
                   return t
    nextLabel = do St t l <- get
                   put $ St t (succ l)
                   return $ mkLabel l
