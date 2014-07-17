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
parseCompany
  =   spaces 
  >>  parseString "company"
  >>  parseLiteral
  >>= \n -> parseString "{"
  >>  many parseDepartment
  >>= \ds -> parseString "}"
  >>  eof
  >>  return (Company n ds)

-- Parse a department
parseDepartment :: Parser Department
parseDepartment
  =   parseString "department"
  >>  parseLiteral
  >>= \n -> parseString "{"
  >>  parseEmployee "manager"
  >>= \m -> many parseSubUnit
  >>= \sus -> parseString "}"
  >>  return (Department n m sus)

-- Parse a subunit (an employee or a department)
parseSubUnit :: Parser SubUnit
parseSubUnit = 
      (parseEmployee "employee" >>= return . EUnit)
  <|> (parseDepartment >>= return . DUnit)

-- Parse an employee
parseEmployee :: String -> Parser Employee
parseEmployee ty
  =   parseString ty
  >>  parseLiteral
  >>= \n -> parseString "{"
  >>  parseString "address"
  >>  parseLiteral
  >>= \a -> parseString "salary"
  >>  parseFloat
  >>= \s -> parseString "}"
  >>  return (Employee n a s)

-- Parse a specific string
parseString :: String -> Parser ()
parseString s
  =  string s
  >> spaces
  >> return ()

-- Parse a double-quoted string
parseLiteral :: Parser String
parseLiteral
  =   string "\""
  >>  many (noneOf "\"")
  >>= \s -> string "\""
  >>  spaces
  >>  return s

-- Parse a float
parseFloat :: Parser Float
parseFloat
  =   many1 digit
  >>= \ds1 -> char '.'
  >>  many1 digit
  >>= \ds2 -> spaces
  >>  return (read (ds1++'.':ds2) :: Float)
