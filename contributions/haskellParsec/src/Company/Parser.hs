module Company.Parser where

import Company.Data
import Text.Parsec

-- Main parser function
parse :: String -> Either ParseError Company
parse = runP 
                 (do
                    spaces 
                    c <- parseCompany
                    eof
                    return c
                 ) ()
                 "input"

-- Shorthand for the parser type
type Parser = Parsec String ()

-- Parse a company
parseCompany :: Parser Company
parseCompany = do
  parseString "company"
  n <- parseLiteral
  parseString "{"
  ds <- many parseDepartment
  parseString "}"
  return (Company n ds)

-- Parse a department
parseDepartment :: Parser Department
parseDepartment = do
  parseString "department"
  n <- parseLiteral
  parseString "{"
  m <- parseEmployee "manager"
  sus <- many parseSubUnit
  parseString "}"
  return (Department n m sus)

-- Parse a subunit (an employee or a department)
parseSubUnit :: Parser SubUnit
parseSubUnit = 
      (parseEmployee "employee" >>= return . EUnit)
  <|> (parseDepartment >>= return . DUnit)

-- Parse an employee
parseEmployee :: String -> Parser Employee
parseEmployee ty = do
  parseString ty
  n <- parseLiteral
  parseString "{"
  parseString "address"
  a <- parseLiteral
  parseString "salary"
  s <- parseFloat
  parseString "}"
  return (Employee n a s)

-- Parse a specific string
parseString :: String -> Parser ()
parseString s = do
  string s
  spaces
  return ()

-- Parse a double-quoted string
parseLiteral :: Parser String
parseLiteral = do 
  string "\""
  s <- many (noneOf "\"")
  string "\""
  spaces
  return s

-- Parse a float
parseFloat :: Parser Float
parseFloat = do
  s <- many1 (digit <|> char '.')
  spaces
  return $ read s
