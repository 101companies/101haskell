{-| The operation of totaling all salaries of all employees in a company -}

module Company.Total where

import Company.Data

import Control.Lens (Fold,sumOf,traversed,from,universeOnOf,folding,beside,Lens')
import Control.Lens.Reified (ReifiedFold(Fold,runFold))
import Control.Applicative ((<|>))

total :: Company -> Float
total = sumOf (folding allCompanyDepartments . departmentSalaries)

allCompanyDepartments :: Company -> [Department]
allCompanyDepartments = universeOnOf (companydepartments.traversed) (subdepartments.traversed)

departmentSalaries :: Fold Department Float
departmentSalaries = runFold (Fold (departmentmanager.from manager) <|> Fold (employees.traversed)).employeesalary.from salary
