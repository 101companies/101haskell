module Company.Cut where

import Company.Data
import Company.Generics
import Data.Generics

-- Cut all salaries in a company
cut :: Company -> Company
cut = everywhere (extT id (/(2::Float)))
