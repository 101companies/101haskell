{-| Test driver for a concrete implementation of the 101companies System -}

module Main where

import Company.Tests (tests)
import Company.Representation (Company, Employee)
import Company.Functions (system)
import Company.Generation (arbitraryCompany, arbitraryEmployee)
import Test.Framework (defaultMain)
import Test.QuickCheck (Arbitrary, arbitrary)

-- | Test-data generation for companies

instance Arbitrary Company
  where
    arbitrary = arbitraryCompany system

-- | Test-data generation for employees

instance Arbitrary Employee
  where
    arbitrary = arbitraryEmployee system

-- | Run all tests
main = defaultMain (tests system)

