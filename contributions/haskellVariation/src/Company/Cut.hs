{-| The operation of cutting all salaries of all employees in a company in half -}

module Company.Cut where

import Company.Data

-- | Cut all salaries in a company
cut :: Company -> Company
cut (n, ds) = (n, (map cutD ds))
  where
    -- Cut all salaries in a department
    cutD :: Department -> Department
    cutD (n, m, sus)
      = (n, cutE m, map cutS sus)
      where
        -- Cut the salary of an employee in half
        cutE :: Employee -> Employee
        cutE (n, a, s) = (n, a, s/2)
        -- Cut all salaries for a subunit
        cutS :: SubUnit -> SubUnit
        cutS (Employee e) = Employee (cutE e)
        cutS (Department d) = Department (cutD d)

