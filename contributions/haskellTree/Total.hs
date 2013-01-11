module Total where

import Company
import BX
import Data.Foldable
import Data.Monoid

total :: Company -> Float
total = getSum . foldMap Sum . get
