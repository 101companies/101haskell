module Company.Depth where

import Company.Data
import Company.Deriving
import Data.Generics

depth :: Company -> Int
depth = depth'
  where
   depth' :: GenericQ Int
   depth' x = recurse x + mkQ 0 atDept x
     where
       recurse :: GenericQ Int
       recurse = foldr max 0 . gmapQ depth'
       atDept :: Department -> Int
       atDept = const 1
