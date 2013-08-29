{-# LANGUAGE RankNTypes #-}
{-| A data model for the 101companies System -}

module Company.Data (
  Company,
  Department,
  Employee,
  SubUnit(getSubUnit),
  employee,
  department,
  Manager,
  Name,
  Address,
  Salary
) where

-- | A company consists of name and top-level departments
type Company = (Name, [Department])

-- | A department consists of name, manager, and sub-units
type Department = (Name, Manager, [SubUnit])

-- | An employee consists of name, address, and salary
type Employee = (Name, Address, Salary)

-- | A sub-unit is either an employee or a sub-department
newtype SubUnit
      = SubUnit { getSubUnit ::
          forall x. (Employee -> x)
                 -> (Department -> x)
                 -> x }

-- | Construct a subunit from an employee
employee :: Employee -> SubUnit
employee e = SubUnit (\f _ -> f e)

-- | Construct a subunit from a department
department :: Department -> SubUnit
department d = SubUnit (\_ f -> f d)

-- An auxiliary data type helping with getting typeclass instances
data SubUnit' = Employee Employee | Department Department
  deriving (Eq, Read, Show)

-- Convert a newtype subunit to a data one 
fromSubUnit :: SubUnit -> SubUnit'
fromSubUnit x = getSubUnit x Employee Department

-- Convert a data subunit to a newtype one 
toSubUnit :: SubUnit' -> SubUnit
toSubUnit x
  = case x of
      (Employee e) -> employee e
      (Department d) -> department d

instance Eq SubUnit
 where
   x == y = fromSubUnit x == fromSubUnit y

instance Read SubUnit
 where
  readsPrec p = map (\(x,y) -> (toSubUnit x, y)) . readsPrec p

instance Show SubUnit
 where
  show x = show (getSubUnit x Employee Department)

-- | Managers as employees
type Manager = Employee

-- | Names of companies, departments, and employees
type Name = String

-- | Addresses as strings
type Address = String

-- | Salaries as floats
type Salary = Float
