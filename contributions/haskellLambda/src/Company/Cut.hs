module Company.Cut where

import Company.Data

-- Cut all salaries in a company
cut :: Company -> Company
cut (n, es) = (n, map (\(n,a,s) -> (n,a,s/2)) es)
