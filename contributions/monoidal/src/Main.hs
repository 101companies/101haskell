module Main where

import Company.Data
import Company.Sample
import Company.Total
import Company.Depth
import Company.Align
import Test.HUnit
import System.Exit

-- Test for round-tripping of de-/serialization
serializationTest = sampleCompany ~=? read (show sampleCompany)

-- Compare salary total with baseline
totalTest = 399747.0 ~=? total sampleCompany

-- Compare depth of sample company with baseline
depthTest = 3 ~=? depth sampleCompany

-- Check alignment constraint for salaries
alignmentSuccessTest =  True ~=? align sampleCompany

-- Negative test case for alignment constraint
alignmentFailureTest = False ~=? align unalignedSample

tests =
  TestList [
    TestLabel "serialization" serializationTest,
    TestLabel "total" totalTest,
    TestLabel "depth" depthTest,
    TestLabel "alignmentSuccess" alignmentSuccessTest,
    TestLabel "alignmentFailure" alignmentFailureTest
  ]

main = do
 counts <- runTestTT tests
 if (errors counts > 0 || failures counts > 0)
   then exitFailure
   else exitSuccess
