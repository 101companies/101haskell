module Main where

import Company.Data
import Company.Cut
import Company.Log
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

-- The log part after a cut
result = snd (cut sampleCompany)

-- Compare log entries with a baseline
logTest = entries ~=? result
  where
    entries = [
        LogEntry {name = "Craig", oldSalary = 123456.0, newSalary = 61728.0},
        LogEntry {name = "Erik", oldSalary = 12345.0, newSalary = 6172.5},
        LogEntry {name = "Ralf", oldSalary = 1234.0, newSalary = 617.0},
        LogEntry {name = "Ray", oldSalary = 234567.0, newSalary = 117283.5},
        LogEntry {name = "Klaus", oldSalary = 23456.0, newSalary = 11728.0},
        LogEntry {name = "Karl", oldSalary = 2345.0, newSalary = 1172.5},
        LogEntry {name = "Joe", oldSalary = 2344.0, newSalary = 1172.0}
      ]

-- Compare deltas from log entries with a baseline
deltasTest = deltas ~=? log2deltas result
  where
    deltas = [-117283.5,-61728.0,-11728.0,-6172.5,-1172.5,-1172.0,-617.0]

-- Compare mean of deltas with a baseline
meanTest = -28553.357 ~=? log2mean result

-- Compare median of deltas with a baseline
medianTest = -6172.5 ~=? log2median result

tests =
  TestList [
    TestLabel "log" logTest,
    TestLabel "deltas" deltasTest,
    TestLabel "mean" meanTest,
    TestLabel "median" medianTest
  ]

main = do
 counts <- runTestTT tests
 if (errors counts > 0 || failures counts > 0)
   then exitFailure
   else exitSuccess
