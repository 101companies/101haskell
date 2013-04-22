module Main where

import Company.Data
import Company.Sample
import Company.Parser
import Data.Either
import Test.HUnit
import System.Exit

-- Test for parsing to agree with the baseline
parsingTest input = Just sampleCompany ~=? eitherToMaybe (parseCompany input)
  where
    eitherToMaybe = either (const Nothing) Just

tests input =
  TestList [
    TestLabel "parsing" $ parsingTest input
  ]

main = do
  -- Read input from file
  input <- readFile "sampleCompany.txt"
  -- Run tests
  counts <- runTestTT $ tests input
  if (errors counts > 0 || failures counts > 0)
    then exitFailure
    else exitSuccess
