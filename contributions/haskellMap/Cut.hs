module Cut where

import Company

cut :: Company -> Company
cut (n, es) = (n, (map cutE es))
  where
    cutE :: Employee -> Employee
    cutE (n, a, s) = (n, a, (s/2))
