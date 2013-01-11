module Cut where

import Company
import BX
import Data.Foldable
import Data.Monoid

cut :: Company -> Company
cut c = put fs' c
  where
    fs = toList (get c)
    fs' = map (/2) fs
