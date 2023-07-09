module Main where

import Company.Data
import Company.Sample
import Company.Total
import Company.Median
import Company.Cut
import Company.Raise
import Test.HUnit
import System.Exit

totalTest = 399747.0 ~=? total sampleCompany

medianTest = 12345.0 ~=? median sampleCompany

cutTest = 199873.5 ~=? total (cut sampleCompany)

raiseTest = 403744.47 ~=? total (raise sampleCompany)

serializationTest = sampleCompany ~=? read (show sampleCompany)

tests =
  TestList [
    TestLabel "total" totalTest,
    TestLabel "median" medianTest,
    TestLabel "cut" cutTest,
    TestLabel "raise" raiseTest,
    TestLabel "serialization" serializationTest
  ]

-- | Run all tests and communicate through exit code
main = do
 counts <- runTestTT tests
 if (errors counts > 0 || failures counts > 0)
   then exitFailure
   else exitSuccess
