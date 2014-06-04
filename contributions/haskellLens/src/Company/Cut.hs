{-| The operation of cutting all salaries of all employees in a company in half -}

module Company.Cut where

import Company.Data

import Control.Lens (Setter',over,traversed,from,setting,transformOnOf)

-- | Cut all salaries in a company
cut :: Company -> Company
cut = over (allCompanyDepartments.departmentSalaries) (/2)

-- | Recursively modify all departments in a company
allCompanyDepartments :: Setter' Company Department
allCompanyDepartments = setting (transformOnOf (companydepartments.traversed) (subdepartments.traversed))

-- | Modify all salaries in a department
departmentSalaries :: Setter' Department Float
departmentSalaries = allDepartmentEmployees.employeesalary.from salary

-- | Modify all employees in a department including the manager
allDepartmentEmployees :: Setter' Department Employee
allDepartmentEmployees = setting (\f -> over (employees.traversed) f . over (departmentmanager.from manager) f)


