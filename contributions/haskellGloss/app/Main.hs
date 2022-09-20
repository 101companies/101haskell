module Main where

import Company
import Display

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game


simulationController :: Float -> Company -> Company
simulationController _ c = raise (< 10000) 10 c







gameController :: Event -> Company -> Company
gameController evt comp = case evt of

    EventKey (Char 'c') Up _ _ -> cut comp

    EventKey (Char 'd') Up _ _ -> case comp of
        Company n [] -> comp
        Company n (x:xs) -> Company n xs
    
    EventKey (Char 'a') Up _ _ -> case comp of
        Company n xs -> Company n (Employee "Ralf" "Addr" 4000:xs) 

    _ -> comp














main :: IO ()
main = do
    play
        FullScreen -- Display
        black      -- Background color
        30         -- Number of simulation steps to take for each second of real time.
        sampleCompany  -- The company at the beginning of the game
        displayCompany -- How to display a company? Company -> Picture
        gameController -- How to react to events ?
        simulationController -- How to advance time in the simulation?








        -- Other Display
        -- (InWindow
        --     "101companies" -- Window name
        --     (1280, 720)
        --     (10,10)
        -- ) -- Window
