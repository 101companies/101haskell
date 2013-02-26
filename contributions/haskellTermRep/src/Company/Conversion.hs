module Conversion where

import Company
import TermRep

instance Term Company
  where
    explode (Company n ds) =
      ConstrRep "Company" [ explode n,
                            explode ds
                          ]
    implode (ConstrRep "Company" [n, ds]) =
      Company (implode n)
              (implode ds)

instance Term Department
  where
    explode (Department n m ds es) =
      ConstrRep "Department" [ explode n,
                               explode m,
                               explode ds,
                               explode es
                             ]
    implode (ConstrRep "Department" [n, m, ds, es]) =
      Department (implode n)
                 (implode m)
                 (implode ds)
                 (implode es)

instance Term Employee
  where
    explode (Employee n a s) =
      ConstrRep "Employee" [ explode n,
                             explode a,
                             explode s
                           ]
    implode (ConstrRep "Employee" [n, a, s]) =
      Employee (implode n)
               (implode a)
               (implode s)

