module Company.Align where

import Company.Data

-- Check that salaries align with company hierarchy
align :: Company -> Bool
align (Company _ ds) = and (map (align' Nothing) ds)
  where
    -- Helper at the department level
    align' :: Maybe Float -> Department -> Bool
    align' v (Department _ m sus)
      =  maybe True (>getSalary m) v
      && and (map (align'' (getSalary m)) sus)
    -- Helper at the sub-unit level
    align'' :: Float -> SubUnit -> Bool
    align'' v (EUnit e) = v > getSalary e
    align'' v (DUnit d) = align' (Just v) d
    -- Extract the salary of an employee
    getSalary :: Employee -> Float
    getSalary (Employee _ _ s) = s
