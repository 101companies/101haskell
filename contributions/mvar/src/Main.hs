module Main where

import Company.Data
import Company.SampleCompany
import Company.Total
import Company.Cut

main = do
   oldTotal <- totalCompany sampleCompany
   print oldTotal
   
   cutC <- cutCompany sampleCompany
   
   newTotal <- totalCompany cutC
   print newTotal