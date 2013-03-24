module Company.Total where

import Company.Data

-- Total all salaries in a company
total :: Company -> Float
total (Company _ ds) = sum (map totalD ds)
  where
    -- Total all salaries in a department
    totalD :: Department -> Float
    totalD (Department _ m sus) = sum (totalE m : map totalS sus)
      where
        -- Extract the salary from an employee
        totalE :: Employee -> Float
        totalE (Employee _ _ s) = s
        -- Extract the salary from a sub-unit
        totalS :: SubUnit -> Float
        totalS (EUnit e) = totalE e
        totalS (DUnit d) = totalD d
