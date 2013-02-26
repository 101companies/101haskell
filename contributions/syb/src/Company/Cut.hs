module Company.Cut where

import Company.Data
import Company.Deriving
import Data.Generics

cut :: Company -> Company
cut = everywhere (extT id (/(2::Float)))
