{-| A data model for the 101companies System -}

module Company.Data where

-- | Companies as pairs of name and employee list
type Company = (Name, [Employee])

-- | Employees as triples of name, address, and salary
type Employee = (Name, Address, Salary)

-- | Names as strings
type Name = String

-- | Addresses as strings
type Address = String

-- | Salaries as floats
type Salary = Float
