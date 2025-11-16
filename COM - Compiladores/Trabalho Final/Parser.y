{
module Parser where

import Token
import RI
import qualified Lex as L

}


%name calc Programa
%tokentype { Token }
%error { parseError }
%token

  CInt    { CINT $$ }
  CDouble { CDOUBLE $$ }
  literal { LITERAL $$ }
  '+'     { ADD }
  '-'     { SUB }
  '*'     { MUL }
  '/'     { DIV }

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

  id      { ID $$ }

  int     { TINT }
  string  { TSTRING }
  double  { TDOUBLE }
  void    { TVOID }

  return  { TRETURN }
  read    { TREAD }
  '='     { ATRIB }
  print   { TPRINT }

  while   { TWHILE }
  for     { TFOR }
  if      { TIF }
  else    { TELSE }


%left '||' '&&'
%right '!'
%nonassoc '==' '!=' '>' '<' '>=' '<='
%left '+' '-'
%left '*' '/'
%right UMINUS

%%

-- DEFINIÇÕES DE EXPRESSÕES

ExprL
  : ExprL '&&' ExprL    { And $1 $3 }
  | ExprL '||' ExprL    { Or $1 $3 }
  | '!' ExprL           { Not $2 }
  | '(' ExprL ')'       { $2}
  | ExprR               { Rel $1 }

ExprR
  : Expr '==' Expr    { Req $1 $3 }
  | Expr '!=' Expr    { Rdif $1 $3}
  | Expr '>'  Expr    { Rgt $1 $3 }
  | Expr '<'  Expr    { Rlt $1 $3 }
  | Expr '>=' Expr    { Rge $1 $3 }
  | Expr '<=' Expr    { Rle $1 $3 }

Expr
    : Expr '+' Expr         { Add $1 $3 }
    | Expr '-' Expr         { Sub $1 $3 }
    | Expr '*' Expr         { Mul $1 $3 }
    | Expr '/' Expr         { Div $1 $3 }
    | '-' Expr %prec UMINUS { Neg $2 }
    | '(' Expr ')'          { $2 }
    | CInt                  { Const (CInt $1) }
    | CDouble               { Const (CDouble $1) }
    | ChamadaFuncao         { $1 }      -- Adicionei
    | id                    { IdVar $1 }

-- DEFINIÇÕES DA LINGUAGEM CONFORME TRABALHO

Programa  : ListaFuncoes BlocoPrincipal {case $2 of
                                         BlocoPrinc v c -> Prog (map (funcaoDeFundef) $1) (map (defDeFundef) $1) v c}
          | BlocoPrincipal {case $1 of
                           BlocoPrinc v c -> Prog [] [] v c}

ListaFuncoes  : ListaFuncoes Funcao   {$1 ++ [$2]}  -- Lista de FunDefs
              | Funcao                {[$1]}

Funcao  : TipoRetorno id '(' DeclParametros ')' BlocoPrincipal    {FunDef ($2 :->: ($4, $1)) $6}
        | TipoRetorno id '(' ')' BlocoPrincipal                   {FunDef ($2 :->: ([], $1)) $5}

TipoRetorno : Tipo  { $1 }
            | void  { TVoid } -- Desnecessário pois Tipo já tem TVoid

DeclParametros  : DeclParametros ',' Parametro  {$1 ++ [$3]}
                | Parametro                     {[$1]}

Parametro : Tipo id {$2:#:($1,0)}

BlocoPrincipal  : '{' Declaracoes ListaCmd '}'  {BlocoPrinc $2 $3} 
                | '{' ListaCmd '}'              {BlocoPrinc [] $2}

Declaracoes : Declaracoes Declaracao  {$1 ++ $2}
            | Declaracao              {$1}

Declaracao : Tipo ListaId ';'   {map (\s -> s:#:($1,0)) $2}

Tipo  : int     { TInt }  
      | string  { TString }
      | double  { TDouble }

ListaId : ListaId ',' id  {$1 ++ [$3]}
        | id              {[$1]}

Bloco : '{' ListaCmd '}' {$2}

ListaCmd  : ListaCmd Comando  {$1 ++ [$2]}
          | Comando           {[$1]}

Comando : CmdSe {$1}
        | CmdEnquanto {$1}
        | CmdFor      {$1}
        | CmdAtrib    {$1}
        | CmdEscrita  {$1}
        | CmdLeitura  {$1}
        | ChamadaProc {$1}
        | Retorno     {$1}

Retorno : return Expr ';'     {Ret (Just $2)}
        | return literal ';'  {Ret (Just (Lit $2))}
        | return ';'          {Ret (Nothing)}

CmdSe : if '(' ExprL ')' Bloco            {If $3 $5 []}
      | if '(' ExprL ')' Bloco else Bloco {If $3 $5 $7}

CmdEnquanto : while '(' ExprL ')' Bloco { While $3 $5 }

CmdFor : for '(' AtribSimples ';' ExprL ';' AtribSimples ')' Bloco { For $3 $5 $7 $9 }

CmdAtrib  : id '=' Expr ';'     {Atrib $1 $3}
          | id '=' literal ';'  {Atrib $1 (Lit $3)}

AtribSimples  : id '=' Expr      {Atrib $1 $3}
              | id '=' literal   {Atrib $1 (Lit $3)}
              | Tipo id '=' Expr      {Atrib $2 $4}
              | Tipo id '=' literal   {Atrib $2 (Lit $4)}


CmdEscrita  : print '(' Expr ')' ';'    {Imp $3} 
            | print '(' literal ')' ';' {Imp (Lit $3)}

CmdLeitura : read '(' id ')' ';' {Leitura $3}

ChamadaProc : ChamadaFuncao ';' {
                                  case $1 of
                                    Chamada id args -> Proc id args
                                    _               -> error("Chamada de funcao incorreta")
                                }

ChamadaFuncao : id '(' ListaParametros ')'  { Chamada $1 $3}
              | id '(' ')'                  { Chamada $1 []}

ListaParametros : ListaParametros ',' Expr    {$1 ++ [$3]}
                | ListaParametros ',' literal {$1 ++ [Lit $3]}
                | Expr                        {[$1]}
                | literal                     {[Lit $1]}
{
parseError :: [Token] -> a
parseError s = error ("Parse error:" ++ show s)

funcaoDeFundef :: FuncaoDefinicao -> Funcao
funcaoDeFundef (FunDef f c) = f

defDeFundef :: FuncaoDefinicao -> (Id, [Var], Bloco)
defDeFundef (FunDef (i:->:(v,t)) (BlocoPrinc d c)) = (i,v++d,c)

main = do putStr "Qual arquivo voce quer ler? "
          arquivo <- getLine
          s <- readFile arquivo
          print (calc (L.alexScanTokens s))
}