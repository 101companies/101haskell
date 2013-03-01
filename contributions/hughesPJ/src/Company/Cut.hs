module Company.Cut where

import Company.Data

cut :: Company -> Company
cut (Company n ds) = Company n (map cutD ds)
  where
    cutD :: Department -> Department
    cutD (Department n m ds es)
      = Department n (cutE m) (map cutD ds) (map cutE es)
      where
        cutE :: Employee -> Employee
        cutE (Employee n a s) = Employee n a (s/2)
