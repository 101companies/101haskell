module Company.Total where

import Company.Data
import Company.Generics
import Data.Generics

-- Total all salaries in a company
total :: Company -> Float
total = everything (+) (extQ (const 0) id)
