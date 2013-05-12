{-| The operation of cutting all salaries of all employees in a company in half -}

module Company.Cut where

import Company.Data

-- | Cut all salaries in a company
cut :: Company -> Company
cut (n, es) = (n, map cut' es)
  where

    -- Cut the salary of an employee in half
    cut' :: Employee -> Employee
    cut' (n, a, s) = (n, a, s/2)
