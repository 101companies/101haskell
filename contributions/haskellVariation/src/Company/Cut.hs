module Company.Cut where

import Company.Data

-- Cut all salaries in a company
cut :: Company -> Company
cut (Company n ds) = (Company n (map cutD ds))
  where
    -- Cut all salaries in a department
    cutD :: Department -> Department
    cutD (Department n m sus) = Department n (cutE m) (map cutS sus)
      where
        -- Cut the salary of an employee in half
        cutE :: Employee -> Employee
        cutE (Employee n a s) = Employee n a (s/2)
        -- Cut salary/salaries of a sub-unit
        cutS :: SubUnit -> SubUnit
        cutS (EUnit e) = EUnit (cutE e)
        cutS (DUnit d) = DUnit (cutD d)
