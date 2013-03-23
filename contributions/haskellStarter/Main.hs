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
total (n, es) = totalEs es

-- Total salaries of lists of employees
totalEs :: [Employee] -> Float
totalEs [] = 0
totalEs (e:es) = totalE e + totalEs es

-- Extract the salary from an employee
totalE :: Employee -> Float
totalE (_, _, s) = s

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
  print (total (cut sampleCompany))
