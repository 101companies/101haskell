module Display where

import Company
import Graphics.Gloss
import Graphics.Gloss.Data.Picture

xs :: String -> Picture
xs = color white . scale 0.10 0.10 . text

sm :: String -> Picture
sm = color white . scale 0.20 0.20 . text

-- View

displayCompany :: Company -> Picture
displayCompany c@(Company n es) =

    pictures
        [ instructions
        , totalP
        , nameP
        , pictures $ map displayE (zip [0..] es)
        ]


    where

        -- | Display name of company
        nameP :: Picture
        nameP = translate (-630) 330 $ sm n



        totalP :: Picture
        totalP = translate (-630) 290 $ sm ("Total: $" <> show (total c))



        instructions :: Picture
        instructions =
            pictures
                [ translate (-630) (-350) $ sm "Press C to Cut"
                -- ROMES:TODO Live demo
                , translate (-630) (-320) $ sm "Press D to Delete"
                , translate (-630) (-290) $ sm "Press A to Add Ralf"
                ]



        displayE :: (Float, Employee) -> Picture
        displayE (i, (Employee n _ s)) =
            Translate (150*cos (2*pi*i/nEmployees)) (150*sin (2*pi*i/nEmployees)) $ pictures
                [ color (withAlpha 0.2 mkColor) $ circleSolid (s*0.02)
                , color mkColor $ circle (s*0.02)
                , translate (-15) 0 $ xs n
                ]

            where
                mkColor
                  | s > 10000 = red
                  | s > 1000 = orange
                  | otherwise = yellow




        nEmployees :: Float
        nEmployees = fromIntegral $ length es

