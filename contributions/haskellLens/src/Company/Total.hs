{-| The operation of totaling all salaries of all employees in a company -}

module Company.Total where

import Company.Data

import Control.Lens (Fold,sumOf,traversed,from,universeOnOf,folding)
import Control.Lens.Reified (ReifiedFold(Fold,runFold))
import Control.Applicative ((<|>))

-- | Total all salaries in a company
total :: Company -> Float
total = sumOf (allCompanyDepartments . departmentSalaries)

-- | Fold recursively over all company departments
allCompanyDepartments :: Fold Company Department
allCompanyDepartments = folding (universeOnOf (companydepartments.traversed) (subdepartments.traversed))

-- | Fold over all salaries in a department
departmentSalaries :: Fold Department Float
departmentSalaries = allDepartmentEmployees.employeesalary.from salary

-- | Fold over all employees in a department including the manager
allDepartmentEmployees :: Fold Department Employee
allDepartmentEmployees = runFold (Fold (departmentmanager.from manager) <|> Fold (employees.traversed))
