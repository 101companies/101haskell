{- | Signature of the 101companies System -}

module Company.Signature where

-- | Sorts and function symbols with types

data System company employee name address salary format
   = System {

       -- Constructors
       mkCompany :: name -> [employee] -> Maybe company,
       mkEmployee :: name -> address -> salary -> Maybe employee,

       -- Getters
       getCompanyName :: company -> name,
       getEmployees :: company -> [employee],
       getEmployeeName :: employee -> name,
       getAddress :: employee -> address,
       getSalary :: employee -> salary,

       -- Setters
       setEmployee :: employee -> company -> company,
       setSalary :: salary -> employee -> employee,

       -- Functionality (query and transformation)
       total :: company -> salary,
       cut :: company -> company,

       -- Salaries
       zeroSalary :: salary,
       addSalaries :: salary -> salary -> salary,
       halveSalary :: salary -> salary,

       -- De-/serialization
       serialize :: company -> format,
       deserialize :: format -> company

     }
