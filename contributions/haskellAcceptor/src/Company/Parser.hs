{-# LANGUAGE ScopedTypeVariables #-} 
module Company.Parser where

import Text.Parsec

-- Main parser function
parse :: String -> Either ParseError ()
parse = runP 
                 (do
                    spaces 
                    c <- parseCompany
                    eof
                    return c
                 ) ()
                 "input"

-- Shorthand for the parser type
type Parser = Parsec String () ()

-- Accept a company
parseCompany :: Parser
parseCompany = do
  parseString "company"
  parseLiteral
  parseString "{"
  many parseDepartment
  parseString "}"

-- Accept a department
parseDepartment :: Parser
parseDepartment = do
  parseString "department"
  parseLiteral
  parseString "{"
  parseEmployee "manager"
  many parseSubUnit
  parseString "}"

-- Accept a subunit (an employee or a department)
parseSubUnit :: Parser
parseSubUnit = 
      parseEmployee "employee"
  <|> parseDepartment

-- Accept an employee
parseEmployee :: String -> Parser
parseEmployee ty = do
  parseString ty
  parseLiteral
  parseString "{"
  parseString "address"
  parseLiteral
  parseString "salary"
  parseFloat
  parseString "}"

-- Accept a specific string
parseString :: String -> Parser
parseString s = do
  string s
  spaces
  return ()

-- Accept a double-quoted string
parseLiteral :: Parser
parseLiteral = do 
  string "\""
  s <- many (noneOf "\"")
  string "\""
  spaces
  return ()

-- Accept a float
parseFloat :: Parser
parseFloat = do
  s <- many1 (digit <|> char '.')
  spaces
  let (_::Float) = read s
  return ()
