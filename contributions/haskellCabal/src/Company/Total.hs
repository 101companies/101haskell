module Company.Total where

import Company.Data

-- Total all salaries in a company
total :: Company -> Float
total = sum . salaries

-- Extract all salaries in a company
salaries :: Company -> [Salary]
salaries (n, es) = getSalaries es

-- Extract all salaries of lists of employees
getSalaries :: [Employee] -> [Salary]
getSalaries [] = []
getSalaries (e:es) = getSalary e : getSalaries es

-- Extract the salary from an employee
getSalary :: Employee -> Salary
getSalary (_, _, s) = s
