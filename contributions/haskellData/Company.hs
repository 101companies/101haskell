module Company where

-- A company consists of company name and employees
data Company = Company Name [Employee]
  deriving (Eq, Show, Read)

-- An employee consists of a name, an address, and a salary
data Employee = Employee Name Address Salary
  deriving (Eq, Show, Read)

-- Names as strings
type Name = String

-- Addresses as strings
type Address = String

-- Salaries as floats
type Salary = Float
