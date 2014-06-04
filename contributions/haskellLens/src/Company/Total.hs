{-| The operation of totaling all salaries of all employees in a company -}

module Company.Total where

import Company.Data

import Control.Lens (Traversal',sumOf,traversed,from)

total :: Company -> Float
total = sumOf companySalaries

companySalaries :: Traversal' Company Float
companySalaries = companydepartments.traversed.employees.traversed.employeesalary.from salary
