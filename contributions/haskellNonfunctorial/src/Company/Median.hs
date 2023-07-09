module Company.Median where

import Company.Data
import Company.Traversal
import Data.List (sort)

median :: Company -> Float
median c = sort ss!!(length ss `div` 2)
  where
    ss = getSalariesFromCompany c
