module SintaxeAbstrata where

type Id = String

-- ============================================================================
-- Tipos de Dados Primitivos
-- ============================================================================

data Tipo
  = TDouble
  | TInt
  | TFloat   
  | TString
  | TVoid
  deriving (Show, Eq, Ord)

data TCons
  = CDouble Double
  | CInt    Int
  | CFloat  Float  -- <--- NOVO
  deriving (Show, Eq)

-- ============================================================================
-- Expressões
-- ============================================================================

data Expr
  -- Operações Aritméticas Binárias
  = Add Expr Expr
  | Sub Expr Expr
  | Mul Expr Expr
  | Div Expr Expr
  | Pow Expr Expr       -- Potenciação
  | Mod Expr Expr 
  -- Operações Unárias e Matemáticas
  | Neg Expr
  | Sqr Expr            -- Raiz Quadrada
  
  -- Valores e Identificadores
  | Const TCons
  | IdVar String
  | Lit   String        -- Literais de String
  | IntFloat   Expr -- Converte Int -> Float
  | FloatDouble Expr -- Converte Float -> Double
  | FloatInt    Expr -- Converte Float -> Int
  | DoubleFloat Expr -- Converte Double -> Float
  -- Chamadas e Conversões de Tipo (Casts)
  | Chamada   Id [Expr]
  | IntDouble Expr
  | DoubleInt Expr
  deriving (Show, Eq)

data ExprR
  = Req  Expr Expr      -- Igual (==)
  | Rdif Expr Expr      -- Diferente (!=)
  | Rlt  Expr Expr      -- Menor que (<)
  | Rgt  Expr Expr      -- Maior que (>)
  | Rle  Expr Expr      -- Menor ou igual (<=)
  | Rge  Expr Expr      -- Maior ou igual (>=)
  deriving (Show, Eq)

data ExprL
  = And ExprL ExprL
  | Or  ExprL ExprL
  | Not ExprL
  | Rel ExprR
  deriving (Show, Eq)

-- ============================================================================
-- Estruturas do Programa
-- ============================================================================

-- Variável: Identificador com Tipo e Índice (para geração de código)
data Var 
  = Id :#: (Tipo, Int)
  deriving (Show, Eq)

-- Função: Identificador mapeando para Parâmetros e Tipo de Retorno
data Funcao 
  = Id :->: ([Var], Tipo)
  deriving (Show, Eq)

-- Programa Completo
data Programa 
  = Prog [Funcao] [(Id, [Var], Bloco)] [Var] Bloco
  deriving (Show, Eq)

-- ============================================================================
-- Comandos e Blocos
-- ============================================================================

type Bloco = [Comando]

data Comando
  -- Controle de Fluxo Condicional
  = If ExprL Bloco Bloco

  -- Laços de Repetição
  | While   ExprL Bloco
  | DoWhile Bloco ExprL
  | For     Comando ExprL Comando Bloco

  -- Manipulação de Estado e Variáveis
  | Atrib   Id Expr
  | Incr    Id          -- Incremento (i++)
  | Decr    Id          -- Decremento (i--)
  | Leitura Id

  -- Saída e Chamadas
  | Imp     Expr
  | Proc    Id [Expr]   -- Chamada de procedimento (função void ou ignorando retorno)
  | Ret     (Maybe Expr)
  deriving (Show, Eq)

-- ============================================================================
-- Tipos Auxiliares para o Parser
-- ============================================================================

-- Representa um bloco com declarações locais (usado na análise sintática)
data BlocoComDeclaracoes 
  = BlocoP [Var] Bloco
  deriving (Show, Eq)

-- Representa a definição completa de uma função (Assinatura + Corpo)
data FuncaoDefinicao 
  = FuncaoDefinicao Funcao BlocoComDeclaracoes
  deriving (Show, Eq)