module Company.Total where

import Company.Data
import Data.TermRep

total :: TermRep -> Float
total (FloatRep f) = f
total (ListRep ts) = sum (map total ts)
total (ConstrRep _ ts) = sum (map total ts)
total _ = 0
