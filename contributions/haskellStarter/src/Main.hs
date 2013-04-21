import Data.List (sort)

-- Companies as pairs of company name and employees
type Company = (Name, [Employee])

-- Employees as triples of name, address, and salary
type Employee = (Name, Address, Salary)

-- Names as strings
type Name = String

-- Addresses as strings
type Address = String

-- Salaries as floats
type Salary = Float

-- Test data
sampleCompany =
  ( "Acme Corporation",
    [ 
      ("Craig", "Redmond", 123456),
      ("Erik", "Utrecht", 12345),
      ("Ralf", "Koblenz", 1234),
      ("Ray", "Redmond", 234567),
      ("Klaus", "Boston", 23456),
      ("Karl", "Riga", 2345),
      ("Joe", "Wifi City", 2344)
    ] 
  )

-- Total all salaries in a company
total :: Company -> Float
total = sum . salaries

-- Median of all salaries in a company
median :: Company -> Salary
median = median' . sort . salaries

-- Median of a sort list
median' [] = error "Cannot compute median on empty list."
median' [x] = x
median' [x,y] = (x+y)/2
median' l = median' (init (tail l))

-- Extract all salaries in a company

salaries :: Company -> [Salary]
salaries (n, es) = salariesEs es

-- Extract all salaries of lists of employees
salariesEs :: [Employee] -> [Salary]
salariesEs [] = []
salariesEs (e:es) = salaryE e : salariesEs es

-- Extract the salary from an employee
salaryE :: Employee -> Salary
salaryE (_, _, s) = s

-- Cut all salaries in a company
cut :: Company -> Company
cut (n, es) = (n, cutEs es)

-- Cut salaries for lists of employees
cutEs :: [Employee] -> [Employee]
cutEs [] = []
cutEs (e:es) = cutE e : cutEs es

-- Cut the salary of an employee in half
cutE :: Employee -> Employee
cutE (n, a, s) = (n, a, s/2)

-- Illustrative function applications
main = do
  print (total sampleCompany)
  print (median sampleCompany)
  print (total (cut sampleCompany))
