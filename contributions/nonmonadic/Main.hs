module Main where

import Company
import Cut
import Log

main = do

      -- De-serialize sample company via read
      txt <- readFile "../haskellComposition/sampleCompany.txt"
      let company = read txt

      -- Cut all salaries and gather a log
      let (company', log) = cut company

      -- Print log as well as median of deltas
      print log
      print $ log2deltas log
      print $ log2median log
      print $ log2mean log
