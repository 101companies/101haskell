{-| The operation of cutting all salaries of all employees in a company in half -}

module Company.Cut where

import Company.Data

import Control.Lens (Traversal',over,traversed,from)

cut :: Company -> Company
cut = over companySalaries (/2)

companySalaries :: Traversal' Company Float
companySalaries = companydepartments.traversed.employees.traversed.employeesalary.from salary
