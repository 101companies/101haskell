module Company.Total where

import Company.Data

-- Total all salaries in a company
total :: Company -> Float
total (Company n ds) = sum (map totalD ds)
  where
    -- Total all salaries in a department
    totalD :: Department -> Float
    totalD (Department _ m ds es)
      = sum (totalE m : map totalD ds ++ map totalE es)
      where
        -- Extract the salary from an employee
        totalE :: Employee -> Float
        totalE (Employee _ _ s) = s
