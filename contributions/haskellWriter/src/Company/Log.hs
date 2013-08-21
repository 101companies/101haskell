{-

TODO: We should be using Math.Statistics for median and mean, but the
package is not working with ghc >= 7.2.

-}

module Company.Log where

import Data.List (sort)

-- Logs are lists of log entries.
type Log = [LogEntry]

-- Log entries record the name of the employee and old and new salary.
data LogEntry = 
     LogEntry {
       name :: String, 
       oldSalary :: Float,
       newSalary :: Float 
     }
  deriving (Eq, Show)

-- Given a log, project it to the sorted deltas of changes.
log2deltas :: Log -> [Float]
log2deltas = sort . map delta
  where
    delta entry = newSalary entry - oldSalary entry

-- Given a log, compute the mean of salary deltas.
log2mean :: Log -> Float
log2mean = mean . log2deltas
  where
    mean l = sum l / fromIntegral (length l)

-- Given a log, compute the median of salary deltas.
log2median :: Log -> Float
log2median = median . log2deltas
  where
    -- Quick and dirty median
    median l = l !! (length l `div` 2)
