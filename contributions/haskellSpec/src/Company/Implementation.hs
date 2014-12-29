{- | Implementation of the 101companies System -}

module Company.Implementation (
  system,
  Company, mkCompany,
  Employee, mkEmployee,
  Name,
  Address,
  Salary,
  Format
) where

import Company.Signature
import Company.Properties

-- | A company consists of name and employee list
data Company = Company Name [Employee]
  deriving (Eq, Show, Read)

-- | Invariant-aware company constructor
mkCompany :: Name -> [Employee] -> Maybe Company
mkCompany n es
  = if prop_unique system c 
      then Just c
      else Nothing
  where
    c = Company n es

-- | An employee consists of name, address, and salary
data Employee = Employee Name Address Salary
  deriving (Eq, Show, Read)

-- | Invariant-aware company constructor
mkEmployee :: Name -> Address -> Salary -> Maybe Employee
mkEmployee n a s
  = if prop_salary system e
      then Just e
      else Nothing
  where
    e = Employee n a s

-- | Names as strings
type Name = String

-- | Addresses as strings
type Address = String

-- | Salaries as floats
type Salary = Float

-- | String format
type Format = String

-- | Implementation of the system's signature
system :: System
            Company
            Employee
            Name
            Address
            Salary 
            Format
system = System {

  nameOfCompany
    = \(Company n _) -> n,

  employeesOfCompany
    = \(Company _ es) -> es,

  nameOfEmployee
    = \(Employee n _ _) -> n,

  addressOfEmployee
    = \(Employee _ a _) -> a,

  salaryOfEmployee
    = \(Employee _ _ s) -> s,

  total
    = foldr (addSalaries system) (zeroSalary system)
    . map (salaryOfEmployee system)
    . employeesOfCompany system,

  zeroSalary
    = 0,

  addSalaries
    = (+),

  cut
    = mapEmployees system 
    $ updateSalary system
    $ halveSalary system,

  mapEmployees 
    = \f (Company n es) -> Company n (map f es),

  updateSalary
    = \f (Employee n a s) -> Employee n a (f s),

  halveSalary
    = (/2),

  serialize
    = show,

  deserialize
    = read

}
