module RI where

type Id = String

data Tipo   = TDouble
            | TInt
            | TString
            | TVoid
            deriving (Show, Eq)

data TCons  = CDouble Double
            | CInt Int
            deriving Show

data Expr   = Add Expr Expr 
            | Sub Expr Expr
            | Mul Expr Expr
            | Div Expr Expr
            | Neg Expr
            | Const TCons
            | IdVar String
            | Chamada Id [Expr]
            | Lit String
            | IntDouble Expr
            | DoubleInt Expr
            deriving Show

data ExprR = Req Expr Expr
            | Rdif Expr Expr
            | Rlt Expr Expr
            | Rgt Expr Expr
            | Rle Expr Expr
            | Rge Expr Expr
            deriving Show

data ExprL = And ExprL ExprL
            | Or ExprL ExprL
            | Not ExprL
            | Rel ExprR
            deriving Show

data Var    = Id :#: (Tipo, Int)
            deriving Show

data Funcao = Id :->: ([Var], Tipo)
            deriving Show

data Programa   = Prog [Funcao] [(Id, [Var], Bloco)] [Var] Bloco
                deriving Show

type Bloco = [Comando]

data Comando = If ExprL Bloco Bloco
              | While ExprL Bloco
              | Atrib Id Expr
              | Leitura Id
              | Imp Expr
              | Ret (Maybe Expr)
              | Proc Id [Expr]
              deriving Show

-- outros tipos auxiliares

-- Bloco principal, com declarações de variáveis

data BlocoComDeclaracoes    = BlocoPrinc [Var] Bloco
                            deriving Show

-- funções com seus blocos

data FuncaoDefinicao    = FunDef Funcao BlocoComDeclaracoes
                        deriving Show