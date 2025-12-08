{
module Analisador where

import Tokens
import SintaxeAbstrata
import qualified Lexico as L
}

%name calc Program
%tokentype { Tokens }
%error { parseError }

%token
  CInt    { CINT $$ }
  CDouble { CDOUBLE $$ }
  literal { LITERAL $$ }
  CFloat  { CFLOAT $$ }  -- <--- NOVO
  
  '+'     { ADD }
  '-'     { SUB }
  '*'     { MUL }
  '**'    { POW }
  '/'     { DIV }
  '%'     { RMOD }
  '('     { LPAR }
  ')'     { RPAR }
  '['     { LBRACK }
  ']'     { RBRACK }
  '{'     { LCBRAK }
  '}'     { RCBRAK }
  ','     { COMMA }
  ';'     { SEMICOLON }

  '>='    { MAJEQ }
  '<='    { MINEQ }
  '<'     { MINOR }
  '>'     { MAJOR }
  '=='    { EQUAL }
  '!='    { NEQUAL }

  '&&'    { AND }
  '||'    { OR }
  '!'     { NOT }
  
  '++'    { PLUSPLUS }  
  '--'    { MINUSMINUS }
  '+='    { EQUALPLUS } 
  '-='    { EQUALMINUS }
  '*='    { EQUALMUL }
  '/='    { EQUALDIV }

  id      { ID $$ }
  int     { TINT }
  float   { TFLOAT }     -- <--- NOVO
  string  { TSTRING }
  double  { TDOUBLE }
  void    { TVOID }

  return  { TRETURN }
  sqr     { SQR }
  read    { TREAD }
  '='     { ATRIB }
  print   { TPRINT }

  while   { TWHILE }
  do      { TDO }
  for     { TFOR }
  if      { TIF }
  else    { TELSE }

-- Precedência
%left '||' '&&'
%right '!'
%nonassoc '==' '!=' '>' '<' '>=' '<='
%left '+' '-'
%left '*' '/' '%'
%right '**'
%right UMINUS

%%

-- ============================================================================
-- Estrutura Principal
-- ============================================================================

Program 
  : ListaFuncoes BlocoPrincipal { construirPrograma $1 $2 }
  | BlocoPrincipal              { construirPrograma [] $1 }

ListaFuncoes 
  : FuncaoDefinicao ListaFuncoes { $1 : $2 }
  | FuncaoDefinicao              { [$1] }

-- Definição de Função
FuncaoDefinicao 
  : TipoRetorno id '(' DeclParametros ')' BlocoPrincipal { FuncaoDefinicao ($2 :->: ($4, $1)) $6 }
  | TipoRetorno id '(' ')' BlocoPrincipal                { FuncaoDefinicao ($2 :->: ([], $1)) $5 }

-- Tipos
TipoRetorno 
  : Tipo { $1 }
  | void { TVoid } 
  | float  { TFloat }    -- <--- NOVO

Tipo 
  : int    { TInt }  
  | float  { TFloat }    -- <--- NOVO
  | string { TString }
  | double { TDouble }

-- Parâmetros
DeclParametros 
  : Parametro ',' DeclParametros { $1 : $3 }
  | Parametro                    { [$1] }

