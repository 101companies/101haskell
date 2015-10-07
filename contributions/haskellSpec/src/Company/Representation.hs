{- | A specific data representation for the 101companies System -}

module Company.Representation (
  Company,
  Employee,
  Name,
  Address,
  Salary,
  Format
) where

-- | A company consists of a name and an employee list
data Company = Company Name [Employee]
  deriving (Eq, Show, Read)

-- | An employee consists of a name, an address, and a salary
data Employee = Employee Name Address Salary
  deriving (Eq, Show, Read)

-- | Names are plain strings
type Name = String

-- | Addresses are plain strings
type Address = String

-- | Salaries are plain floats
type Salary = Float

-- | Serialization produces strings
type Format = String
