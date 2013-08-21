module Main where

import Company.Parser
import Data.Either
import Test.HUnit
import System.Exit

-- Test for success of parsing
parsingTest input = Just () ~=? eitherToMaybe (parse input)
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
