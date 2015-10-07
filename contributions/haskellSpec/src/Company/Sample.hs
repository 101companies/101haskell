{- | Sample data of the 101companies System -}

module Company.Sample where

import Company.Signature
import Data.Maybe

-- | A sample company useful for basic tests
sampleCompany s = fromJust c
  where
    c = do
           let n = "Acme Corporation"
           es <- sequence [
                   mkEmployee s "Craig" "Redmond" 123456,
                   mkEmployee s "Erik" "Utrecht" 12345,
                   mkEmployee s "Ralf" "Koblenz" 1234,
                   mkEmployee s "Ray" "Redmond" 234567,
                   mkEmployee s "Klaus" "Boston" 23456,
                   mkEmployee s "Karl" "Riga" 2345,
                   mkEmployee s "Joe" "Wifi City" 2344
                 ]
           mkCompany s n es
