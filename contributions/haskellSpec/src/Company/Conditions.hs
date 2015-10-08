{- | Pre-/postconditions of the 101companies System -}

{-# LANGUAGE PatternGuards #-}

module Company.Conditions where

-- The conditions are stated on top of the signature.
import Company.Signature

-- | setSalary affects salary, but not name and address
prop_setSalary i e s
  | s >= 0
  , Just e' <- setSalary i s e
  =
     -- The salary is updated
     getSalary i e' == s
     -- The name is NOT updated
  && getEmployeeName i e' == getEmployeeName i e
     -- The address is NOT updated
  && getAddress i e' == getAddress i e
prop_setSalary _ _ _ = True

-- | Total of salaries after cut equals halving totaled salaries before cut
-- | This property is hard to hold up in an implementation!
prop_cut i c 
  = halveSalary i (total i c) == total i (cut i c)

-- | halveSalary decreases positive salaries
prop_halveSalary i s
  | s > 0
  = halveSalary i s < s
prop_halveSalary i s
  | s == 0
  = halveSalary i s == 0
prop_halveSalary _ _ = True
