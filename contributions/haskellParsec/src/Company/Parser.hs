module Company.Parser where

import Company.Data
import Text.Parsec

-- Main parser function
parseCompany :: String -> Either ParseError Company
parseCompany = runP 
                 (do
                    spaces 
                    c <- pCompany
                    eof
                    return c
                 ) ()
                 "input"

-- Shorthand for the parser type
type P = Parsec String ()

-- Parse a company
pCompany :: P Company
pCompany = do
  pString "company"
  n <- pLit
  pString "{"
  ds <- many pDepartment
  pString "}"
  return $ Company n ds

-- Parse a department
pDepartment :: P Department
pDepartment = do
  pString "department"
  n <- pLit
  pString "{"
  m <- pEmployee "manager"
  sus <- many pSubUnit
  pString "}"
  return $ Department n m sus

-- Parse an employee
pEmployee :: String -> P Manager
pEmployee ty = do
  pString ty
  n <- pLit
  pString "{"
  pString "address"
  a <- pLit
  pString "salary"
  s <- pFloat
  pString "}"
  return $ Employee n a s

-- Parse a subunit (an employee or a department)
pSubUnit :: P SubUnit
pSubUnit = 
      (pEmployee "employee" >>= return . EUnit)
  <|> (pDepartment >>= return . DUnit)

-- Parse a specific string
pString :: String -> P ()
pString s = do
  string s
  spaces
  return ()

-- Parse a double-quoted string
pLit :: P String
pLit = do 
  string "\""
  s <- many (noneOf "\"")
  string "\""
  spaces
  return s

-- Parse a float
pFloat :: P Float
pFloat = do
  s <- many1 (digit <|> char '.')
  spaces
  return $ read s
