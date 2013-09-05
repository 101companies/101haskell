{- | Properties of the 101companies System -}

module Company.Properties where

import Company.Signature
import Data.List (nub)

-- | Positiveness of an employee's salary
prop_salary system e
  = salaryOfEmployee system e >= 0

-- | Positiveness of the employees' salary in a company
prop_salary' system c
  = and
  $ map (prop_salary system)
  $ employeesOfCompany system c

-- | Uniqueness of employee names
prop_unique system c
  = length names == length (nub names)
      where names
              = map 
                  (nameOfEmployee system)
                  (employeesOfCompany system c)

-- | Invariant of a company
prop_invariant system c
  =  prop_salary' system c
  && prop_unique system c

-- | Round-tripping property of de-/serialization
prop_serialization system c
  = c == deserialize system (serialize system c)

-- | Observational property of cut
prop_cut system c 
  = halveSalary system (total system c) ==
      total system (cut system c)

-- | Identity property of mapEmployees
prop_map system c
  = c == mapEmployees system id c

-- | Identity property of updateSalary
prop_upd system e
  = e == updateSalary system id e

-- | Pointwise update property of updateSalary
prop_upd' system e s''
  = n' == n && a' == a && s' == s''
    where
      e' = updateSalary system (const s'') e
      n = nameOfEmployee system e
      a = addressOfEmployee system e
      s = salaryOfEmployee system e
      n' = nameOfEmployee system e'
      a' = addressOfEmployee system e'
      s' = salaryOfEmployee system e'

-- | Definitional property of halveSalary
prop_halve system s
  = halveSalary system s == s / 2
