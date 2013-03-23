module Main where

import Company.Data
import Company.Total
import Company.Cut
import Test.HUnit
import System.Exit

sampleCompany =
 ( "Acme Corporation",
   [
     ("Craig", "Redmond", 123456),
     ("Erik", "Utrecht", 12345),
     ("Ralf", "Koblenz", 1234),
     ("Ray", "Redmond", 234567),
     ("Klaus", "Boston", 23456),
     ("Karl", "Riga", 2345),
     ("Joe", "Wifi City", 2344)
   ]
 )

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
