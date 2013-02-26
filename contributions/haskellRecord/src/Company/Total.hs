module Company.Total where

import Company.Data

-- Total all salaries in a company
total :: Company -> Float
total = sum . map getSalary . getEmployees
