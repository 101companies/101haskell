module Company.Cut where

import Company.Data
import Company.BX
import Data.Foldable
import Data.Monoid

cut :: Company -> Company
cut c = put fs' c
  where
    fs = toList (get c)
    fs' = map (/2) fs
