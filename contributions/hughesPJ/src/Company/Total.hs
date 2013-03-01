module Company.Total where

import Company.Data

total :: Company -> Float
total (Company n ds) = sum (map totalD ds)
  where
    totalD :: Department -> Float
    totalD (Department _ m ds es)
      = sum (totalE m : map totalD ds ++ map totalE es)
      where
        totalE :: Employee -> Float
        totalE (Employee _ _ s) = s
