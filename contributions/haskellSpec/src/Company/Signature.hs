{- | Signature of the 101companies System -}

module Company.Signature where

-- | Types and functions of the signature
data System
       company
       employee
       name
       address
       salary
       format

   = System {

       nameOfCompany :: company -> name,
       employeesOfCompany :: company -> [employee],
       nameOfEmployee :: employee -> name,
       addressOfEmployee :: employee -> address,
       salaryOfEmployee :: employee -> salary,
       total :: company -> salary,
       sumSalaries :: [salary] -> salary,
       cut :: company -> company,
       mapEmployees :: (employee -> employee) -> company -> company,
       updateSalary :: (salary -> salary) -> employee -> employee,
       halveSalary :: salary -> salary,
       serialize :: company -> format,
       deserialize :: format -> company

     }
