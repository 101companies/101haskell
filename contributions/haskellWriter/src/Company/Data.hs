module Company.Data where

-- | A company consists of name and top-level departments
data Company = Company Name [Department]
 deriving (Eq, Read, Show)

-- | A department consists of name, manager, sub-departments, and employees
data Department = Department Name Manager [Department] [Employee]
 deriving (Eq, Read, Show)

-- | An employee consists of name, address, and salary
data Employee = Employee Name Address Salary
 deriving (Eq, Show, Read)

-- | Managers as employees
type Manager = Employee

-- | Names of companies, departments, and employees
type Name = String

-- | Addresses as strings
type Address = String

-- | Salaries as floats
type Salary = Float
