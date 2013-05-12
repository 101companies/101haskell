{-| The operation of totaling all salaries of all employees in a company -}

module Company.Total where

import Company.Data

-- | Total all salaries in a company
total :: Company -> Float
total (_, ds) = totalDepartments ds
  where

    -- Total salaries in a list of departments
    totalDepartments :: [Department] -> Float
    totalDepartments [] = 0
    totalDepartments (Department _ m ds es : ds')
        = getSalary m
        + totalDepartments ds
        + totalEmployees es
        + totalDepartments ds'
      where

        -- Total salaries in a list of employees
        totalEmployees :: [Employee] -> Float
        totalEmployees [] = 0
        totalEmployees (e:es)
          = getSalary e
          + totalEmployees es 

        -- Extract the salary from an employee
        getSalary :: Employee -> Salary
        getSalary (_, _, s) = s
