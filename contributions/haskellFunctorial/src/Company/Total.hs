module Company.Total where

import Company.Data
import Company.Functorial

total :: Company Float -> Float
total = foldr (+) 0

