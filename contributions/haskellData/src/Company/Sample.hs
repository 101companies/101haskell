{- | Sample data of the 101companies System -}

module Company.Sample where

import Company.Data

-- | A sample company useful for basic tests
sampleCompany :: Company
sampleCompany = Company
  (Name "Acme Corporation")
  [
    Employee (Name "Craig") (Address "Redmond") (Salary 123456),
    Employee (Name "Erik") (Address "Utrecht") (Salary 12345),
    Employee (Name "Ralf") (Address "Koblenz") (Salary 1234),
    Employee (Name "Ray") (Address "Redmond") (Salary 234567),
    Employee (Name "Klaus") (Address "Boston") (Salary 23456),
    Employee (Name "Karl") (Address "Riga") (Salary 2345),
    Employee (Name "Joe") (Address "Wifi City") (Salary 2344)
  ]
