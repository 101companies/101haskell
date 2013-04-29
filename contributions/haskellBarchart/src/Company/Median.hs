{-| The operation of computing the median of all salaries of all employees in a company -}

module Company.Median (
  median
) where

import Company.Data
import Data.List (sort)

-- | Median of all salaries in a company
median :: Company -> Salary
median = medianSorted . sort . salaries

-- Median of a sorted list
medianSorted [] = error "Cannot compute median on empty list."
medianSorted [x] = x
medianSorted [x,y] = (x+y)/2
medianSorted l = medianSorted (init (tail l))

-- | Extract all salaries in a company
salaries :: Company -> [Salary]
salaries (n, es) = getSalaries es

-- Extract all salaries of lists of employees
getSalaries :: [Employee] -> [Salary]
getSalaries [] = []
getSalaries (e:es) = getSalary e : getSalaries es

-- Extract the salary from an employee
getSalary :: Employee -> Salary
getSalary (_, _, s) = s
