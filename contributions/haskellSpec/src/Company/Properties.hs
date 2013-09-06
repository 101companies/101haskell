{- | Properties of the 101companies System -}

module Company.Properties where

import Company.Signature
import Data.List (nub)

-- | Invariant of a company
prop_invariant system c
  =  prop_salary' system c
  && prop_unique system c

-- | Positiveness of an employee's salary
prop_salary system e
  = salaryOfEmployee system e >= 0

-- | Positiveness of the employees' salary in a company
prop_salary' system c
  = and
  $ map (prop_salary system)
  $ employeesOfCompany system c

-- | Uniqueness of employee names in a company
prop_unique system c
  = length names == length (nub names)
      where names
              = map 
                  (nameOfEmployee system)
                  (employeesOfCompany system c)

-- | Round-tripping property of de-/serialization
prop_serialization system c
  = c == deserialize system (serialize system c)

-- | Property of total to be zero for a company without employees
prop_total system c
  =  length (employeesOfCompany system c) > 0 
  || total system c == 0 

-- | Property of total to be affected by cutting an individual salary
prop_total' system c i
  = l == 0 && t == 0 
 || l /= 0 && (t-t' >= 0 || t-t' < 1)
    where
     es = employeesOfCompany system c
     l = length es
     e = es !! (i `mod` l)
     s = salaryOfEmployee system e
     s' = halveSalary system s
     c' = mapEmployees system f c
     f e' = if nameOfEmployee system e' == nameOfEmployee system e
              then updateSalary system (const s') e'
              else e'
     t = total system c
     t' = total system c'

-- | Check addition for commutativity and unit
prop_add system s s'
  =  addSalaries system s s' == addSalaries system s' s
  && addSalaries system (zeroSalary system) s == s
  && addSalaries system s (zeroSalary system) == s

-- | Obvious property of cut
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

-- | Property of halveSalary
prop_halve system s
  = s == 0 || s < 0 || halveSalary system s < s
