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
    totalDepartments (d:ds)
        = totalDepartment d
        + totalDepartments ds 
      where

        -- Total salaries in a department
        totalDepartment :: Department -> Float
        totalDepartment (_, m, sus)
            = getSalary m
            + totalSubunits sus
          where

            -- Total salaries in a list of subunits
            totalSubunits :: [SubUnit] -> Float
            totalSubunits [] = 0
            totalSubunits (su:sus)
                = totalSubunit su
                + totalSubunits sus
              where

                -- Total salaries in a subunit
                totalSubunit :: SubUnit -> Float
                totalSubunit (Employee e) = getSalary e
                totalSubunit (Department d) = totalDepartment d

            -- Extract the salary from an employee
            getSalary :: Employee -> Salary
            getSalary (_, _, s) = s
