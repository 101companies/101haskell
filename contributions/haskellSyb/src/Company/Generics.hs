-- Derive SYB support instances modularly.
-- Instead, the data type declarations could also be revised.

{-# LANGUAGE DeriveDataTypeable, StandaloneDeriving #-}

module Company.Generics where

import Company.Data
import Data.Data
import Data.Typeable

deriving instance Data Company
deriving instance Typeable Company

deriving instance Data Department
deriving instance Typeable Department

deriving instance Data Employee
deriving instance Typeable Employee
