{-| Tests for the 101companies System -}

module Main where

import Company.Data
import Company.Sample
import Company.Total
import Company.Cut
import Company.Depth
import Company.Ranking
import Company.Mentoring
import Test.HUnit
import System.Exit

-- | Compare salary total of sample company with baseline
totalTest = 399747.0 ~=? total sampleCompany

-- | Compare total after cut of sample company with baseline
cutTest = 199873.5 ~=? total (cut sampleCompany)

-- | Compare depth of sample company with baseline
depthTest = 3 ~=? depth sampleCompany

-- | Check ranking constraint for salaries of sample company
rankingOkTest = True ~=? ranking sampleCompany

-- | Negative test case for ranking constraint
rankingFailTest = False ~=? ranking rankingFailSample

-- | Check mentoring consistency for sample company
mentoringOkTest = True ~=? mentoring sampleCompany

-- | Negative test case for mentoring consistency
mentoringFailTest1 = False ~=? mentoring danglingMentoringSample

-- | Another negative test case for mentoring consistency
mentoringFailTest2 = False ~=? mentoring selfMentoringSample

-- | Check successful lookup for mentor
mentorOkTest = Just "Craig" ~=? mentor sampleCompany "Ray"

-- | Check unsuccessful lookup for mentor
mentorFailTest = Nothing ~=? mentor sampleCompany "Joe"

-- | Check lookup for mentees
menteesOkTest = ["Erik","Ray","Karl"] ~=? mentees sampleCompany "Craig"

-- | Test for round-tripping of de-/serialization of sample company
serializationTest = sampleCompany ~=? read (show sampleCompany)

-- | The list of tests
tests =
  TestList [
    TestLabel "total" totalTest,
    TestLabel "cut" cutTest,
    TestLabel "depth" depthTest,
    TestLabel "rankingOk" rankingOkTest,
    TestLabel "rankingFail" rankingFailTest,
    TestLabel "mentoringOk" mentoringOkTest,
    TestLabel "mentoringFail1" mentoringFailTest1,
    TestLabel "mentoringFail2" mentoringFailTest2,
    TestLabel "mentorOk" mentorOkTest,
    TestLabel "mentorFail" mentorFailTest,
    TestLabel "menteesOk" menteesOkTest,
    TestLabel "serialization" serializationTest
  ]

-- | Run all tests and communicate through exit code
main = do
 counts <- runTestTT tests
 if (errors counts > 0 || failures counts > 0)
   then exitFailure
   else exitSuccess
