-- Derive SYB-related instances modularly.
-- Instead, the data type declarations could also be revisited.

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
