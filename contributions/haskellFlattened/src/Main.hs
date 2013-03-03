module Main where

import Company.Data
import Company.Total
import Company.Cut
import Company.SampleCompany
import Test.HUnit
import System.Exit
import Data.Map (fromList)

employeesPerDeptResult = fromList [(("meganalysis","Dev1"),23456.0),(("meganalysis","Dev1.1"),4689.0),(("meganalysis","Development"),234567.0),(("meganalysis","Research"),137035.0)]
-- Compare salary total with baseline
totalTest = 399747.0 ~=? total employees

-- Compare total after cut with baseline
cutTest = 199873.5 ~=? total (cut employees)

-- Test for round-tripping of de-/serialization
serializationTest = sample ~=? read (show sample)

totalPerDepartmentTest = totalPerDepartment employees ~=? employeesPerDeptResult

totalPerDepartment2Test = totalPerDepartment' employees ~=? employeesPerDeptResult

totalPerDepartment3Test = totalPerDepartment'' employees ~=? employeesPerDeptResult

tests =
  TestList [
    TestLabel "total" totalTest,
    TestLabel "cut" cutTest,
    TestLabel "serialization" serializationTest,
    TestLabel "totalPerDept" totalPerDepartmentTest,
    TestLabel "totalPerDept2" totalPerDepartment2Test,
    TestLabel "totalPerDept3" totalPerDepartment3Test
  ]

main = do
 counts <- runTestTT tests
 if (errors counts > 0 || failures counts > 0)
   then exitFailure
   else exitSuccess

{-
        -- Total all salaries per department
      let per = totalPerDepartment employees
      print $ per

      -- Check the alternative approaches
      print $ per == totalPerDepartment' employees
      print $ per == totalPerDepartment'' employees
-}
