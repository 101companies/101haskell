{-| A data model for the 101companies System -}

module Company.Data where

-- | Companies as pairs of company name and employee list
type Company = (Name, [Employee])

-- | An employee consists of name, address, and salary
type Employee = (Name, Address, Salary)

-- | Names as strings
type Name = String

-- | Addresses as strings
type Address = String

-- | Salaries as floats
type Salary = Float
