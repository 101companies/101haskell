{-| Test-data generation for the 101companies System -}

module Company.Generation where

-- The generators neither depend on representation nor implementation.
import Company.Signature
import Test.QuickCheck (arbitrary, choose, suchThat)
import Data.Maybe (isJust, fromJust)

-- | Test-data generation for companies

arbitraryCompany i
  = do
       n <- suchThat arbitrary (/="")
       es <- suchThat arbitrary (isJust . mkCompany i n)
       return (fromJust (mkCompany i n es))

-- | Test-data generation for employees

arbitraryEmployee i
  = do
       n <- suchThat arbitrary (/="")
       a <- suchThat arbitrary (/="")
       int <- choose (1::Int,123456)
       let s = fromIntegral int 
       return (fromJust (mkEmployee i n a s))
