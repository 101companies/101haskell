module Main where

import Company.Data
import Company.Sample
import Company.Total
import Company.Median
import Company.Cut
import Test.HUnit
import System.Exit

-- Compare salary total with baseline
totalTest = 399747.0 ~=? total sampleCompany

-- Compare salary median with baseline
medianTest = 12345.0 ~=? median sampleCompany

-- Compare total after cut with baseline
cutTest = 199873.5 ~=? total (cut sampleCompany)

-- Test for round-tripping of de-/serialization
serializationTest = sampleCompany ~=? read (show sampleCompany)

tests =
  TestList [
    TestLabel "total" totalTest,
    TestLabel "median" medianTest,
    TestLabel "cut" cutTest,
    TestLabel "serialization" serializationTest
  ]

main = do
 counts <- runTestTT tests
 if (errors counts > 0 || failures counts > 0)
   then exitFailure
   else exitSuccess
