module Company.Total where

import Company.Data
import Company.Deriving
import Control.Monad.Identity
import Data.Generics.Strafunski.StrategyLib.StrategyPrelude
import Data.Generics.Strafunski.StrategyLib.TraversalTheme

total :: Company -> Float
total = sum
      . runIdentity
      . applyTU (crush (constTU [] `adhocTU` getSalary))
  where
    getSalary (Employee _ _ s) = return [s]
