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
import Data.Maybe

-- | Test case for sample company with an expected baseline
testBaseline s b p = testCase s $ b @=? p system sampleCompany

-- | Test case for sample company
testCase' s p = testCase s $ True @=? p system sampleCompany

-- | Test property for arbitrary input
testProperty' s p = testProperty s $ p system

-- | The list of tests
tests
  = [
      testBaseline "total" 399747.0 total,
      testCase' "invariants" prop_invariant,
      testCase' "serialization" prop_serialization,
      testCase' "total'" (\system c -> prop_total' system c 3),
      testCase' "cut" prop_cut,
      testProperty' "invariants'" prop_invariant,
      testProperty' "total" prop_total,
      testProperty' "total'" prop_total',
      testProperty' "cut" prop_cut,
      testProperty' "map" $ prop_map,
      testProperty' "upd" $ prop_upd,
      testProperty' "upd'" $ prop_upd',
      testProperty' "add" $ prop_add,
      testProperty' "halve" $ prop_halve
    ]

-- | Test-data generation for employees

instance Arbitrary Employee
  where
    arbitrary = do
      n <- suchThat arbitrary (/="")
      a <- suchThat arbitrary (/="")
      int <- choose (1::Int,123456)
      cents <- choose (0::Int,99)
      let s = fromIntegral int + (fromIntegral cents) / 100 
      return (fromJust (mkEmployee n a s))

-- | Test-data generation for employees

instance Arbitrary Company
  where
    arbitrary = do
      n <- suchThat arbitrary (/="")
      es <- suchThat arbitrary (isJust . mkCompany n)
      return (fromJust (mkCompany n es))
