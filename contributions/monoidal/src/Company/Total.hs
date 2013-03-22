module Company.Total where

import Company.Data
import Data.Monoid

-- Total all salaries in a company
total :: Company -> Float
total (Company n ds) = getSum (mconcat (map totalD ds))
  where
    -- Total all salaries in a department
    totalD :: Department -> Sum Float
    totalD (Department _ m ds es)
      = mconcat (totalE m : map totalD ds ++ map totalE es)
      where
        -- Extract the salary from an employee
        totalE :: Employee -> Sum Float
        totalE (Employee _ _ s) = Sum s
