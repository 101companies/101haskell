module Company.Parser where

import Company.Data
import Text.Parsec

-- Main parser function
parse :: String -> Either ParseError Company
parse = runP parseCompany () "input"

-- Shorthand for the parser type
type Parser = Parsec String ()

-- Parse a company
parseCompany :: Parser Company
parseCompany = Company
  <$> (spaces 
  >>  parseString "company"
  >>  parseLiteral)
  <*  parseString "{"
  <*> many parseDepartment
  <*  parseString "}"
  <*  eof

-- Parse a department
parseDepartment :: Parser Department
parseDepartment = Department
  <$> (parseString "department"
  >>  parseLiteral)
  <*  parseString "{"
  <*> parseEmployee "manager"
  <*> many parseSubUnit
  <*  parseString "}"

-- Parse a subunit (an employee or a department)
parseSubUnit :: Parser SubUnit
parseSubUnit = 
      (EUnit <$> parseEmployee "employee")
  <|> (DUnit <$> parseDepartment)

-- Parse an employee
parseEmployee :: String -> Parser Employee
parseEmployee ty = Employee
  <$> (parseString ty
  *>  parseLiteral)
  <*  parseString "{"
  <*  parseString "address"
  <*> parseLiteral
  <*  parseString "salary"
  <*> parseFloat
  <*  parseString "}"

-- Parse a specific string
parseString :: String -> Parser ()
parseString s
  =  string s
  >> spaces
  >> return ()

-- Parse a double-quoted string
parseLiteral :: Parser String
parseLiteral
  = id
  <$> string "\""
  *>  many (noneOf "\"")
  <*  string "\""
  <*  spaces

-- Parse a float
parseFloat :: Parser Float
parseFloat
  = (\ds1 c ds2 -> read (ds1++c:ds2))
  <$> many1 digit
  <*> char '.'
  <*> many1 digit
  <*  spaces
