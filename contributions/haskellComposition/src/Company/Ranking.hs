{-| The constraint to check that salaries follow ranks in company hierarchy -}

module Company.Ranking where

import Company.Data

-- | Check that salaries follow ranks in company hierarchy
ranking :: Company -> Bool
ranking (Company _ ds) = and (map (ranking' Nothing) ds)
  where
    -- Helper at the department level
    ranking' :: Maybe Float -> Department -> Bool
    ranking' v (Department _ m ds es)
      =  maybe True (>getSalary m) v
      && and (map (ranking' (Just (getSalary m))) ds)
      && and (map ((<getSalary m) . getSalary) es)
    -- Extract the salary of an employee
    getSalary :: Employee -> Float
    getSalary (Employee _ _ s) = s

-- | A company that violates the ranking constraint
rankingFailSample = Company
  "Fail Industries"
  [ Department "Failure"
      (Employee "Ubermanager" "Top Floor" 100)
      []
      [Employee "Joe Programmer" "Basement" 1000]
  ]
