{-| The operation of computing the median of all salaries of all employees in a company -}

module Company.Median where

import Company.Data
import Company.Total (salaries)
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
