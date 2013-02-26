module Company.Total where

import Company.Data
import Company.Algebra
import Data.Monoid

total :: Company -> Float
total = getSum . foldCompany totalAlgebra
  where
    totalAlgebra
      = mconcatCompany {
          atEmployee = \n a s -> Sum s
        }
