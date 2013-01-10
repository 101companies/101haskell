module Log where

import Data.List (sort)
import Math.Statistics (median)


-- Logs are lists of log entries.

type Log = [LogEntry]


-- Log entries record the name of the employee and old and new salary.

data LogEntry = 
     LogEntry {
       name :: String, 
       oldSalary :: Float,
       newSalary :: Float 
     }
  deriving (Show)


-- Given a log, compute the median of salary delta.

deltaMedian :: Log -> Float
deltaMedian log = median (sort (map delta log))
  where
    delta entry = newSalary entry - oldSalary entry
