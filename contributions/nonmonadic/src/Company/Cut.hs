module Company.Cut where

import Company.Data
import Company.Log

-- Cut all salaries in a company and log all salaries changes
cut :: Company -> (Company, Log)
cut (Company n ds) = (Company n ds', log)
  where
    (ds', logs) = unzip (map cutD ds)
    log = concat logs
    -- Cut all salaries in a department
    cutD :: Department -> (Department, Log)
    cutD (Department n m ds es)
      = (Department n m' ds' es', log)
      where
        -- Cut the manager's salary
        (m',log1) = cutE m
        -- Cut all salaries in the sub-departments
        (ds', logs2) = unzip (map cutD ds)
        -- Cut all salaries of all immediate employees
        (es', logs3) = unzip (map cutE es)
        -- Compose intermediate logs
        log = concat ([log1]++logs2++logs3)
        -- Cut the salary of an employee in half
        cutE :: Employee -> (Employee, Log)
        cutE (Employee n a s) = (e', log)
          where
            -- The employee with the new salary
            e' = Employee n a s'
            -- The new salary
            s' = s/2
            -- The log entry for this salary change
            log = [ LogEntry { 
                      name = n,
                      oldSalary = s,
                      newSalary = s'
                  } ]
