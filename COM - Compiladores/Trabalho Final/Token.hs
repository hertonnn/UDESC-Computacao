module Token where

data Token
  = TDOUBLE
  | TINT
  | TSTRING
  | TVOID
  | ID String
  | CDOUBLE   Double
  | CINT      Int
  | LITERAL   String
  | TIF
  | TELSE
  | TWHILE
  | TFOR
  | TREAD
  | TRETURN
  | SEMICOLON
  | ADD
  | SUB
  | MUL
  | DIV
  | LPAR
  | RPAR
  | MAJEQ  
  | MINEQ
  | MINOR
  | MAJOR
  | EQUAL
  | NEQUAL
  | LBRACK
  | RBRACK
  | LCBRAK
  | RCBRAK
  | ATRIB
  | TPRINT
  | AND
  | OR
  | NOT
  | COMMA
  deriving (Eq, Show)
  
