-- | Companies as pairs of company name and employee list
type Company = (Name, [Employee])

-- | Employees as triples of name, address, and salary
type Employee = (Name, Address, Salary)

-- | Names as strings
type Name = String

-- | Addresses as strings
type Address = String

-- | Salaries as floats
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

-- Extract all salaries in a company
salaries :: Company -> [Salary]
salaries (n, es) = getSalaries es

-- Extract all salaries of lists of employees
getSalaries :: [Employee] -> [Salary]
getSalaries [] = []
getSalaries (e:es) = getSalary e : getSalaries es

-- Extract the salary from an employee
getSalary :: Employee -> Salary
getSalary (_, _, s) = s

-- Cut all salaries in a company
cut :: Company -> Company
cut (n, es) = (n, cutEmployees es)

-- Cut salaries for lists of employees
cutEmployees :: [Employee] -> [Employee]
cutEmployees [] = []
cutEmployees (e:es) = cutEmployee e : cutEmployees es

-- Cut the salary of an employee in half
cutEmployee :: Employee -> Employee
cutEmployee (n, a, s) = (n, a, s/2)

-- Illustrative function applications
main = do
  print (total sampleCompany)
  print (total (cut sampleCompany))
