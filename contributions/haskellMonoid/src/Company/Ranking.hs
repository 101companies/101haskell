{-| The constraint to check that salaries follow ranks in company hierarchy -}

module Company.Ranking where

import Company.Data
import Data.Monoid
import Data.Max

-- | Check that salaries follow ranks in company hierarchy
ranking :: Company -> Bool
ranking (_, ds) = and (map ranking' ds)
  where
    -- Helper at the department level
    ranking' :: Department -> Bool
    ranking' (Department _ m ds es)
        =  and (map ranking' ds)
        && maybe True (<getSalary m) (getMax subunits)
      where
        -- Maximum of salaries for immediate employees
        employees :: Max Float
        employees = mconcat (map (setMax . getSalary) es)
        -- Maximum of salaries for immediate sub-departments' managers
        managers :: Max Float
        managers = mconcat (map (setMax . getManagerSalary) ds)
        -- "employees" and "managers" combined       
        subunits :: Max Float
        subunits = managers `mappend` employees
    -- Extract the salary of a department's manager
    getManagerSalary :: Department -> Float
    getManagerSalary (Department _ m _ _) = getSalary m
    -- Extract the salary of an employee
    getSalary :: Employee -> Float
    getSalary (_, _, s) = s

-- | A company that violates the ranking constraint
rankingFailSample =
  ( "Fail Industries",
    [ Department "Failure"
        ("Ubermanager", "Top Floor", 100)
        []
        [("Joe Programmer", "Basement", 1000)]
    ]
  )
