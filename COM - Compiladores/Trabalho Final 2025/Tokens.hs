module Tokens where

data Tokens
  = TDOUBLE
  | TINT
  | TSTRING
  | TVOID
  | ID String
  | CDOUBLE   Double
  | CFLOAT    Float -- <--- NOVO (literal, ex: 1.0f)
  | CINT      Int
  | LITERAL   String
  | TIF
  | TFOR 
  | TFLOAT        -- <--- NOVO (palavra reservada)
  | TELSE
  | TWHILE
  | TDO -- Para o do-while
  | TREAD
  | TRETURN
  | SEMICOLON
  | ADD
  | SUB
  | MUL
  | DIV
  | RMOD -- Adicionado móludo '%'
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
  | PLUSPLUS   -- Adicionado '++'
  | MINUSMINUS -- Adicionado '--'
  | EQUALPLUS -- Adicionando '+='
  | EQUALMINUS
  | EQUALMUL
  | EQUALDIV
  | POW -- '**'  
  | SQR -- 'Raiz quadrada'
  deriving (Eq, Show)
  
