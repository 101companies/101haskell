module Cut where

import Company
import Log

cut :: Company -> (Company, Log)
cut (Company n ds) = (Company n ds', log)
  where
   (ds', logs) = unzip (map cutD ds)
   log = concat logs
   cutD :: Department -> (Department, Log)
   cutD (Department n m ds es)
     = (Department n m' ds' es', log)
     where
       (m',log1) = cutE m
       (ds', logs2) = unzip (map cutD ds)
       (es', logs3) = unzip (map cutE es)
       log = concat ([log1]++logs2++logs3)
       cutE :: Employee -> (Employee, Log)
       cutE (Employee n a s) = (e', log)
         where
           e' = Employee n a s'
           s' = s/2
           log = [ LogEntry { 
                     name = n,
                     oldSalary = s,
                     newSalary = s'
                 } ]
