module Company.Parser where

import Text.Parsec

-- Main parser function
parse :: String -> Either ParseError ()
parse = runP parseCompany () "input"

-- The parser type for simple acceptors
type Acceptor = Parsec String () ()

-- Accept a company
parseCompany :: Acceptor
parseCompany
  =  spaces 
  >> parseString "company"
  >> parseLiteral
  >> parseString "{"
  >> many parseDepartment
  >> parseString "}"
  >> eof

-- Accept a department
parseDepartment :: Acceptor
parseDepartment
  =  parseString "department"
  >> parseLiteral
  >> parseString "{"
  >> parseManager
  >> many parseSubUnit
  >> parseString "}"

-- Accept a subunit (an employee or a department)
parseSubUnit :: Acceptor
parseSubUnit
  =   parseNonmanager
  <|> parseDepartment


-- Accept a manager
parseManager :: Acceptor
parseManager = parseEmployee "manager"

-- Accept a non-manager
parseNonmanager :: Acceptor
parseNonmanager = parseEmployee "employee"

-- Accept an employee
parseEmployee :: String -> Acceptor
parseEmployee ty
  =  parseString ty
  >> parseLiteral
  >> parseString "{"
  >> parseString "address"
  >> parseLiteral
  >> parseString "salary"
  >> parseFloat
  >> parseString "}"

-- Accept a specific string
parseString :: String -> Acceptor
parseString s
  =  string s
  >> spaces
  >> return ()

-- Accept a double-quoted string
parseLiteral :: Acceptor
parseLiteral
  =  string "\""
  >> many (noneOf "\"")
  >> string "\""
  >> spaces
  >> return ()

-- Accept a float
parseFloat :: Acceptor
parseFloat
  =  many1 digit
  >> char '.'
  >> many1 digit
  >> spaces
  >> return ()
