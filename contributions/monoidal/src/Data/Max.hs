-- A data type for maxima
module Data.Max where

import Data.Monoid

-- A data type for maxima without default
data Ord x => Max x = Max { getMax :: Maybe x }

-- A monoid for maxima
instance Ord x => Monoid (Max x)
  where
    mempty = Max Nothing
    x `mappend` y
      = case (getMax x, getMax y) of
          (Nothing, m) -> Max m
          (m, Nothing) -> Max m
          (Just m1, Just m2) -> Max (Just (m1 `max` m2))
