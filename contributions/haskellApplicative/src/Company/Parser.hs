module Company.Parser where

import Company.Data

import Control.Applicative hiding (many, (<|>))
import Text.Parsec

-- Main parser function
parseCompany :: String -> Either ParseError Company
parseCompany = runP (spaces *> pCompany <* eof) ()
               "input"

-- Shorthand for the parser type
type Parser = Parsec String ()

-- Parse a company
pCompany :: Parser Company
pCompany = Company
  <$  pString "company" <*> pLit
  <*  pString "{" <*> many pDepartment <* pString "}"

-- Parse a department
pDepartment :: Parser Department
pDepartment = Department
  <$  pString "department" <*> pLit
  <*  pString "{" <*> pEmployee "manager"
  <*> many pSubUnit <* pString "}"

-- Parse an employee
pEmployee :: String -> Parser Manager
pEmployee ty = Employee
  <$  pString ty <*> pLit
  <*  pString "{" <* pString "address" <*> pLit
  <*  pString "salary" <*> pFloat <* pString "}"

-- Parse a subunit (an employee or a department)
pSubUnit :: Parser SubUnit
pSubUnit = EUnit <$> pEmployee "employee"
       <|> DUnit <$> pDepartment

-- Parse a specific string
pString :: String -> Parser String
pString s = string s <* spaces

-- Parse a double-quoted string
pLit :: Parser String
pLit = string "\"" *> many (noneOf "\"") <* string "\"" <* spaces

-- Parse a float
pFloat :: Parser Float
pFloat = read <$> some (digit <|> char '.') <* spaces
