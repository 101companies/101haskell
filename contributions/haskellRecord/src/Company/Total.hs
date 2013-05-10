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
salaries (Company n es) = map totalE es
  where
    -- Extract the salary from an employee
    totalE :: Employee -> Float
    totalE (Employee _ _ s) = s
