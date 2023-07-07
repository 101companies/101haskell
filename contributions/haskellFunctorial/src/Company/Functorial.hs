module Company.Functorial where

import Company.Data

instance Functor Company
  where
    fmap f (Company n ds) = Company n ds'
      where
        ds' = map (fmap f) ds

instance Functor Department
  where
    fmap f (Department n m ds es) = Department n m' ds' es'
      where
        m' = fmap f m
        ds' = map (fmap f) ds
        es' = map (fmap f) es

instance Functor Employee
  where
    fmap f (Employee n a s) = Employee n a (f s)

instance Foldable Company
  where
    foldMap f (Company _ ds) = ds'
      where
        ds' = mconcat (map (foldMap f) ds)

instance Foldable Department
  where
    foldMap f (Department _ m ds es) = m' `mappend` ds' `mappend` es'
      where
        m' = foldMap f m
        ds' = mconcat (map (foldMap f) ds)
        es' = mconcat (map (foldMap f) es)

instance Foldable Employee
  where
    foldMap f (Employee _ _ s) = f s
