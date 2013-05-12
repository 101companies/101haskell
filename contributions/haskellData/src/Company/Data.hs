{-| A data model for the 101companies System -}

module Company.Data where

-- | A company consists of name and employee list
data Company = Company Name [Employee]
  deriving (Eq, Show, Read)

-- | An employee consists of name, address, and salary
data Employee = Employee Name Address Salary
  deriving (Eq, Show, Read)

-- | Names as strings
data Name = Name String
  deriving (Eq, Show, Read)

-- | Addresses as strings
data Address = Address String
  deriving (Eq, Show, Read)

-- | Salaries as floats
data Salary = Salary Float
  deriving (Eq, Show, Read)
