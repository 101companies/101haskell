module Main where

import Control.Concurrent.STM

import Company
import Focus
import SampleCompany
import Total
import Cut

main = do
	-- total all company salaries
	total sampleCompany >>= print

	-- cut salaries and total afterwards
	cut sampleCompany >>= total >>= print

