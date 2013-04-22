module Company.Parser where

import Company.Data

import Control.Applicative hiding (many, (<|>))
import Text.Parsec

-- Main parser function
parseCompany :: String -> Either ParseError Company
parseCompany = runP (spaces *> pCompany <* eof) ()
               "input"

-- Shorthand for the parser type
type P = Parsec String ()

-- Parse a company
pCompany :: P Company
pCompany = Company
  <$  pString "company" <*> pLit
  <*  pString "{" <*> many pDepartment <* pString "}"

-- Parse a department
pDepartment :: P Department
pDepartment = Department
  <$  pString "department" <*> pLit
  <*  pString "{" <*> pEmployee "manager"
  <*> many pSubUnit <* pString "}"

-- Parse an employee
pEmployee :: String -> P Manager
pEmployee ty = Employee
  <$  pString ty <*> pLit
  <*  pString "{" <* pString "address" <*> pLit
  <*  pString "salary" <*> pFloat <* pString "}"

-- Parse a subunit (an employee or a department)
pSubUnit :: P SubUnit
pSubUnit = EUnit <$> pEmployee "employee"
       <|> DUnit <$> pDepartment

-- Parse a specific string
pString :: String -> P String
pString s = string s <* spaces

-- Parse a double-quoted string
pLit :: P String
pLit = string "\"" *> many (noneOf "\"") <* string "\"" <* spaces

-- Parse a float
pFloat :: P Float
pFloat = read <$> some (digit <|> char '.') <* spaces
