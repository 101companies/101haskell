module Company.BX where

import Company.Data
import Company.LLTree
import Data.List

get :: Company -> LLTree Float
get (Company n ds) = Fork (map getD ds)
  where
    getD :: Department -> LLTree Float
    getD (Department n m ds es) =  Fork (   [getE m]
                                         ++ map getD ds
                                         ++ map getE es )
      where
        getE :: Employee -> LLTree Float
        getE (Employee _ _ s) = Leaf s

put :: [Float] -> Company -> Company
put fs (Company n ds) = Company n ds'
  where
    ([], ds') = mapAccumL putD fs ds
    putD :: [Float] -> Department -> ([Float], Department)
    putD fs (Department n m ds es) = (fs''', Department n m' ds' es')
      where
        (fs', m') = putE fs m
        (fs'', ds') = mapAccumL putD fs' ds
        (fs''', es') = mapAccumL putE fs'' es
        putE :: [Float] -> Employee -> ([Float], Employee)
        putE (f:fs) (Employee n a s) = (fs, Employee n a f)
