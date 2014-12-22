{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Company.Data
import Company.Conversion
import Company.Total
import Company.Cut
import Data.TermRep
import Test.HUnit
import System.Exit

sampleCompany =
  Company
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

-- Compare exploded sample company with baseline
explodeTest = termRep ~=? explode sampleCompany
  where
    termRep = ConstrRep "Company" [StringRep "Acme Corporation",ListRep [ConstrRep "Department" [StringRep "Research",ConstrRep "Employee" [StringRep "Craig",StringRep "Redmond",FloatRep 123456.0],ListRep [],ListRep [ConstrRep "Employee" [StringRep "Erik",StringRep "Utrecht",FloatRep 12345.0],ConstrRep "Employee" [StringRep "Ralf",StringRep "Koblenz",FloatRep 1234.0]]],ConstrRep "Department" [StringRep "Development",ConstrRep "Employee" [StringRep "Ray",StringRep "Redmond",FloatRep 234567.0],ListRep [ConstrRep "Department" [StringRep "Dev1",ConstrRep "Employee" [StringRep "Klaus",StringRep "Boston",FloatRep 23456.0],ListRep [ConstrRep "Department" [StringRep "Dev1.1",ConstrRep "Employee" [StringRep "Karl",StringRep "Riga",FloatRep 2345.0],ListRep [],ListRep [ConstrRep "Employee" [StringRep "Joe",StringRep "Wifi City",FloatRep 2344.0]]]],ListRep []]],ListRep []]]]

-- Test for round-tripping of explode/implode
implodeTest = sampleCompany ~=? implode (explode sampleCompany)

-- Compare salary total with baseline
totalTest = 399747.0 ~=? total (explode sampleCompany)

-- Compare total after cut with baseline
cutTest = 199873.5 ~=? total (cut (explode sampleCompany))

tests =
  TestList [
    TestLabel "explode" explodeTest,
    TestLabel "implode" implodeTest,
    TestLabel "total" totalTest,
    TestLabel "cut" cutTest
  ]

-- | Run all tests and communicate through exit code
main = do
 counts <- runTestTT tests
 if (errors counts > 0 || failures counts > 0)
   then exitFailure
   else exitSuccess
