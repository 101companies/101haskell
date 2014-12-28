module Main where

import Company
import Total
import Cut
import SampleCompany

main = do
      -- print total
      print $ total sampleCompany

      -- print cut total
      print $ total (cut sampleCompany)
