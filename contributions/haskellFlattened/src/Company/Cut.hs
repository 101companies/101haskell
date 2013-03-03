module Company.Cut where

import Company.Data

cut :: [Employee] -> [Employee]
cut = map (\(e, d, c, a, s, m) -> (e, d, c, a, s/2, m))
