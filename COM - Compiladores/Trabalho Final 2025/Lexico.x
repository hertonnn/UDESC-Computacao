{
module Lexico where

import Tokens
}

%wrapper "basic"

-- ============================================================================
-- MACROS E REGEX
-- ============================================================================

$digit = [0-9]
$alpha = [a-zA-Z]

-- Números
@int    = $digit+
@double = '-'? $digit+ \. $digit* | \. $digit+
@float  = @double [fF] 

-- Identificadores (começa com letra, segue com letra, número ou underline)
@id     = $alpha ($alpha | $digit | '_')*

-- String Literal (trata aspas escapadas corretamente)
@literal = \" ([^\"\\] | \\ .)* \"

tokens :-

-- ============================================================================
-- WHITESPACE E COMENTÁRIOS (Ignorados)
-- ============================================================================

<0> {
    $white+                         ;
    "//".* ; -- Comentário de linha
    "/*" ([^\*]|[\r\n]|(\*+([^\*\/]|[\r\n])))* \*+ "/" ; -- Comentário de bloco
}

-- ============================================================================
-- PALAVRAS RESERVADAS (Keywords)
-- ============================================================================

<0> {
    -- Tipos
    "int"       { \s -> TINT }
    "string"    { \s -> TSTRING }
    "double"    { \s -> TDOUBLE }
    "void"      { \s -> TVOID }
    "float"     { \s -> TFLOAT } -- <--- NOVO


    -- Controle de Fluxo
    "if"        { \s -> TIF }
    "else"      { \s -> TELSE }
    "while"     { \s -> TWHILE }
    "do"        { \s -> TDO }
    "for"       { \s -> TFOR }
    "return"    { \s -> TRETURN }

    -- Funções Built-in / IO
    "read"      { \s -> TREAD }
    "print"     { \s -> TPRINT }
    "sqr"       { \s -> SQR }
}

-- ============================================================================
-- OPERADORES E PONTUAÇÃO
-- ============================================================================

<0> {
    -- Aritméticos
    "++"        { \s -> PLUSPLUS }
    "--"        { \s -> MINUSMINUS }
    "**"        { \s -> POW }
    "+"         { \s -> ADD }
    "-"         { \s -> SUB }
    "*"         { \s -> MUL }
    "/"         { \s -> DIV }
    "%"         { \s -> RMOD } -- Adicionando módulo

    -- Atribuição Composta
    "+="        { \s -> EQUALPLUS }
    "-="        { \s -> EQUALMINUS }
    "*="        { \s -> EQUALMUL }
    "/="        { \s -> EQUALDIV }

    -- Lógicos e Relacionais
    "&&"        { \s -> AND }
    "||"        { \s -> OR }
    "!"         { \s -> NOT }
    "=="        { \s -> EQUAL }
    "!="        { \s -> NEQUAL }
    ">="        { \s -> MAJEQ }
    "<="        { \s -> MINEQ }
    ">"         { \s -> MAJOR }
    "<"         { \s -> MINOR }
    
    -- Atribuição Simples
    "="         { \s -> ATRIB }

    -- Pontuação e Delimitadores
    ";"         { \s -> SEMICOLON }
    ","         { \s -> COMMA }
    "("         { \s -> LPAR }
    ")"         { \s -> RPAR }
    "["         { \s -> LBRACK }
    "]"         { \s -> RBRACK }
    "{"         { \s -> LCBRAK }
    "}"         { \s -> RCBRAK }
}

-- ============================================================================
-- VALORES E IDENTIFICADORES
-- ============================================================================
-- Nota: Devem vir por último para não capturar palavras reservadas

<0> {
    @int        { \s -> CINT (read s) }
    @double     { \s -> CDOUBLE (parseDolStr s) }
    @literal    { \s -> LITERAL (read s) }
    @id         { \s -> ID s }
    @float      { \s -> CFLOAT (read (init s)) } 
}

{
-- ============================================================================
-- CÓDIGO HASKELL AUXILIAR
-- ============================================================================

-- Função principal para teste rápido do lexer via IO
lexer :: IO ()
lexer = do
    putStrLn "Digite o código para tokenizar:"
    s <- getLine
    print (alexScanTokens s)

-- Trata números double que podem vir como ".5" ou "10." para o read do Haskell
parseDolStr :: String -> Double
parseDolStr str = case str of
  ('-':xs) -> - (parseDolStr xs)     -- Trata negativos recursivamente
  ('.':xs) -> read ('0':'.':xs)      -- Transforma .5 em 0.5
  xs       -> read $ 
                if last xs == '.' 
                then xs ++ "0"       -- Transforma 10. em 10.0
                else xs
}