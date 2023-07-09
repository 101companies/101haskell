module Company.Traversal where

import Company.Data

transformSalariesInCompany :: (Salary -> Salary) -> Company -> Company
transformSalariesInCompany f (Company n ds) = Company n ds'
  where
    ds' = map inD ds
    inD (Department n m ds es) = Department n m' ds' es'
      where
        m' = inE m
        ds' = map inD ds
        es' = map inE es
        inE (Employee n a s) = Employee n a (f s)

getSalariesFromCompany :: Company -> [Salary]
getSalariesFromCompany (Company n ds) = concat ds'
  where
    ds' = map fromD ds
    fromD (Department n m ds es) = m' : concat ds' ++ es'
      where
        m' = fromE m
        ds' = map fromD ds
        es' = map fromE es
        fromE (Employee _ _ s) = s
