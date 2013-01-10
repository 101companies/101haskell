module Cut where

import Company

cut :: Company -> Company
cut (n, ds) = (n, (map cutD ds))
  where
    cutD :: Department -> Department
    cutD (n, m, es) = (n, (cutE m), (map cutE es))
      where
        cutE :: Employee -> Employee
        cutE (n, a, s) = (n, a, (s/2))
