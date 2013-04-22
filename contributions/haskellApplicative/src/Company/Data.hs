module Company.Data where

-- Named companies with (top-level) departments
data Company = Company Name [Department]
 deriving (Eq, Read, Show)

-- Named departments with manager and sub-units
data Department = Department Name Manager [SubUnit]
 deriving (Eq, Read, Show)

-- Employees with name, address, and salary
data Employee = Employee Name Address Salary
 deriving (Eq, Read, Show)

-- Sub-units as either employees or sub-departments
data SubUnit = EUnit Employee | DUnit Department
 deriving (Eq, Read, Show)

-- Managers as employees
type Manager = Employee

-- Names of companies, departments, and employees
type Name = String

-- Addresses as strings
type Address = String

-- Salaries as floats
type Salary = Float
