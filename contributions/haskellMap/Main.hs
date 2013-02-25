module Main where

import Company
import Total
import Cut

main 
 = do
      -- De-serialize sample company via read
      txt <- getContents
      let company = read txt

      -- Test that show followed by read returns the same company
      print $ company == read (show company)

      -- Total all salaries
      print $ total company

      -- Cut all salaries and total resulting company
      print $ total (cut company)
