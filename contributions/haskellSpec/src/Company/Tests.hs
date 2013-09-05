{-| Tests for the 101companies System -}

module Company.Tests where

import Company.Signature
import Company.Properties
import Company.Implementation
import Company.Sample
import Test.Framework.Providers.HUnit (testCase)
import Test.Framework.Providers.QuickCheck2 (testProperty)
import Test.QuickCheck
import Test.HUnit

-- | Test case for sample company
testCase' s p = testCase s $ True @=? p system sampleCompany

-- | Test property for arbitrary input
testProperty' s p = testProperty s $ p system

-- | The list of tests
tests
  = [
      testCase' "invariants" prop_invariant,
      testCase "total" (399747.0 @=? total system sampleCompany),
      testCase' "cut" prop_cut,
      testCase' "serialization" prop_serialization,
      testProperty' "invariants'" prop_invariant,
      testProperty' "map" $ prop_map,
      testProperty' "upd" $ prop_upd,
      testProperty' "upd'" $ prop_upd',
      testProperty' "halve" $ prop_halve
    ]

-- | Test-data generation for employees

instance Arbitrary Employee
  where
    arbitrary = do
      n <- suchThat arbitrary (/="")
      a <- suchThat arbitrary (/="")
      s <- suchThat arbitrary (>0)
      return (Employee n a s)

-- | Test-data generation for employees

instance Arbitrary Company
  where
    arbitrary = do
      n <- suchThat arbitrary (/="")
      es <- suchThat arbitrary (prop_unique system . Company n)
      return (Company n es)
