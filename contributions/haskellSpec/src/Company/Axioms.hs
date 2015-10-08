{- | Axioms of the 101companies System -}

{-# LANGUAGE PatternGuards #-}

module Company.Axioms where

-- The axioms are stated on top of the signature.
import Company.Signature

-- | The total of a company without employees is 0
prop_total_no_employees i c
  | length (getEmployees i c) == 0 
  = total i c == 0 
prop_total_no_employees _ _ = True

-- | The total is affected by cutting a salary in a specified by position
prop_cut_at_position i c p
 | es <- getEmployees i c -- All employees
 , p < 0 &&  p >= length es -- Position must be valid
 , e <- es !! p -- Employee at specified position
 , s <- getSalary i e -- Salary before halving
 , s' <- halveSalary i s -- Salary after halving
 , Just e' <- setSalary i s' e -- Modified employee
 , Just c' <- setEmployee i e' c -- Company with modified employee list
 =
 -- New total plus halve salary equals old total
   total i c' + s' == total i c
prop_cut_at_position _ _ _ = True

-- | addSalaries is commutative
prop_add_commutative i s s'
  =  addSalaries i s s' == addSalaries i s' s

-- | zeroSalary is unit
prop_zero_unit i s
  =  addSalaries i (zeroSalary i) s == s
  && addSalaries i s (zeroSalary i) == s

-- | Round-tripping property of de-/serialization
prop_serialization i c
  = c == deserialize i (serialize i c)
