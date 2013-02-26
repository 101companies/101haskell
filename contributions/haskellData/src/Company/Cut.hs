module Company.Cut where

import Company.Data

-- Cut all salaries in a company
cut :: Company -> Company
cut (Company n es) = Company n (map cutE es)
  where
    -- Cut the salary of an employee in half
    cutE :: Employee -> Employee
    cutE (Employee n a s) = Employee n a (s/2)
