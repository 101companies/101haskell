{-| A data model for a simple 101companies System such that companies are flat containers of employees. -}

module Company.Data where

-- | Companies as pairs of company name and list of employees
type Company = (Name, [Employee])

-- | Employees as triples of name, address, and salary
type Employee = (Name, Address, Salary)

-- | Names as strings
type Name = String

-- | Addresses as strings
type Address = String

-- | Salaries as floats
type Salary = Float