module Company.Total where

import Company.Data

-- Total all salaries in a company
total :: Company -> Float
total (n, es) = sum (map (\(_,_,s) -> s) es)
