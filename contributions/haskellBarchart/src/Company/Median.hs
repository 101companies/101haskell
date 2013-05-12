{-| The operation of computing the median of all salaries of all employees in a company -}

module Company.Median where

import Company.Data
import Data.List (sort)

-- | Median of all salaries in a company
median :: Company -> Salary
median = median' . sort . salaries
  where

    -- Median of a sorted list
    median' [] = error "Cannot compute median on empty list."
    median' [x] = x
    median' [x,y] = (x+y)/2
    median' l = median' (init (tail l))

    -- Extract all salaries in a company
    salaries :: Company -> [Salary]
    salaries (n, es) = getSalaries es
      where

        -- Extract all salaries of lists of employees
        getSalaries :: [Employee] -> [Salary]
        getSalaries [] = []
        getSalaries (e:es) = getSalary e : getSalaries es
          where

            -- Extract the salary from an employee
            getSalary :: Employee -> Salary
            getSalary (_, _, s) = s
