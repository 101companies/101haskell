{-| The operation to compute the nesting depth of departments in a company -}

module Company.Depth where

import Company.Data

-- | Compute the nesting depth of a company
depth :: Company -> Int
depth (Company _ ds) = max' (map depth' ds)
  where
    -- Maximum of a list of natural numbers
    max' = foldr max 0
    -- Helper at the department level
    depth' :: Department -> Int
    depth' (Department _ _ ds _) = 1 + max' (map depth' ds)
