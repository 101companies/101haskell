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
    depth' (Department _ _ sus) = 1 + max' (map depth'' sus)
    -- Helper at the sub-unit level
    depth'' :: SubUnit -> Int
    depth'' (EUnit _) = 0
    depth'' (DUnit d) = depth' d
