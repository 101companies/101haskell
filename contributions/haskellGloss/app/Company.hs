module Company where

-- Model

data Company = Company Name [Employee]

data Employee = Employee Name Address Salary

type Name = String
type Address = String
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


raise :: (Salary -> Bool) -> Salary -> Company -> Company
raise p inc (Company n es) = Company n (map (raiseEmployee p inc) es)
    where
        raiseEmployee :: (Salary -> Bool) -> Salary -> Employee -> Employee
        raiseEmployee p inc (Employee n a s) = Employee n a ((if p s then inc else 0) + s)

