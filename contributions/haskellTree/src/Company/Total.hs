module Company.Total where

import Company.Data
import Company.BX
import Data.Foldable
import Data.Monoid

total :: Company -> Float
total = getSum . foldMap Sum . get
