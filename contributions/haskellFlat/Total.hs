module Total where

import Company

total :: Company -> Float
total (n, es) = totalEs es

totalEs :: [Employee] -> Float
totalEs [] = 0
totalEs (e:es) = totalE e + totalEs es

totalE :: Employee -> Float
totalE (_, _, s) = s
