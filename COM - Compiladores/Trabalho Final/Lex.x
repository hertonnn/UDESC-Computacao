{
module Lex where

import Token

}

%wrapper "basic"

$digit = [0-9]
$char = [A-Za-z0-9!@#\$\%\^&\*\(\)$white\>\<\.\,\-\+]
-- @double = $digit $digit+\.$digit*
@int = $digit+
@double = '-'?$digit+\.$digit* | \.$digit+
@id     = [A-Za-z]([A-Za-z] | ['_'] | $digit)*
@literal = \"([^\"\\]|\\.)*\" -- \'$char*\' | \"$char*\" não considera caracteres do tipo \", por exemplo; caracteres de escape são tratados separadamente.

tokens :-

<0> $white+ ;
<0> @int {\s -> CINT (read s)}
<0> @double {\s -> CDOUBLE (parseDoubleString s)}
<0> "int" {\s -> TINT}
<0> "string" {\s -> TSTRING}
<0> "double" {\s -> TDOUBLE}
<0> "void" {\s -> TVOID}
<0> @literal {\s -> LITERAL (read s)}
<0> "if" {\s -> TIF}  
<0> "else" {\s -> TELSE}
<0> "while" {\s -> TWHILE}
<0> "for"   {\s -> TFOR}
<0> "read" {\s -> TREAD}
<0> "print" {\s -> TPRINT}
<0> "return" {\s -> TRETURN}
<0> ";" {\s -> SEMICOLON}
<0> @id {\s -> ID s}
<0> "+" {\s -> ADD}  
<0> "-" {\s -> SUB}  
<0> "*" {\s -> MUL}  
<0> "/" {\s -> DIV}  
<0> "(" {\s -> LPAR}  
<0> ")" {\s -> RPAR}
<0> ">=" {\s -> MAJEQ}
<0> "<=" {\s -> MINEQ}
<0> "<" {\s -> MINOR}
<0> ">" {\s -> MAJOR}
<0> "==" {\s -> EQUAL}
<0> "=" {\s -> ATRIB}
<0> "!=" {\s -> NEQUAL}  
<0> "[" {\s -> LBRACK}  
<0> "]" {\s -> RBRACK}
<0> "{" {\s -> LCBRAK}
<0> "}" {\s -> RCBRAK}
<0> "!" {\s -> NOT} 
<0> "&&" {\s -> AND} 
<0> "||" {\s -> OR} 
<0> "," {\s -> COMMA}

{
-- As acoes tem tipo :: String -> Token

testLex = do s <- getLine
             print (alexScanTokens s)

parseDoubleString str = case str of
  ('-':n) -> - (parseDoubleString n)
  ('.':n) -> read ('0':str)
  n       -> read $
               if last n == '.'
               then n ++ "0"
               else n
}