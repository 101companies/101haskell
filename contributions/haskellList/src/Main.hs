module Main where

import Company.Data
import Company.Sample
import Company.Total
import Company.Cut
import Test.HUnit
import System.Exit

-- Compare salary total with baseline
totalTest = 399747.0 ~=? total sampleCompany

-- Compare total after cut with baseline
cutTest = 199873.5 ~=? total (cut sampleCompany)

-- Test for round-tripping of de-/serialization
serializationTest = sampleCompany ~=? read (show sampleCompany)

tests =
  TestList [
    TestLabel "total" totalTest,
    TestLabel "cut" cutTest,
    TestLabel "serialization" serializationTest
  ]

main = do
 counts <- runTestTT tests
 if (errors counts > 0 || failures counts > 0)
   then exitFailure
   else exitSuccess
