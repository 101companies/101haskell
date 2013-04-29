{- | Historical sample data of the 101companies System -}

module Company.Sample where

import Company.Data

-- | A sample company with historical data
sampleCompany :: [(Year, Company)]
sampleCompany = [
    -- First year of recording
    ( 2007,
      ( "Acme Corporation",
        [ 
          ("Craig", "Redmond", 123456),
          ("Erik", "Utrecht", 12345),
          ("Ralf", "Koblenz", 1234),
          ("Ray", "Redmond", 234567),
          ("Klaus", "Boston", 23456),
          ("Karl", "Riga", 2345),
          ("Joe", "Wifi City", 2344)
        ] 
      )
    ),
    -- One extra employee and selective salary raise
    ( 2008,
      ( "Acme Corporation",
        [ 
          ("Craig", "Redmond", 123456),
          ("Erik", "Utrecht", 12345),
          ("Ralf", "Koblenz", 4321),
          ("Ray", "Redmond", 234567),
          ("Klaus", "Boston", 65432),
          ("Karl", "Riga", 2345),
          ("Joe", "Wifi City", 2344),
          ("Joanna", "Braga", 88888888)
        ] 
      )
    ),
    -- Two employees fired and everyone looses a digit
    ( 2009,
      ( "Acme Corporation",
        [ 
          ("Craig", "Redmond", 12345),
          ("Erik", "Utrecht", 1234),
          ("Ray", "Redmond", 23456),
          ("Klaus", "Boston", 6543),
          ("Karl", "Riga", 234),
          ("Joanna", "Braga", 8888888)
        ] 
      )
    ),
    -- Economy's recovering: hires and raise
    ( 2010,
      ( "Acme Corporation",
        [ 
          ("Craig", "Redmond", 12346),
          ("Erik", "Utrecht", 1235),
          ("Ray", "Redmond", 23457),
          ("Klaus", "Boston", 6544),
          ("Karl", "Riga", 235),
          ("Joanna", "Braga", 8888889),
          ("Berenike", "Koblenz", 55555),
          ("Bernadette", "Koblenz", 55555)
        ] 
      )
    )
  ]
