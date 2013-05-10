{- | Sample data of the 101companies System -}

module Company.Sample where

import Company.Data

-- | A sample company useful for basic tests
sampleCompany :: Company
sampleCompany = Company {
  getCompanyName = "Acme Corporation",
  getEmployees = [
      Employee "Craig" "Redmond" 123456,
      Employee "Erik" "Utrecht" 12345,
      Employee "Ralf" "Koblenz" 1234,
      Employee "Ray" "Redmond" 234567,
      Employee "Klaus" "Boston" 23456,
      Employee "Karl" "Riga" 2345,
      Employee "Joe" "Wifi City" 2344
    ]
  }

