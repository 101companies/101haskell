module Company.Align where

import Company.Data

-- Check that salaries align with company hierarchy
align :: Company -> Bool
align (Company _ ds) = and (map (align' Nothing) ds)
  where
    -- Helper at the department level
    align' :: Maybe Float -> Department -> Bool
    align' v (Department _ m ds es)
      =  maybe True (>getSalary m) v
      && and (map (align' (Just (getSalary m))) ds)
      && and (map ((<getSalary m) . getSalary) es)
    -- Extract the salary of an employee
    getSalary :: Employee -> Float
    getSalary (Employee _ _ s) = s
