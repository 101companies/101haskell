{- | Invariants of the 101companies System -}

module Company.Invariants where

-- The invariants are stated on top of the signature.
import Company.Signature
import Data.List (nub)

-- | Employee invariant: the salary is non-negative
prop_employee i e
  = getSalary i e >= 0

-- | Company invariant: employee names are unique
prop_company i c
  = names == unames
      where
        -- The list of employee names
        names = map (getEmployeeName i) (getEmployees i c)
        -- The list of names after removing doubles
        unames = nub names
