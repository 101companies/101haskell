module Company.Align where

import Company.Data
import Data.Monoid
import Data.Max

-- Check that salaries align with company hierarchy
align :: Company -> Bool
align (Company _ ds) = and (map align' ds)
  where
    -- Helper at the department level
    align' :: Department -> Bool
    align' (Department _ m ds es)
        =  and (map align' ds)
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
    getSalary (Employee _ _ s) = s
