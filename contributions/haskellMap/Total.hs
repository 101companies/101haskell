module Total where

import Company

total :: Company -> Float
total (n, es) = sum (map totalE es)
  where
    totalE :: Employee -> Float
    totalE (_, _, s) = s
