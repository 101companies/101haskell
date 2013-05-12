{-| A data model for the 101companies System -}

module Company.Data where

-- | A company consists of name and employee list
data Company = Company { 
    getCompanyName :: Name,
    getEmployees :: [Employee]
  }
    deriving (Eq, Show, Read)

-- | An employee consists of name, address, and salary
data Employee = Employee {
    getEmployeeName :: Name,
    getAddress :: Address,
    getSalary :: Salary
  }
    deriving (Eq, Show, Read)

-- | Names as strings
newtype Name = Name String
  deriving (Eq, Show, Read)

-- | Addresses as strings
newtype Address = Address String
  deriving (Eq, Show, Read)

-- | Salaries as floats
newtype Salary = Salary Float
  deriving (Eq, Show, Read)
