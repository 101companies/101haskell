{- | Sample data of the 101companies System -}

module Company.Sample where

import Company.Implementation
import Data.Maybe

-- | A sample company useful for basic tests
sampleCompany :: Company
sampleCompany = fromJust c
  where
    c = do
           let n = "Acme Corporation"
           es <- sequence [
                   mkEmployee "Craig" "Redmond" 123456,
                   mkEmployee "Erik" "Utrecht" 12345,
                   mkEmployee "Ralf" "Koblenz" 1234,
                   mkEmployee "Ray" "Redmond" 234567,
                   mkEmployee "Klaus" "Boston" 23456,
                   mkEmployee "Karl" "Riga" 2345,
                   mkEmployee "Joe" "Wifi City" 2344
                 ]
           mkCompany n es
