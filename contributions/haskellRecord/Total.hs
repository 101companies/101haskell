module Total where

import Company

-- Total all salaries in a company
total :: Company -> Float
total = sum . map getSalary . getEmployees
