module Company.Total where

import Company.Data
import Company.Functorial
import Data.Monoid

total :: Company Float -> Float
total = getSum . foldMap Sum
