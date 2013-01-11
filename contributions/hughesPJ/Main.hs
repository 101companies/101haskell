module Main where

import Company
import Unparser

main 
 = do

      -- De-serialize sample company via read
      txt <- readFile "../haskellComposition/sampleCompany.txt"
      let company = read txt

      -- Unparse company
      let doc = unparse company
      print doc
