{-| The operation of totaling all salaries of all employees in a company -}

module Company.Total where

import Company.Data

-- | Total all salaries in a company
total :: Company -> Float
total
  = sum 
  . map (\(_, _, s) -> s)
  . snd
