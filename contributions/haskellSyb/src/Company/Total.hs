module Company.Total where

import Company.Data
import Company.Deriving
import Data.Generics

total :: Company -> Float
total = everything (+) (extQ (const 0) id)
