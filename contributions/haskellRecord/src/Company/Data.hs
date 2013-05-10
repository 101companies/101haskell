{-| A data model for a simple 101companies System such that companies are flat containers of employees. -}

module Company.Data where

-- | A company consists of company name and employees
data Company
   = Company {
       getCompanyName :: String,
       getEmployees   :: [Employee]
     }
  deriving (Eq, Show, Read)

-- | An employee consists of a name, an address, and a salary
data Employee
   = Employee {
       getEmployeeName :: String,
       getAddress      :: String,
       getSalary       :: Float
     }
  deriving (Eq, Show, Read)

-- | Names as strings
type Name = String

-- | Addresses as strings
type Address = String

-- | Salaries as floats
type Salary = Float
