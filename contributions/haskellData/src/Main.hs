module Main where

import Company.Data
import Company.Total
import Company.Cut
import Test.HUnit
import System.Exit

sampleCompany = Company
  "Acme Corporation"
  [
    Employee "Craig" "Redmond" 123456,
    Employee "Erik" "Utrecht" 12345,
    Employee "Ralf" "Koblenz" 1234,
    Employee "Ray" "Redmond" 234567,
    Employee "Klaus" "Boston" 23456,
    Employee "Karl" "Riga" 2345,
    Employee "Joe" "Wifi City" 2344
  ]

totalTest = 399747.0 ~=? total sampleCompany

cutTest = 199873.5 ~=? total (cut sampleCompany)

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
