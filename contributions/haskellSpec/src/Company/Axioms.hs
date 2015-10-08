{- | Axioms of the 101companies System -}

module Company.Axioms where

-- The axioms are stated on top of the signature.
import Company.Signature

-- | setSalary affects salary, but not name and address
prop_setSalary i e s''
     -- The salary is updated
  =  getSalary i e' == s''
     -- The name is NOT updated
  && getEmployeeName i e' == getEmployeeName i e
     -- The address is NOT updated
  && getAddress i e' == getAddress i e
    where
      -- Updated employee
      e' = setSalary i s'' e

-- | The total of a company without employees is 0
prop_total_no_employees i c
  =  length (getEmployees i c) > 0 
  || total i c == 0 

-- | The total is affected by cutting a salary in a specified by position
prop_cut_at_position i c p
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
