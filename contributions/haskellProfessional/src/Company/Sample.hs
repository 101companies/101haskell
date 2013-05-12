{- | Sample data of the 101companies System -}

module Company.Sample where

import Company.Data

-- | A sample company useful for basic tests
sampleCompany :: Company
sampleCompany =
  Company
    "Acme Corporation"
    [
      Department "Research"
        (Employee "Craig" "Redmond" 123456 Nothing)
        []
        [
          (Employee "Erik" "Utrecht" 12345 (Just "Craig")),
          (Employee "Ralf" "Koblenz" 1234 (Just "Erik"))
        ],
      Department "Development"
        (Employee "Ray" "Redmond" 234567 (Just "Craig"))
        [
          Department "Dev1"
            (Employee "Klaus" "Boston" 23456 Nothing)
            [
              Department "Dev1.1"
                (Employee "Karl" "Riga" 2345  (Just "Craig"))
                []
                [(Employee "Joe" "Wifi City" 2344 Nothing)]
            ]
            []
        ]
        []
    ]
