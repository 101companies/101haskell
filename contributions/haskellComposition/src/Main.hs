module Main where

import Company.Data
import Company.Align
import Company.Total
import Company.Cut
import Company.Depth
import Test.HUnit
import System.Exit

sampleCompany = Company
  "Acme Corporation"
  [ Department "Research"
      (Employee "Craig" "Redmond" 123456)
      []
      [ Employee "Erik" "Utrecht" 12345,
        Employee "Ralf" "Koblenz" 1234
      ],
    Department "Development"
      (Employee "Ray" "Redmond" 234567)
      [ Department "Dev1"
          (Employee "Klaus" "Boston" 23456)
          [ Department "Dev1.1"
              (Employee "Karl" "Riga" 2345)
              []
              [ Employee "Joe" "Wifi City" 2344 ]
          ]
          []
      ]
      []
  ]

failCorp = Company
  "Fail Industries"
  [ Department "Failure"
      (Employee "Advice Dog" "Memebase" 100)
      []
      [Employee "Philosoraptor" "/b/" 1000]
  ]

totalTest = 399747.0 ~=? total sampleCompany

cutTest = 199873.5 ~=? total (cut sampleCompany)

serializationTest = sampleCompany ~=? read (show sampleCompany)

alignmentSuccessTest =  True ~=? align sampleCompany

alignmentFailureTest = False ~=? align failCorp

tests =
  TestList [
    TestLabel "total" totalTest,
    TestLabel "cut" cutTest,
    TestLabel "serialization" serializationTest,
    TestLabel "alignmentSuccess" alignmentSuccessTest,
    TestLabel "alignmentFailure" alignmentFailureTest
  ]

main = do
 counts <- runTestTT tests
 if (errors counts > 0 || failures counts > 0)
   then exitFailure
   else exitSuccess
