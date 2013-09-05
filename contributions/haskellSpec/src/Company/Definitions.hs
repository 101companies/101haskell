{- | Definitions of the 101companies System -}

module Company.Definitions where

import Company.Signature

-- | Definition of total
def_total :: System company employee name address salary format
          -> company 
          -> salary
def_total system
  = sumSalaries system
  . map (salaryOfEmployee system)
  . employeesOfCompany system

-- | Definition of cut
def_cut :: System company employee name address salary format
        -> company 
        -> company
def_cut system
  = mapEmployees system 
  $ updateSalary system
  $ halveSalary system
