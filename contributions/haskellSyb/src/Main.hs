module Main where

import Company.Data
import Company.Sample
import Company.Total
import Company.Cut
import Company.Depth
import Company.Ranking
import Test.HUnit
import System.Exit

-- Test for round-tripping of de-/serialization
serializationTest = sampleCompany ~=? read (show sampleCompany)

-- Compare salary total with baseline
totalTest = 399747.0 ~=? total sampleCompany

-- Compare total after cut with baseline
cutTest = 199873.5 ~=? total (cut sampleCompany)

-- Compare depth of sample company with baseline
depthTest = 3 ~=? depth sampleCompany

-- Check ranking constraint for salaries
rankingOkTest =  True ~=? ranking sampleCompany

-- Negative test case for ranking constraint
rankingFailTest = False ~=? ranking rankingFailSample

tests =
  TestList [
    TestLabel "serialization" serializationTest,
    TestLabel "total" totalTest,
    TestLabel "cut" cutTest,
    TestLabel "depth" depthTest,
    TestLabel "rankingOk" rankingOkTest,
    TestLabel "rankingFail" rankingFailTest
  ]

main = do
 counts <- runTestTT tests
 if (errors counts > 0 || failures counts > 0)
   then exitFailure
   else exitSuccess
