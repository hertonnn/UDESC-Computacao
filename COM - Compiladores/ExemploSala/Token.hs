module Token where

data Token
  = NUM Int
  | ADD
  | SUB
  | MUL
  | DIV
  | LPAR
  | RPAR
  deriving (Eq, Show)
  
