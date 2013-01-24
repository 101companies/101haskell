module Total where

import Company

total :: Company -> Float
total (n, ds) = sum (map totalD ds)
  where
    totalD :: Department -> Float
    totalD (_, m, es)
      = sum (map totalE (m:es))
      where
        totalE :: Employee -> Float
        totalE (_, _, s) = s
