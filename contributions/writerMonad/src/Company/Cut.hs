module Company.Cut where

import Company.Data
import Company.Log
import Control.Monad.Writer


-- A variant NOT using do notation

cut :: Company -> (Company, Log)
cut (Company n ds)
  = let (ds',log) = runWriter (mapM cutD ds) in
      (Company n ds', log)
  where
    cutD :: Department -> Writer Log Department
    cutD (Department n m ds es) =
         cutE m >>= \m' ->
         mapM cutD ds >>= \ds' ->
         mapM cutE es >>= \es' ->
         return (Department n m' ds' es')
      where
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

cut' :: Company -> (Company, Log)
cut' (Company n ds)
  = let (ds',log) = runWriter (mapM cutD ds) in
      (Company n ds', log)
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
