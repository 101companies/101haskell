{-| Tests for the 101companies System -}

module Main where

import Company.Data
import Company.Sample
import Company.Total
import Company.Depth
import Company.Ranking
import Test.HUnit
import System.Exit

-- | Compare salary total of sample company with baseline
totalTest = 399747.0 ~=? total sampleCompany

-- | Compare depth of sample company with baseline
depthTest = 3 ~=? depth sampleCompany

-- | Check ranking constraint for salaries of sample company
rankingOkTest =  True ~=? ranking sampleCompany

-- | Negative test case for ranking constraint
rankingFailTest = False ~=? ranking rankingFailSample

-- | Test for round-tripping of de-/serialization of sample company
serializationTest = sampleCompany ~=? read (show sampleCompany)

-- | The list of tests
tests =
  TestList [
    TestLabel "total" totalTest,
    TestLabel "depth" depthTest,
    TestLabel "rankingOk" rankingOkTest,
    TestLabel "rankingFail" rankingFailTest,
    TestLabel "serialization" serializationTest
  ]

-- | Run all tests and communicate through exit code
main = do
 counts <- runTestTT tests
 if (errors counts > 0 || failures counts > 0)
   then exitFailure
   else exitSuccess
