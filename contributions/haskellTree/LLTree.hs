-- Leaf-labeled rose trees

module LLTree where

import Prelude hiding (foldr, concat)
import Data.Functor
import Data.Foldable

data LLTree a = Leaf a | Fork [LLTree a]
  deriving (Eq, Show, Read)

instance Functor LLTree
  where
    fmap f (Leaf a) = Leaf (f a)
    fmap f (Fork ts) = Fork (fmap (fmap f) ts)

instance Foldable LLTree
  where
    foldr f z (Leaf a) = f a z
    foldr f z (Fork ts) = foldr f z (concat (fmap toList ts))
