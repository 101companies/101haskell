module Company.Cut where

import Company.Data
import Company.Functorial

cut :: Company Float -> Company Float
cut = fmap (/2) 
