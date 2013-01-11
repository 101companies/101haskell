module Log where

import Data.List (sort)
import Math.Statistics (median, mean)


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


-- Given a log, project it to the sorted deltas of changes.

log2deltas :: Log -> [Float]
log2deltas = sort . map delta
  where
    delta entry = newSalary entry - oldSalary entry


-- Given a log, compute the median of salary deltas.

log2median :: Log -> Float
log2median = median . log2deltas


-- Given a log, compute the mean of salary deltas.

log2mean :: Log -> Float
log2mean = mean . log2deltas

