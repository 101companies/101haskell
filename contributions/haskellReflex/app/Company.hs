{-# LANGUAGE OverloadedStrings #-}
module Company where

import Data.Text (Text)

data Company = Company Name [Employee]

data Employee = Employee Name Address Salary
    deriving (Eq, Ord)

type Name = Text
type Address = Text
type Salary = Float

---

sampleCompany :: Company
sampleCompany = Company "Acme Corporation"
                    [ Employee "Craig" "Redmond" 10345
                    , Employee "Erik" "Utrecht" 12345
                    , Employee "Ralf" "Koblenz" 1234
                    , Employee "Ray" "Redmond" 1234
                    , Employee "Klaus" "Boston" 3456
                    , Employee "Karl" "Riga" 2345
                    ]

-- | Sum of the total salaries in a company
total :: Company -> Float
total = sum . salaries

-- | Extract all salaries in a company
salaries :: Company -> [Salary]
salaries (Company _ ss) = map getSalary ss
    where
        getSalary :: Employee -> Salary
        getSalary (Employee _ _ s) = s


-- | Cut all salaries in a company in half
cut :: Company -> Company
cut (Company n es) = Company n (map cutEmployee es)
    where
        cutEmployee :: Employee -> Employee
        cutEmployee (Employee n a s) = Employee n a (s/2)

employees :: Company -> [Employee]
employees (Company _ es) = es

