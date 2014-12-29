module Company.Total where

import Company.Data

totalCompany :: Company -> Float
totalCompany (Company _ depts)= sum $ map totalDept depts

totalDept :: Department -> Float
totalDept (Department _ m sus) = sum $ concat [ [totalEmployee m]
                                                  , map totalSubunit sus]

totalEmployee :: Employee -> Float
totalEmployee (Employee _ _ s) = s

totalSubunit :: SubUnit -> Float
totalSubunit (EUnit e) = totalEmployee e
totalSubunit (DUnit d) = totalDept d
