module Total where

import Company

-- Total all salaries in a company
total :: Company -> Float
total (n, es) = totalEs es

-- Total salaries of lists of employees
totalEs :: [Employee] -> Float
totalEs [] = 0
totalEs (e:es) = totalE e + totalEs es

-- Extract the salary from an employee
totalE :: Employee -> Float
totalE (_, _, s) = s
