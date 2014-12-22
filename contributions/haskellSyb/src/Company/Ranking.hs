module Company.Ranking where

import Company.Data
import Company.Generics
import Data.Generics

-- Check that salaries follow ranks in company hierarchy
ranking :: Company -> Bool
ranking (Company _ ds) =
  -- Exercise: find the time complexity bug!
  everything (&&) (extQ (const True) ranking') ds
    where
      -- Helper at the department level
      ranking' :: Department -> Bool
      ranking' (Department _ m ds es)
        = and (map (<getSalary m) (allSalaries (ds,es)))
      -- Collect all salaries of subunits
      allSalaries :: ([Department],[Employee]) -> [Float]
      allSalaries = everything (++) (extQ (const []) ((:[]) . getSalary))
      -- Extract the salary of an employee
      getSalary :: Employee -> Float
      getSalary (Employee _ _ s) = s

-- | A company that violates the ranking constraint
rankingFailSample =
  ( "Fail Industries",
    [ Department "Failure"
        ("Ubermanager", "Top Floor", 100)
        []
        [("Joe Programmer", "Basement", 1000)]
    ]
  )
