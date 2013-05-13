{-| The operation of totaling all salaries of all employees in a company -}

module Company.Total where

import Company.Data

-- | Total all salaries in a company
total :: Company -> Float
total = sum . salaries

-- | Extract all salaries in a company
salaries :: Company -> [Float]
salaries = getSalaries . getEmployees
  where

    -- Extract all salaries of lists of employees
    getSalaries :: [Employee] -> [Float]
    getSalaries [] = []
    getSalaries (e:es) = getFloat (getSalary e) : getSalaries es
