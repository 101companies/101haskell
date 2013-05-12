{-| The operation of cutting all salaries of all employees in a company in half -}

module Company.Cut where

import Company.Data

-- | Cut all salaries in a company
cut :: Company -> Company
cut (n, es) = (n, cutEmployees es)
  where

    -- Cut the salaries of a list of employees
    cutEmployees :: [Employee] -> [Employee]
    cutEmployees [] = []
    cutEmployees (e:es) = cutEmployee e : cutEmployees es
      where

        -- Cut the salary of an employee in half
        cutEmployee :: Employee -> Employee
        cutEmployee (n, a, s) = (n, a, s/2)
