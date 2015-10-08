{- | Implementation of the functions of the 101companies System -}

module Company.Functions (
  system,
) where

import Company.Signature
import Company.Representation
import Company.Invariants
import Data.Maybe (fromJust)

-- | Implementation of the system's signature
system :: System Company Employee Name Address Salary Format
system = System {

       -- Constructors enforce invariants
       mkCompany = \n es ->
         let c = Company n es in
           if prop_company system c 
             then Just c
             else Nothing,
       mkEmployee = \n a s ->
         let e = Employee n a s in
           if prop_employee system e
             then Just e
             else Nothing,

       -- Getters defined by pattern matching
       getCompanyName = \(Company n _) -> n,
       getEmployees = \(Company _ es) -> es,
       getEmployeeName = \(Employee n _ _) -> n,
       getAddress = \(Employee _ a _) -> a,
       getSalary = \(Employee _ _ s) -> s,

       -- Replace employee by a map
       setEmployee = \e c ->
         let f e' = if    getEmployeeName system e
                       == getEmployeeName system e'
                      then e
                      else e'
           in mapEmployees f c,

       --
       setSalary = \s (Employee n a _) -> Employee n a s,

       -- Total salaries
       total
         = foldr (addSalaries system) (zeroSalary system)
         . map (getSalary system)
         . getEmployees system,

       -- Cut salaries
       cut = \c ->
         let f e = setSalary system
                     (halveSalary system
                        (getSalary system e)) e
           in mapEmployees f c,

       -- Salaries
       zeroSalary = 0,
       addSalaries = (+),
       halveSalary = (/2),

       -- De-/serialization  
       serialize = show,
       deserialize = read

     }
  where
    -- Convenience function for updating employee list
    mapEmployees f c
      = fromJust (mkCompany system
                            (getCompanyName system c)
                            (map f (getEmployees system c)))
