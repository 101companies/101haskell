{-| The operation of totaling all salaries of all employees in a company -}

module Company.Total where

import Company.Data

-- | Total all salaries in a company
total :: Company -> Float
total = sum . salaries
  where

    -- Extract all salaries in a company
    salaries :: Company -> [Salary]
    salaries (_, es) = getSalaries es
      where

        -- Extract all salaries of lists of employees
        getSalaries :: [Employee] -> [Salary]
        getSalaries [] = []
        getSalaries (e:es) = getSalary e : getSalaries es
          where

            -- Extract the salary from an employee
            getSalary :: Employee -> Salary
            getSalary (_, _, s) = s
