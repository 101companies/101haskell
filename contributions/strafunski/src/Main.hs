module Main where

import Company.Data
import Company.Total
import Company.Cut
import Company.Depth
import Test.HUnit
import System.Exit

-- | A sample company useful for basic tests
sampleCompany :: Company
sampleCompany =
  Company
    "Acme Corporation"
    [
      Department "Research"
        (Employee "Craig" "Redmond" 123456)
        []
        [
          (Employee "Erik" "Utrecht" 12345),
          (Employee "Ralf" "Koblenz" 1234)
        ],
      Department "Development"
        (Employee "Ray" "Redmond" 234567)
        [
          Department "Dev1"
            (Employee "Klaus" "Boston" 23456)
            [
              Department "Dev1.1"
                (Employee "Karl" "Riga" 2345)
                []
                [(Employee "Joe" "Wifi City" 2344)]
            ]
            []
        ]
        []
    ]

totalTest = 399747.0 ~=? total sampleCompany

cutTest = 199873.5 ~=? total (cut sampleCompany)

serializationTest = sampleCompany ~=? read (show sampleCompany)

depthTest = (depth sampleCompany) ~=? 3

tests =
  TestList [
    TestLabel "total" totalTest,
    TestLabel "cut" cutTest,
    TestLabel "serialization" serializationTest,
    TestLabel "depth" depthTest
  ]

-- | Run all tests and communicate through exit code
main = do
 counts <- runTestTT tests
 if (errors counts > 0 || failures counts > 0)
   then exitFailure
   else exitSuccess
