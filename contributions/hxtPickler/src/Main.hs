module Main where

import Text.XML.HXT.Core
import System.Exit
import Test.HUnit

import Company.Data
import Company.Pickler
import Company.Total
import Company.Cut

samplecompanyIO = runX ( xunpickleDocument xpCompany [withRemoveWS yes] "sampleCompany.xml" )

totalTest = TestCase (do
  [sampleCompany] <- samplecompanyIO
  assertEqual "for the total of the sample company" 399747.0 (totalCompany sampleCompany))

cutTest = TestCase (do
  [sampleCompany] <- samplecompanyIO
  assertEqual "for the cut total of the sample company" 199873.5 (totalCompany (cutCompany sampleCompany)))

serializationTest = TestCase (do
  [sampleCompany] <- samplecompanyIO
  [company2] <- runX ( constA sampleCompany
                  >>>
                    xpickleDocument xpCompany [withIndent yes] "sampleCompanyCut.xml"
                  >>>
                    xunpickleDocument xpCompany [withRemoveWS yes] "sampleCompanyCut.xml"
                  )
  assertEqual "for the serialization of the sample company" sampleCompany company2)

-- | The list of tests
tests =
  TestList [
    TestLabel "total" totalTest,
    TestLabel "cut" cutTest,
    TestLabel "serialization" serializationTest
  ]

-- | Run all tests and communicate through exit code
main = do
 counts <- runTestTT tests
 if (errors counts > 0 || failures counts > 0)
   then exitFailure
   else exitSuccess
