{- | Sample data of the 101companies System -}

module Company.Sample where

import Company.Data

-- | A sample company useful for basic tests
sampleCompany :: Company
sampleCompany =
  ( "Acme Corporation",
    [
      Department "Research"
        ("Craig", "Redmond", 123456)
        []
        [
          ("Erik", "Utrecht", 12345),
          ("Ralf", "Koblenz", 1234)
        ],
      Department "Development"
        ("Ray", "Redmond", 234567)
        [
          Department "Dev1"
            ("Klaus", "Boston", 23456)
            [
              Department "Dev1.1"
                ("Karl", "Riga", 2345)
                []
                [("Joe", "Wifi City", 2344)]
            ]
            []
        ]
        []
    ]
  )
