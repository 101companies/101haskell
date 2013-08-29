{-| The operation of totaling all salaries of all employees in a company -}

module Company.Total where

import Company.Data

-- | Total all salaries in a company
total :: Company -> Float
total (_, ds) = sum (map totalDepartment ds)
  where
    -- Total salaries in a department
    totalDepartment :: Department -> Float
    totalDepartment (_, m, sus)
        = getSalary m
        + sum (map totalSubunit sus)
      where
        -- Total salaries in a subunit
        totalSubunit :: SubUnit -> Float
        totalSubunit s
          = getSubUnit s getSalary totalDepartment

        -- Extract the salary from an employee
        getSalary :: Employee -> Salary
        getSalary (_, _, s) = s
