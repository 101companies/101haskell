module Company where

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
