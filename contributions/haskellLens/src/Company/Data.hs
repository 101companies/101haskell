{-| A data model for the 101companies System -}

{-# LANGUAGE TemplateHaskell #-}

module Company.Data where

import Control.Lens

-- | Names of companies, departments, and employees
newtype Name = Name String deriving (Eq, Read, Show)
makeIso ''Name

-- | Addresses as strings
newtype Address = Address String deriving (Eq, Read, Show)
makeIso '' Address

-- | Salaries as floats
newtype Salary = Salary Float deriving (Eq, Read, Show)
makeIso ''Salary

-- | An employee consists of name, address, and salary
data Employee = Employee {
    _employeename :: Name,
    _employeesaddress :: Address,
    _employeesalary :: Salary} deriving (Eq, Read, Show)
makeLenses ''Employee

-- | Managers as employees
newtype Manager = Manager Employee deriving (Eq, Read, Show)
makeIso ''Manager


-- | A department consists of name, manager, sub-departments, and employees
data Department = Department {
    _departmentname :: Name,
    _departmentmanager :: Manager,
    _subdepartments :: [Department],
    _employees :: [Employee]} deriving (Eq, Read, Show)
makeLenses ''Department

-- | A company consists of name and top-level departments
data Company = Company {
    _companyname :: Name,
    _companydepartments :: [Department] } deriving (Eq, Read, Show)
makeLenses ''Company

