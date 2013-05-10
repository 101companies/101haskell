{-| The operation of totaling all salaries of all employees in a company -}

module Company.Total (
  total,
  salaries
) where

import Company.Data

-- | Total all salaries in a company
total :: Company -> Float
total = sum . salaries

-- | Extract all salaries in a company
salaries :: Company -> [Salary]
salaries (Company _ ds) = concat (map salaries' ds)
  where
    -- Extract all salaries in a department
    salaries' :: Department -> [Salary]
    salaries' (Department _ m sus) = getSalary m : concat (map salaries'' sus)
      where
        -- Extract the salary from a sub-unit
        salaries'' :: SubUnit -> [Salary]
        salaries'' (EUnit e) = [getSalary e]
        salaries'' (DUnit d) = salaries' d
        -- Extract the salary from an employee
        getSalary :: Employee -> Salary
        getSalary (Employee _ _ s) = s
