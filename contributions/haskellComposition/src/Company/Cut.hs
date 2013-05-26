{-| The operation of cutting all salaries of all employees in a company in half -}

module Company.Cut where

import Company.Data

-- | Cut all salaries in a company
cut :: Company -> Company
cut (n, ds) = (n, (map cutD ds))
  where
    -- Cut all salaries in a department
    cutD :: Department -> Department
    cutD (Department n m ds es)
      = Department n (cutE m) (map cutD ds) (map cutE es)
      where
        -- Cut the salary of an employee in half
        cutE :: Employee -> Employee
        cutE (n, a, s) = (n, a, s/2)
