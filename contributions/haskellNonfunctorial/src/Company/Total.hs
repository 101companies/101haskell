module Company.Total where

import Company.Data
import Company.Traversal

total :: Company -> Float
total = sum . getSalariesFromCompany
