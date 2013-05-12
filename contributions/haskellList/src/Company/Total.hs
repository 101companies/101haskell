{-| The operation of totaling all salaries of all employees in a company -}

module Company.Total where

import Company.Data

-- | Total all salaries in a company
total :: Company -> Float
total = sum . salaries
  where

    -- Extract all salaries in a company
    salaries :: Company -> [Salary]
    salaries (n, es) = map getSalary es
      where

        -- Extract the salary from an employee
        getSalary :: Employee -> Float
        getSalary (_, _, s) = s
