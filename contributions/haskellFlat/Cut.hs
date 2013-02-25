module Cut where

import Company

cut :: Company -> Company
cut (n, es) = (n, (cutEs es))

cutEs :: [Employee] -> [Employee]
cutEs [] = []
cutEs (e:es) = cutE e : cutEs es

cutE :: Employee -> Employee
cutE (n, a, s) = (n, a, (s/2))
