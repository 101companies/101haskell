module Company.Data where

-- The data model is parameterized in what's going to be Float-based salaries
data Company s = Company Name [Department s]
 deriving (Eq, Read, Show)
data Department s = Department Name (Manager s) [Department s] [Employee s]
 deriving (Eq, Read, Show)
data Employee s = Employee Name Address s
 deriving (Eq, Read, Show)
type Manager s = Employee s
type Name = String
type Address = String
