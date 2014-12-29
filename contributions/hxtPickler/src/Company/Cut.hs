module Company.Cut where

import Company.Data

cutCompany :: Company -> Company
cutCompany (Company n depts) = Company n $ map cutDept depts

cutDept :: Department -> Department
cutDept (Department n m sus) = Department n
                                    (cutEmployee m)
                                    (map cutSubunit sus)

cutEmployee :: Employee -> Employee
cutEmployee (Employee n a s) = Employee n a (s/2)

cutSubunit :: SubUnit -> SubUnit
cutSubunit (EUnit e) = EUnit (cutEmployee e)
cutSubunit (DUnit d) = DUnit (cutDept d)
