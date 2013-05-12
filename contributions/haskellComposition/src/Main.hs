{-| Tests for the 101companies System -}

module Main where

import Company.Data
import Company.Sample
import Company.Total
import Test.HUnit
import System.Exit

-- | Compare salary total of sample company with baseline
totalTest = 399747.0 ~=? total sampleCompany

-- | Test for round-tripping of de-/serialization of sample company
serializationTest = sampleCompany ~=? read (show sampleCompany)

-- | The list of tests
tests =
  TestList [
    TestLabel "total" totalTest,
    TestLabel "serialization" serializationTest
  ]

-- | Run all tests and communicate through exit code
main = do
 counts <- runTestTT tests
 if (errors counts > 0 || failures counts > 0)
   then exitFailure
   else exitSuccess