Parametro 
  : Tipo id { $2 :#: ($1, 0) }

-- ============================================================================
-- Blocos e Declarações
-- ============================================================================

BlocoPrincipal 
  : '{' Declaracoes ListaCmd '}' { BlocoP $2 $3 } 
  | '{' ListaCmd '}'             { BlocoP [] $2 }

Bloco 
  : '{' ListaCmd '}' { $2 }

Declaracoes 
  : Declaracao Declaracoes { $1 ++ $2 }
  | Declaracao             { $1 }

Declaracao 
  : Tipo ListaId ';' { map (\s -> s :#: ($1, 0)) $2 }

ListaId 
  : id ',' ListaId { $1 : $3 }
  | id             { [$1] }

-- ============================================================================
-- Comandos
-- ============================================================================

ListaCmd 
  : Comando ListaCmd { $1 : $2 }
  | Comando          { [$1] }

Comando 
  : CmdSe         { $1 }
  | CmdEnquanto   { $1 }
  | CmdDoWhile    { $1 }
  | CmdFor        { $1 }
  | CmdAtrib      { $1 } -- Inclui atribuições normais e compostas (+=, -=)
  | CmdIncr       { $1 } 
  | CmdDecr       { $1 } 
  | CmdEscrita    { $1 }
  | CmdLeitura    { $1 }
  | ChamadaProc   { $1 }
  | Retorno       { $1 }

-- Controle de Fluxo
CmdSe 
  : if '(' ExprL ')' Bloco else Bloco { If $3 $5 $7 }
  | if '(' ExprL ')' Bloco            { If $3 $5 [] }

CmdEnquanto 
  : while '(' ExprL ')' Bloco { While $3 $5 }

CmdDoWhile 
  : do Bloco while '(' ExprL ')' ';' { DoWhile $2 $5 }

CmdFor 
  : for '(' CmdSimpleFor ';' ExprL ';' CmdSimpleFor ')' Bloco { For $3 $5 $7 $9 }    

-- Comandos Simples (usados no cabeçalho do For)
CmdSimpleFor 
  : id '=' Expr  { Atrib $1 $3 }
  | id '++'      { Incr $1 }
  | id '--'      { Decr $1 }

-- Atribuições e Operações (Statement com ponto e vírgula)
CmdAtrib 
  : id '=' Expr ';'   { Atrib $1 $3 }
  | id '+=' Expr ';'  { Atrib $1 (Add (IdVar $1) $3) }
  | id '-=' Expr ';'  { Atrib $1 (Sub (IdVar $1) $3) }
  | id '*=' Expr ';'  { Atrib $1 (Mul (IdVar $1) $3) }
  | id '/=' Expr ';'  { Atrib $1 (Div (IdVar $1) $3) }

CmdIncr : id '++' ';' { Incr $1 }
CmdDecr : id '--' ';' { Decr $1 }

-- I/O e Chamadas
CmdEscrita 
  : print '(' Expr ')' ';' { Imp $3 } -- 'Expr' já lida com literals

CmdLeitura 
  : read '(' id ')' ';' { Leitura $3 }

ChamadaProc 
  : ChamadaF ';' { converterChamadaParaProc $1 }

Retorno 
  : return Expr ';' { Ret (Just $2) }
  | return ';'      { Ret Nothing }

-- ============================================================================
-- Expressões
-- ============================================================================

ExprL
  : ExprL '&&' ExprL { And $1 $3 }
  | ExprL '||' ExprL { Or $1 $3 }
  | '!' ExprL        { Not $2 }
  | '(' ExprL ')'    { $2 }
  | ExprR            { Rel $1 }

ExprR
  : Expr '==' Expr { Req $1 $3 }
  | Expr '!=' Expr { Rdif $1 $3 }
  | Expr '>'  Expr { Rgt $1 $3 }
  | Expr '<'  Expr { Rlt $1 $3 }
  | Expr '>=' Expr { Rge $1 $3 }
  | Expr '<=' Expr { Rle $1 $3 }

Expr
  : Expr '+' Expr         { Add $1 $3 }
  | Expr '-' Expr         { Sub $1 $3 }
  | Expr '*' Expr         { Mul $1 $3 }
  | Expr '/' Expr         { Div $1 $3 }
  | Expr '**' Expr        { Pow $1 $3 }
  | Expr '%' Expr        { Mod $1 $3 }
  | sqr '(' Expr ')'      { Sqr $3 }
  | '-' Expr %prec UMINUS { Neg $2 }
  | '(' Expr ')'          { $2 }
  | CInt                  { Const (CInt $1) }
  | CFloat                { Const (CFloat $1) } -- <--- NOVO
  | CDouble               { Const (CDouble $1) }
  | literal               { Lit $1 }        -- Unificado: literal é uma Expr
  | ChamadaF              { $1 }      
  | id                    { IdVar $1 }

-- Chamada de Função (Expressão)
ChamadaF 
  : id '(' ListaParametros ')' { Chamada $1 $3 }
  | id '(' ')'                 { Chamada $1 [] }

ListaParametros 
  : Expr ',' ListaParametros { $1 : $3 }
  | Expr                     { [$1] }

{
-- Exibe erros de sintaxe de forma mais clara
parseError :: [Tokens] -> a
parseError s = error ("Parse error:" ++ show s)

-- ============================================================================
-- Construtores da Árvore Sintática (AST)
-- ============================================================================

-- Constrói o nó raiz do Programa combinando funções e o bloco principal
construirPrograma :: [FuncaoDefinicao] -> BlocoComDeclaracoes -> Programa
construirPrograma listaFuncoes (BlocoP varsGlobais cmdsGlobais) = 
    Prog assinaturas corpos varsGlobais cmdsGlobais
  where
    assinaturas = map extrairAssinatura listaFuncoes
    corpos      = map extrairCorpoFuncao listaFuncoes

-- Extrai apenas a assinatura (Nome, Params, TipoRetorno) da definição
extrairAssinatura :: FuncaoDefinicao -> Funcao
extrairAssinatura (FuncaoDefinicao assinatura _corpo) = assinatura

-- Constrói a tupla (Nome, TodasVariaveis, Bloco) necessária para o Programa
-- Une os parâmetros da função com as variáveis locais declaradas no bloco
extrairCorpoFuncao :: FuncaoDefinicao -> (Id, [Var], Bloco)
extrairCorpoFuncao (FuncaoDefinicao (nome :->: (params, _tipoRet)) (BlocoP varsLocais cmds)) = 
    (nome, params ++ varsLocais, cmds)

-- ============================================================================
-- Auxiliares de Conversão
-- ============================================================================

-- Transforma uma expressão de Chamada de Função em um Comando de Procedimento
-- Útil quando uma função é chamada ignorando seu valor de retorno (ex: void)
converterChamadaParaProc :: Expr -> Comando
converterChamadaParaProc (Chamada id args) = Proc id args
converterChamadaParaProc _ = error "Erro Interno: Tentativa de converter uma expressão inválida em procedimento."

-- Função principal do Parser
parser = do 
        putStr "Nome do arquivo: "
        arquivo <- getLine
        s <- readFile arquivo
        -- Chama o lexer (Lex.alexScanTokens) e depois o parser (calc)
        print (calc (L.alexScanTokens s))
}