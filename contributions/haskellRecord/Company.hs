module Company where

-- A company consists of company name and employees
data Company
   = Company {
       getCompanyName :: String,
       getEmployees   :: [Employee]
     }
  deriving (Eq, Show, Read)

-- An employee consists of a name, an address, and a salary
data Employee
   = Employee {
       getEmployeeName :: String,
       getAddress      :: String,
       getSalary       :: Float
     }
  deriving (Eq, Show, Read)
