{- | Implementation of the 101companies System -}

module Company.Implementation where

import Company.Signature
import Company.Definitions

-- | Companies as pairs of name and employee list
data Company = Company Name [Employee]
  deriving (Eq, Show, Read)

-- | Employees as triples of name, address, and salary
data Employee = Employee Name Address Salary
  deriving (Eq, Show, Read)

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
    = def_total system,

  sumSalaries
    = sum,

  cut
    = def_cut system,

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
