module Company.Cut where

import Company.Data
import Company.Traversal

cut :: Company -> Company
cut = transformSalariesInCompany (/2) 
