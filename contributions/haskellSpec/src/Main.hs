{-| Test driver for the 101companies System -}

module Main where

import Company.Tests (tests)
import Test.Framework (defaultMain)

-- | Run all tests
main = defaultMain tests
