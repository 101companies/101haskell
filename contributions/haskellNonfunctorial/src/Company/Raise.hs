module Company.Raise where

import Company.Data
import Company.Traversal

raise :: Company -> Company
raise = transformSalariesInCompany (*1.01) 
