module Cut where

import Company

-- Cut all salaries in a company
cut :: Company -> Company
cut c = c { getEmployees = map cutE (getEmployees c) }
  where
    -- Cut the salary of an employee in half
    cutE :: Employee -> Employee
    cutE e = e { getSalary = getSalary e / 2 }
