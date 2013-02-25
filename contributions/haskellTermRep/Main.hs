{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Company
import Conversion
import Total
import Cut
import TermRep

main 
 = do

      -- De-serialize sample company via read
      txt <- getContents
      let (company::Company) = read txt

      -- Convert to universal representation
      let rep = explode company
      print rep

      -- Total all salaries
      print $ total rep

      -- Cut all salaries
      let rep' = cut rep

      -- Total after cut
      print $ total rep'

      -- Convert back to typed representation
      let (company'::Company) = implode rep'
      print company'
