{-| The operation to compute the nesting depth of departments in a company -}

module Company.Depth where

import Company.Data
import Data.Monoid
import Data.Max

-- | Compute the nesting depth of a company
depth :: Company -> Int
depth (_, ds) = max' (map depth' ds)
  where
    -- Maximum of a list of natural numbers
    max' = maybe 0 id . getMax . mconcat 
    -- Helper at the department level
    depth' :: Department -> Max Int
    depth' (Department _ _ ds _) = setMax (1 + max' (map depth' ds))
