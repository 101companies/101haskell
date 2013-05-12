{-| Tests for the 101companies System -}

module Main where

import Company.Sample
import Company.Total
import Company.Median
import Company.History
import Test.HUnit
import System.Exit

-- | Build the barchart for total over the years
chartTotalTest = TestCase $ chart "total.png" "Total" totals
 where
  totals = map (\(y,c) -> (y, total c)) sampleCompany

-- | Build the barchart for median over the years
chartMedianTest = TestCase $ chart "median.png" "Median" medians
 where
  medians = map (\(y,c) -> (y, median c)) sampleCompany


-- | The list of tests
tests =
  TestList [
    TestLabel "chartTotal" chartTotalTest,
    TestLabel "chartMedian" chartMedianTest
  ]

-- | Run all tests and communicate through exit code
main = do
 counts <- runTestTT tests
 if (errors counts > 0 || failures counts > 0)
   then exitFailure
   else exitSuccess
