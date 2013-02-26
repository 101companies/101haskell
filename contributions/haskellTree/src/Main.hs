module Main where

import Company.Data
import Company.BX
import Company.Total
import Company.Cut
import Data.Foldable (toList)

main
 = do

      -- De-serialize sample company via read
      txt <- getContents
      let company = read txt

      -- Project to tree of floats
      let tree = get company
      print tree

      -- Project further to list of floats
      let list = toList tree
      print list

      -- Total all salaries
      print $ total company

      -- Cut all salaries
      let company' = cut company

      -- Total after cut
      print $ total company'
