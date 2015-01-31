{- | Sample data of the 101companies System -}

module Company.Sample where

import Company.Data

-- | A sample company useful for basic tests
sampleCompany :: Company
sampleCompany =
  ( "Acme Corporation",
    [
      ( "Research",
        ("Craig", "Redmond", 123456),
        [
          EUnit ("Erik", "Utrecht", 12345),
          EUnit ("Ralf", "Koblenz", 1234)
        ]
      ),
      ( "Development",
        ("Ray", "Redmond", 234567),
        [
          DUnit (
            "Dev1",
            ("Klaus", "Boston", 23456),
            [
              DUnit (
                "Dev1.1",
                ("Karl", "Riga", 2345),
                [EUnit ("Joe", "Wifi City", 2344)]
              )
            ]
          )
        ]
      )
    ]
  )
