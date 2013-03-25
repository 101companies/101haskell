module Company.Align where

import Company.Data
import Company.Generics
import Data.Generics

-- Check that salaries align with company hierarchy
align :: Company -> Bool
align (Company _ ds) =
  -- Exercise: find the time complexity bug!
  everything (&&) (extQ (const True) align') ds
    where
      -- Helper at the department level
      align' :: Department -> Bool
      align' (Department _ m ds es)
        = and (map (<getSalary m) (allSalaries (ds,es)))
      -- Collect all salaries of subunits
      allSalaries :: ([Department],[Employee]) -> [Float]
      allSalaries = everything (++) (extQ (const []) ((:[]) . getSalary))
      -- Extract the salary of an employee
      getSalary :: Employee -> Float
      getSalary (Employee _ _ s) = s

-- A company that violates the alignment constraint
unalignedSample = Company
  "Fail Industries"
  [ Department "Failure"
      (Employee "Ubermanager" "Top Floor" 100)
      []
      [Employee "Joe Programmer" "Basement" 1000]
  ]

