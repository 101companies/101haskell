module Main where

import Company.Data
import Company.Sample
import Company.Cut
import Company.Log
import Test.HUnit
import System.Exit

-- The log part after a cut
sampleCompanyLog = snd (cut sampleCompany)

-- Compare log with baseline
cutLogTest = baseline ~=? sampleCompanyLog
  where
    baseline = [
        LogEntry {name = "Craig", oldSalary = 123456.0, newSalary = 61728.0},
        LogEntry {name = "Erik", oldSalary = 12345.0, newSalary = 6172.5},
        LogEntry {name = "Ralf", oldSalary = 1234.0, newSalary = 617.0},
        LogEntry {name = "Ray", oldSalary = 234567.0, newSalary = 117283.5},
        LogEntry {name = "Klaus", oldSalary = 23456.0, newSalary = 11728.0},
        LogEntry {name = "Karl", oldSalary = 2345.0, newSalary = 1172.5},
        LogEntry {name = "Joe", oldSalary = 2344.0, newSalary = 1172.0}
      ]

-- Compare deltas from log entries with baseline
deltasTest = deltas ~=? log2deltas sampleCompanyLog
  where
    deltas = [-117283.5,-61728.0,-11728.0,-6172.5,-1172.5,-1172.0,-617.0]

-- Compare mean of deltas with baseline
meanTest = -28553.357 ~=? log2mean sampleCompanyLog

-- Compare median of deltas with baseline
medianTest = -6172.5 ~=? log2median sampleCompanyLog

tests =
  TestList [
    TestLabel "cutLog" cutLogTest,
    TestLabel "deltas" deltasTest,
    TestLabel "mean" meanTest,
    TestLabel "median" medianTest
  ]

-- | Run all tests and communicate through exit code
main = do
 counts <- runTestTT tests
 if (errors counts > 0 || failures counts > 0)
   then exitFailure
   else exitSuccess
