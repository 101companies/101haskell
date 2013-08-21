module Company.Cut where

import Company.Data
import Company.Log
import Control.Monad.Writer (Writer, tell)

-- Cut all salaries in a company and log all salaries changes
cut :: Company -> Writer Log Company
cut (Company n ds) =
    mapM cutD ds >>= \ds' -> 
    return (Company n ds')
  where
    -- Cut all salaries in a department
    cutD :: Department -> Writer Log Department
    cutD (Department n m ds es) =
         cutE m >>= \m' ->
         mapM cutD ds >>= \ds' ->
         mapM cutE es >>= \es' ->
         return (Department n m' ds' es')
      where
        -- Cut the salary of an employee in half
        cutE :: Employee -> Writer Log Employee
        cutE (Employee n a s) =
             let
                 s' = s/2
                 log = [ LogEntry {
                           name = n,
                           oldSalary = s,
                           newSalary = s'
                       } ]
             in
                tell log >>= \() ->
                return (Employee n a s')

-- A variant using do notation
cut' :: Company -> Writer Log Company
cut' (Company n ds) =
  do
     ds' <- mapM cutD ds
     return (Company n ds')
  where
    cutD :: Department -> Writer Log Department
    cutD (Department n m ds es) =
      do
         m' <- cutE m
         ds' <- mapM cutD ds
         es' <- mapM cutE es
         return (Department n m' ds' es')
      where
        cutE :: Employee -> Writer Log Employee
        cutE (Employee n a s) =
          do
             let s' = s/2
             let log = [ LogEntry {
                           name = n,
                           oldSalary = s,
                           newSalary = s'
                       } ]
             tell log
             return (Employee n a s')
