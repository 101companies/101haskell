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
type Acceptor = Parsec String () ()

-- Accept a company
parseCompany :: Acceptor
parseCompany = do
  parseString "company"
  parseLiteral
  parseString "{"
  many parseDepartment
  parseString "}"

-- Accept a department
parseDepartment :: Acceptor
parseDepartment = do
  parseString "department"
  parseLiteral
  parseString "{"
  parseManager
  many parseSubUnit
  parseString "}"

-- Accept a subunit (an employee or a department)
parseSubUnit :: Acceptor
parseSubUnit = 
      parseNonmanager
  <|> parseDepartment


-- Accept a manager
parseManager :: Acceptor
parseManager = parseEmployee "manager"

-- Accept a non-manager
parseNonmanager :: Acceptor
parseNonmanager = parseEmployee "employee"

-- Accept an employee
parseEmployee :: String -> Acceptor
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
parseString :: String -> Acceptor
parseString s = do
  string s
  spaces
  return ()

-- Accept a double-quoted string
parseLiteral :: Acceptor
parseLiteral = do 
  string "\""
  s <- many (noneOf "\"")
  string "\""
  spaces
  return ()

-- Accept a float
parseFloat :: Acceptor
parseFloat = do
  s <- many1 (digit <|> char '.')
  spaces
  let (_::Float) = read s
  return ()
