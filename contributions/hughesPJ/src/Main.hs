module Main where

import Company.Data
import Company.Sample
import Company.Unparser
import Test.HUnit
import System.Exit

-- Test for unparsing to agree with the baseline
unparsingTest baseline = baseline ~=? show (unparse sampleCompany)

tests baseline =
  TestList [
    TestLabel "unparsing" $ unparsingTest baseline
  ]

main = do
  -- Read baseline from file
  baseline <- readFile "sampleCompany.txt"
  -- Run tests
  counts <- runTestTT $ tests baseline
  if (errors counts > 0 || failures counts > 0)
    then exitFailure
    else exitSuccess
