{-# LANGUAGE UndecidableInstances, PatternGuards #-}

module Util where

import Data.Map (Map)
import qualified Data.Map as Map

import Text.PrettyPrint

-- is power of 2

isEven :: Integral n => n -> Maybe n
isEven n = let (q,r) = n `quotRem` 2
           in if r == 0 then Just q else Nothing

isPower2 :: Integral n => n -> Maybe n
isPower2 1 = Just 0
isPower2 n | Just m <- isEven n = fmap (1+) (isPower2 m)
isPower2 _ = Nothing

-- convert a nothing into a failure

maybeM :: Monad m => String -> Maybe a -> m a
maybeM s (Nothing) = fail s
maybeM _ (Just a)  = return a

-- monadic head of a list

headM :: Monad m => [a] -> m a
headM []    = fail "head of empty list"
headM (a:_) = return a

-- index in an assoc list

lookupIndex :: (Eq a) => a -> [(a,b)] -> Maybe Int
lookupIndex _ [] = Nothing
lookupIndex a ((b,_):l) | a==b = Just 0
                        | otherwise = do i <- lookupIndex a l
                                         return $ i+1

-- analyse map in "head, tail"

splitMap :: (Monad m, Ord k, Eq k) => k -> Map k v -> m (v, Map k v)
splitMap k m  = case Map.lookup k m of
  Just v -> return $ (v, Map.delete k m)
  Nothing -> fail "splitMap"

-- monadic composition

infixl 1 -.-

(-.-) :: Monad m => (b -> m c) -> (a -> m b) -> a -> m c
(-.-) g f a = do b <- f a
                 g b

-- uncurry4

uncurry4 :: (a -> b -> c -> d -> e) -> (a,b,c,d) -> e
uncurry4 f (a,b,c,d) = f a b c d

-- mapping for pairs

fmap2 :: (a -> b) -> (a,a) -> (b,b)
fmap2 f (a,a') = (f a, f a')

-- pretty class

class Pretty a where
    ppr :: a -> Doc

{-
instance Pretty a => Show a where
  show = render . ppr
-}
