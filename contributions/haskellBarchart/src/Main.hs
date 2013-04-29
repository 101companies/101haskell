{-| Tests for the 101companies System -}

module Main where

import Company.Sample
import Company.History
import Test.HUnit
import System.Exit

-- | Build the barchart for median over the years
historyTest = TestCase $ chart "test.png" sampleCompany

-- | The list of tests
tests =
  TestList [
    TestLabel "history" historyTest
  ]

-- | Run all tests and communicate through exit code
main = do
 counts <- runTestTT tests
 if (errors counts > 0 || failures counts > 0)
   then exitFailure
   else exitSuccess
