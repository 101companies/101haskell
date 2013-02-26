module Company.Cut where

import Company.Data

-- Cut all salaries in a company
cut :: Company -> Company
cut (n, es) = (n, cutEs es)

-- Cut salaries for lists of employees
cutEs :: [Employee] -> [Employee]
cutEs [] = []
cutEs (e:es) = cutE e : cutEs es

-- Cut the salary of an employee in half
cutE :: Employee -> Employee
cutE (n, a, s) = (n, a, s/2)
