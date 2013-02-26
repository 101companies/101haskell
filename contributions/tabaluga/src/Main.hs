module Main where

import Company.Data
import Company.Total
import Company.Cut
import Company.Depth

main
 = do

      -- De-serialize sample company via read
      txt <- getContents
      let company = read txt

      -- Test that show followed by read returns the same company
      print $ company == read (show company)

      -- Total all salaries
      print $ total company

      -- Cut all salaries
      let company' = cut company

      -- Total after cut
      print $ total company'

      -- Compute depth of department nesting
      print $ depth company
