{- | Properties of the 101companies System -}

module Company.Properties where

-- The properties neither depend on representation nor implementation.
import Company.Signature
import Data.List (nub)

-- | An employee's salary is non-negative
prop_nonnegative i e
  = getSalary i e >= 0

-- | The employee names in a company are unique
prop_uname i c
  = names == unames
      where
        -- The list of employee names
        names = map (getEmployeeName i) (getEmployees i c)
        -- The list of names after removing doubles
        unames = nub names 

-- | setSalary affects salary, but not name and address
prop_update i e s''
  = n' == n && a' == a && s' == s''
    where
      e' = setSalary i s'' e
      n = getEmployeeName i e
      a = getAddress i e
      s = getSalary i e
      n' = getEmployeeName i e'
      a' = getAddress i e'
      s' = getSalary i e'

-- | The total of a company without employees is 0
prop_no_employees i c
  =  length (getEmployees i c) > 0 
  || total i c == 0 

-- | The total is affected by cutting a salary in a specified by position
prop_position i c p
 =  p < 0 -- Position must be non-negative
 || p >= length es -- Position must be below length of employee list
 || t' + s' == t -- New total plus halve salary equals old total
    where
     -- All employees
     es = getEmployees i c
     -- Employee at specified position
     e = es !! p
     -- Salary before halving
     s = getSalary i e
     -- Salary after halving
     s' = halveSalary i s
     -- Modified employee
     e' = setSalary i s' e
     -- Company with modified employee list
     c' = setEmployee i e' c
     -- Total before halving
     t = total i c
     -- Total after halving
     t' = total i c'

-- | Halving total of salaries equals totaling halved salaries
prop_cut i c 
  = halveSalary i (total i c) == total i (cut i c)

-- | addSalaries is commutative
prop_add_commutative i s s'
  =  addSalaries i s s' == addSalaries i s' s

-- | zeroSalary is unit
prop_zero_unit i s
  =  addSalaries i (zeroSalary i) s == s
  && addSalaries i s (zeroSalary i) == s

-- | halveSalary decreases positive salaries
prop_halve i s
  = s == 0 || s < 0 || halveSalary i s < s

-- | Round-tripping property of de-/serialization
prop_serialization i c
  = c == deserialize i (serialize i c)
