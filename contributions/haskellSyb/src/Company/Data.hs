module Company.Data where

-- Named companies with (top-level) departments
data Company = Company Name [Department]
 deriving (Eq, Read, Show)

-- Named departments with manager, sub-departments, and employees
data Department = Department Name Manager [Department] [Employee]
 deriving (Eq, Read, Show)

-- Employees with name, address, and salary
data Employee = Employee Name Address Salary
 deriving (Eq, Read, Show)

-- Managers as employees
type Manager = Employee

-- Names of companies, departments, and employees
type Name = String

-- Addresses as strings
type Address = String

-- Salaries as floats
type Salary = Float
