{-| A data model for the 101companies System -}

module Company.Data where

-- | A company consists of name and top-level departments
type Company = (Name, [Department])

-- | A department consists of name, manager, and sub-units
type Department = (Name, Manager, [SubUnit])

-- | An employee consists of name, address, and salary
type Employee = (Name, Address, Salary)

-- | A sub-unit is either an employee or a sub-department
data SubUnit = Employee Employee | Department Department
 deriving (Eq, Read, Show)

-- | Managers as employees
type Manager = Employee

-- | Names of companies, departments, and employees
type Name = String

-- | Addresses as strings
type Address = String

-- | Salaries as floats
type Salary = Float
