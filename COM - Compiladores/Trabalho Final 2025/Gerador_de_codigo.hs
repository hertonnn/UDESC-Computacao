module Gerador_de_codigo where

import SintaxeAbstrata
import Control.Monad.State

-------------------------------------------------------------------------------
-- Gerenciamento de Estado e Labels
-------------------------------------------------------------------------------

novoLabel :: State Int String 
novoLabel = do 
    n <- get
    put (n + 1)
    return ("l" ++ show n)

-------------------------------------------------------------------------------
-- Geração de Cabeçalhos (Boilerplate JVM)
-------------------------------------------------------------------------------

genCab :: String -> State Int String
genCab nome = return $
    ".class public " ++ nome ++ "\n" ++
    ".super java/lang/Object\n\n" ++
    ".method public <init>()V\n" ++
    "\taload_0\n" ++
    "\tinvokenonvirtual java/lang/Object/<init>()V\n" ++
    "\treturn\n" ++
    ".end method\n\n"

genMainCab :: Int -> Int -> State Int String
genMainCab s l = return $
    ".method public static main([Ljava/lang/String;)V\n" ++
    "\t.limit stack " ++ show s ++ "\n" ++
    "\t.limit locals " ++ show l ++ "\n\n"

-------------------------------------------------------------------------------
-- Geração de Expressões
-------------------------------------------------------------------------------

genCmd :: [Funcao] -> [Var] -> Comando -> State Int String

-- Constantes
genExpr fun tab (Const (CFloat f)) = return (TFloat, "\tldc " ++ show f ++ "\n")
genExpr fun tab (Const (CInt i))    = return (TInt, genInt i)
genExpr fun tab (Const (CDouble d)) = return (TDouble, genDouble d)

-- Adicionando o resto da divisão (funciona só para inteiros)
genExpr fun tab (Mod e1 e2) = do
  (t1, e1') <- genExpr fun tab e1
  (t2, e2') <- genExpr fun tab e2
  return (TInt, e1' ++ e2' ++ "\tirem\n")

-- Variáveis
genExpr fun tab (IdVar v) = case lookupVar v tab of
    Just (TInt, n)    -> return (TInt,    "\tiload " ++ show n ++ "\n")
    Just (TFloat, n)  -> return (TFloat, "\tfload " ++ show n ++ "\n")
    Just (TDouble, n) -> return (TDouble, "\tdload " ++ show n ++ "\n")
    Just (TString, n) -> return (TString, "\taload " ++ show n ++ "\n")
    _                 -> error ("Variável não encontrada ou tipo inválido: " ++ v)



-- Operações Aritméticas Básicas
genExpr fun tab (Add e1 e2) = do
    (t1, e1') <- genExpr fun tab e1
    (t2, e2') <- genExpr fun tab e2
    return (t1, e1' ++ e2' ++ genOp t1 "add")

genExpr fun tab (Sub e1 e2) = do
    (t1, e1') <- genExpr fun tab e1
    (t2, e2') <- genExpr fun tab e2
    return (t1, e1' ++ e2' ++ genOp t1 "sub")

genExpr fun tab (Mul e1 e2) = do
    (t1, e1') <- genExpr fun tab e1
    (t2, e2') <- genExpr fun tab e2
    return (t1, e1' ++ e2' ++ genOp t1 "mul")

genExpr fun tab (Div e1 e2) = do
    (t1, e1') <- genExpr fun tab e1
    (t2, e2') <- genExpr fun tab e2
    return (t1, e1' ++ e2' ++ genOp t1 "div")

genExpr fun tab (Neg e) = do
    (t, e') <- genExpr fun tab e
    return (t, e' ++ genNeg t)

-- Literais e Conversões
genExpr fun tab (Lit s) =
    return (TString, "\tldc \"" ++ s ++ "\"\n")

genExpr fun tab (IntDouble e) = do
    (t, e') <- genExpr fun tab e
    return (TDouble, e' ++ "\ti2d\n")

genExpr fun tab (DoubleInt e) = do
    (t, e') <- genExpr fun tab e
    return (TInt, e' ++ "\td2i\n")

-- Chamada de Função
genExpr fun tab (Chamada id args) = do
    argsCode <- mapM (genExpr fun tab) args
    
    let tiposArgs = map fst argsCode
        codeArgs  = concatMap snd argsCode
        signature = [(n, (as, t)) | (n :->: (as, t)) <- fun]

    case lookup id signature of
        Just (_, tipoRet) -> return (tipoRet,
            codeArgs ++ 
            "\tinvokestatic Teste/" ++ id ++ "(" ++ concatMap tipoJVM tiposArgs ++ ")" ++ tipoJVM tipoRet ++ "\n")
        Nothing -> error $ "Função não declarada: " ++ id

-- Operações Matemáticas Avançadas (Raiz Quadrada e Potência)
genExpr fun tab (Sqr expr) = do
    (t1, code1) <- genExpr fun tab expr

    -- Converte para Double se for Int antes de chamar Math.pow
    let codeExpr = code1 ++ (if t1 == TInt then "\ti2d\n" else "")

    return (TDouble, 
            codeExpr ++
            "\tldc2_w 0.5\n" ++                   -- Empilha 0.5 (expoente 1/2)
            "\tinvokestatic java/lang/Math/pow(DD)D\n")


-- Casts (Conversões JVM)
genExpr fun tab (IntFloat e) = do
    (_, e') <- genExpr fun tab e
    return (TFloat, e' ++ "\ti2f\n") -- int to float

genExpr fun tab (FloatDouble e) = do
    (_, e') <- genExpr fun tab e
    return (TDouble, e' ++ "\tf2d\n") -- float to double

genExpr fun tab (FloatInt e) = do
    (t, e') <- genExpr fun tab e
    -- f2i: Converte o float no topo da pilha para int (trunca)
    return (TInt, e' ++ "\tf2i\n")
    
genExpr fun tab (DoubleFloat e) = do
    (_, e') <- genExpr fun tab e
    return (TFloat, e' ++ "\td2f\n")

genExpr fun tab (Pow e1 e2) = do
    (t1, code1) <- genExpr fun tab e1
    (t2, code2) <- genExpr fun tab e2

    -- Garante que base e expoente sejam Double na pilha
    let codeBase = code1 ++ (if t1 == TInt then "\ti2d\n" else "")
    let codeExpo = code2 ++ (if t2 == TInt then "\ti2d\n" else "")

    return (TDouble, 
            codeBase ++ 
            codeExpo ++ 
            "\tinvokestatic java/lang/Math/pow(DD)D\n")

-------------------------------------------------------------------------------
-- Auxiliares de Tipagem JVM
-------------------------------------------------------------------------------

tipoJVM :: Tipo -> String
tipoJVM TFloat  = "F" -- Descriptor JVM para float
tipoJVM TInt    = "I"
tipoJVM TDouble = "D"
tipoJVM TString = "Ljava/lang/String;"
tipoJVM TVoid   = "V"

-------------------------------------------------------------------------------
-- Geradores de Constantes e Operadores Básicos
-------------------------------------------------------------------------------

genInt :: Int -> String
genInt i
  | i == -1             = "\ticonst_m1\n"
  | i >= 0 && i <= 5      = "\ticonst_" ++ show i ++ "\n"
  | i >= -128 && i <= 127 = "\tbipush " ++ show i ++ "\n"
  | otherwise         = "\tldc " ++ show i ++ "\n"

genDouble :: Double -> String
genDouble d = "\tldc2_w " ++ show d ++ "\n"

genOp :: Tipo -> String -> String
genOp TInt op = "\ti" ++ op ++ "\n"
genOp TDouble op = "\td" ++ op ++ "\n"
genOp TFloat op  = "\tf" ++ op ++ "\n" -- gera fadd, fsub, etc.
genOp _ _ = error "Operação inválida para tipo"

genNeg :: Tipo -> String
genNeg TInt = "\tineg\n"
genNeg TDouble = "\tdneg\n"
genNeg TFloat = "\tfneg\n"
genNeg _ = error "Negação inválida para tipo"

-------------------------------------------------------------------------------
-- Auxiliares de Variáveis
-------------------------------------------------------------------------------

lookupVar :: String -> [Var] -> Maybe (Tipo, Int)
lookupVar _ [] = Nothing
lookupVar v ((v' :#: info):xs)
  | v == v'   = Just info
  | otherwise = lookupVar v xs


-------------------------------------------------------------------------------
-- Expressões Relacionais (Saltos Condicionais)
-------------------------------------------------------------------------------

-- Gera instruções de comparação (ex: if_icmpeq, dcmpg).
-- v = label verdadeiro (não usado diretamente aqui, dependendo da lógica invertida), 
-- f = label falso (para onde pular se a condição falhar, ou vice-versa dependendo da implementação)

genExprR fun tab v f (Req e1 e2) = do {
  (t1, e1') <- genExpr fun tab e1;
  (t2,e2') <- genExpr fun tab e2;
  return (e1'++e2'++genRel t1 v "eq"++"\tgoto "++f++"\n")
}
genExprR fun tab v f (Rdif e1 e2) = do {
  (t1, e1') <- genExpr fun tab e1;
  (t2,e2') <- genExpr fun tab e2;
  return (e1'++e2'++genRel t1 v "ne"++"\tgoto "++f++"\n")
}
genExprR fun tab v f (Rlt e1 e2) = do {
  (t1, e1') <- genExpr fun tab e1;
  (t2,e2') <- genExpr fun tab e2;
  return (e1'++e2'++genRel t1 v "lt"++"\tgoto "++f++"\n")
}
genExprR fun tab v f (Rgt e1 e2) = do {
  (t1, e1') <- genExpr fun tab e1;
  (t2,e2') <- genExpr fun tab e2;
  return (e1'++e2'++genRel t1 v "gt"++"\tgoto "++f++"\n")
}
genExprR fun tab v f (Rle e1 e2) = do {
  (t1, e1') <- genExpr fun tab e1;
  (t2,e2') <- genExpr fun tab e2;
  return (e1'++e2'++genRel t1 v "le"++"\tgoto "++f++"\n")
}
genExprR fun tab v f (Rge e1 e2) = do {
  (t1, e1') <- genExpr fun tab e1;
  (t2,e2') <- genExpr fun tab e2;
  return (e1'++e2'++genRel t1 v "ge"++"\tgoto "++f++"\n")
}

genRel TInt v op = "\tif_icmp" ++ op ++ " " ++ v ++ "\n"
genRel TDouble v op = "\tdcmpg\n\tif" ++ op ++ " " ++ v ++ "\n"
genRel TFloat v op = "\tfcmpg\n\tif" ++ op ++ " " ++ v ++ "\n"

-------------------------------------------------------------------------------
-- Expressões Lógicas 
-------------------------------------------------------------------------------

genExprL fun tab v f (And e1 e2) = do {
  l1 <- novoLabel;
  e1' <- genExprL fun tab l1 f e1;
  e2' <- genExprL fun tab v f e2;
  return (e1'++l1++":\n"++e2')
}
genExprL fun tab v f (Or e1 e2) = do {
  l1 <- novoLabel;
  e1' <- genExprL fun tab v l1 e1;
  e2' <- genExprL fun tab v f e2;
  return (e1'++l1++":\n"++e2')
}
genExprL fun tab v f (Not e) = do {
  e' <- genExprL fun tab f v e;
  return (e')
}
genExprL fun tab v f (Rel e) = do {
  e' <- genExprR fun tab v f e;
  return (e')
}

-------------------------------------------------------------------------------
-- Geração do Programa Principal
-------------------------------------------------------------------------------

gerar :: String -> Programa -> String
gerar nome prog =
  let (codigo, _) = runState (genProg nome prog) 0
  in codigo


genProg :: String -> Programa -> State Int String
genProg nome (Prog funs corpos vars cmds) = do
  cab <- genCab nome
  funs' <- mapM (genFunComCorpo funs corpos) funs
  
  -- AQUI ESTÁ A CORREÇÃO (para a função 'main'):
  let nvarsMain = calcTamanhoLocals vars -- Calcula o limite real para main
  mainCab <- genMainCab 20 nvarsMain -- Usa o nvarsMain correto
  
  corpoMain <- genBloco funs vars cmds
  let mainFun = mainCab ++ corpoMain ++ "\treturn\n.end method\n"
  return $ cab ++ concat funs' ++ mainFun


calcTamanhoLocals :: [Var] -> Int
calcTamanhoLocals [] = 0
calcTamanhoLocals vars = maximum (map varTamanho vars)
  where
    varTamanho (_ :#: (TInt, n))    = n + 1
    varTamanho (_ :#: (TString, n)) = n + 1 -- Adicionado para TString
    varTamanho (_ :#: (TDouble, n)) = n + 2
    varTamanho (_ :#: (TVoid, n))   = n -- Não deve acontecer, mas cobre o caso
    varTamanho (_ :#: (TFloat, n))  = n + 1
-------------------------------------------------------------------------------
-- Geração de Comandos (Statements)
-------------------------------------------------------------------------------

genBloco :: [Funcao] -> [Var] -> [Comando] -> State Int String
genBloco _ _ [] = return ""
genBloco fun tab (cmd:cmds) = do
  c1 <- genCmd fun tab cmd
  c2 <- genBloco fun tab cmds
  return (c1 ++ c2)

-- Atribuição 
genCmd fun tab (Atrib v e) = do
  (t, e') <- genExpr fun tab e
  case lookupVar v tab of
    Just (TInt, n)    -> return (e' ++ "\tistore " ++ show n ++ "\n")
    Just (TFloat, n)  -> return (e' ++ "\tfstore " ++ show n ++ "\n")
    Just (TDouble, n) -> return (e' ++ "\tdstore " ++ show n ++ "\n")
    Just (TString, n) -> return (e' ++ "\tastore " ++ show n ++ "\n")
    _                 -> error ("Variável não encontrada ou tipo inválido: " ++ v)

-- Condicional (If-Else)
-- If <cond> then <cmdsThen> else <cmdsElse>
-- Se a condição for válida, pula para um bloco que executa cmdsThen.
-- Em qualquer situação vai para o fim
genCmd fun tab (If cond cmdsThen cmdsElse) = do
  lIf <- novoLabel
  lElse <- novoLabel
  lEnd <- novoLabel
  cond' <- genExprL fun tab lIf lElse cond
  cmdsThen' <- genBloco fun tab cmdsThen
  cmdsElse' <- genBloco fun tab cmdsElse
  return (cond' ++ lIf ++ ":\n" ++ cmdsThen' ++ "\tgoto " ++ lEnd ++ "\n" ++ lElse ++ ":\n" ++ cmdsElse' ++ lEnd ++ ":\n")


-- Laço Do-While
genCmd fun tab (DoWhile bloco cond) = do
    lInicio <- novoLabel
    lFim    <- novoLabel

    -- Implementa o bloco PRIMEIRO
    bloco'   <- genBloco fun tab bloco

    -- Testa a condição
    cond'   <- genExprL fun tab lInicio lFim cond

    return $
      lInicio ++ ":\n" ++
      bloco' ++
      cond' ++
      lFim ++ ":\n" 

-- Laço While
genCmd fun tab (While cond bloco) = do
  lInicio <- novoLabel
  lTrue   <- novoLabel
  lFim    <- novoLabel
  cond'   <- genExprL fun tab lTrue lFim cond
  bloco'   <- genBloco fun tab bloco
  return $
    lInicio ++ ":\n" ++
    cond' ++
    lTrue ++ ":\n" ++
    bloco' ++
    "\tgoto " ++ lInicio ++ "\n" ++
    lFim ++ ":\n"



-- Incremento (++)
genCmd fun tab (Incr nome) =
  case lookupVar nome tab of
    Just (TInt, n) -> 
      -- iinc index const: Incrementa a variável local 'n' em 1
      return ("\tiinc " ++ show n ++ " 1\n")
    
    Just (TDouble, n) -> 
      -- Para Double: Carrega, carrega 1.0, soma, armazena
      return ("\tdload " ++ show n ++ "\n" ++
              "\tldc2_w 1.0\n" ++
              "\tdadd\n" ++
              "\tdstore " ++ show n ++ "\n")
    
    _ -> error $ "Erro na geracao de codigo para ++ em: " ++ nome




-- Decremento (--)
genCmd fun tab (Decr nome) =
  case lookupVar nome tab of
    Just (TInt, n) -> 
      -- iinc com -1 faz o decremento
      return ("\tiinc " ++ show n ++ " -1\n")
    
    Just (TDouble, n) -> 
      return ("\tdload " ++ show n ++ "\n" ++
              "\tldc2_w 1.0\n" ++
              "\tdsub\n" ++
              "\tdstore " ++ show n ++ "\n")
              
    _ -> error $ "Erro na geracao de codigo para -- em: " ++ nome


-- Laço For
genCmd fun tab (For init cond inc bloco) = do
  -- 1. A Inicialização roda apenas uma vez, antes de tudo.
  init' <- genCmd fun tab init

  -- 2. Criamos etiquetas (labels) para marcar os lugares do código
  lInicio <- novoLabel  -- Onde começa o teste a cada volta
  lTrue   <- novoLabel  -- Onde começa o código se o teste for verdadeiro
  lFim    <- novoLabel  -- Para onde vamos se o teste for falso

  -- 3. Geramos o código da condição
  -- Ele deve pular para lTrue se OK, ou lFim se falhar
  cond'   <- genExprL fun tab lTrue lFim cond

  -- 4. Geramos o corpo do loop
  bloco'  <- genBloco fun tab bloco

  -- 5. Geramos o incremento
  inc'    <- genCmd fun tab inc

  -- 6. MONTANDO O QUEBRA-CABEÇA:
  return $
    init' ++                -- i = 0
    lInicio ++ ":\n" ++     -- MARCA: Começo do loop
    cond' ++                -- if (i >= 10) goto lFim
    lTrue ++ ":\n" ++       -- MARCA: Entrada do bloco
    bloco' ++               -- executa código...
    inc' ++                 -- i = i + 1 (Incremento acontece aqui!)
    "\tgoto " ++ lInicio ++ "\n" ++ -- Volta para testar de novo
    lFim ++ ":\n"           -- MARCA: Saída

-- Leitura de Dados (Scanner)
-- Adaptado de https://stackoverflow.com/a/32154621
genCmd fun tab (Leitura nome) =
  case lookupVar nome tab of
    Just (TInt, n) -> return $
      "\tnew java/util/Scanner\n" ++
      "\tdup\n" ++
      "\tgetstatic java/lang/System/in Ljava/io/InputStream;\n" ++
      "\tinvokespecial java/util/Scanner/<init>(Ljava/io/InputStream;)V\n" ++
      "\tinvokevirtual java/util/Scanner/nextInt()I\n" ++
      "\tistore " ++ show n ++ "\n"

    Just (TFloat, n) -> return $
      "\tnew java/util/Scanner\n" ++
      "\tdup\n" ++
      "\tgetstatic java/lang/System/in Ljava/io/InputStream;\n" ++
      "\tinvokespecial java/util/Scanner/<init>(Ljava/io/InputStream;)V\n" ++
      "\tinvokevirtual java/util/Scanner/nextFloat()F\n" ++ -- Scanner.nextFloat()
      "\tfstore " ++ show n ++ "\n"
    Just (TDouble, n) -> return $
      "\tnew java/util/Scanner\n" ++
      "\tdup\n" ++
      "\tgetstatic java/lang/System/in Ljava/io/InputStream;\n" ++
      "\tinvokespecial java/util/Scanner/<init>(Ljava/io/InputStream;)V\n" ++
      "\tinvokevirtual java/util/Scanner/nextDouble()D\n" ++
      "\tdstore " ++ show n ++ "\n"

    _ -> error $ "Tipo não suportado ou variável não encontrada: " ++ nome

-- Impressão (Print)
-- Adaptado do acima usando o Compiler Explorer
genCmd fun tab (Imp e) = do
  (t, e') <- genExpr fun tab e
  case t of
    TInt -> return $ "\tgetstatic java/lang/System/out Ljava/io/PrintStream;\n" ++ e' ++
                      "\tinvokevirtual java/io/PrintStream/println(I)V\n"
    TFloat -> return $ "\tgetstatic java/lang/System/out Ljava/io/PrintStream;\n" ++ e' ++
                       "\tinvokevirtual java/io/PrintStream/println(F)V\n"
    TDouble -> return $ "\tgetstatic java/lang/System/out Ljava/io/PrintStream;\n" ++ e' ++
                         "\tinvokevirtual java/io/PrintStream/println(D)V\n"
    TString -> return $ "\tgetstatic java/lang/System/out Ljava/io/PrintStream;\n" ++ e' ++
                         "\tinvokevirtual java/io/PrintStream/println(Ljava/lang/String;)V\n"

-- Retorno
genCmd fun tab (Ret (Nothing)) = do
  return "\treturn\n"

genCmd fun tab (Ret (Just e)) = do
  (t, e') <- genExpr fun tab e
  case t of
    TInt -> return $ e' ++ "\tireturn\n"
    TDouble -> return $ e' ++ "\tdreturn\n"
    TString -> return $ e' ++ "\tareturn\n"
    TVoid -> return $ e' ++ "\treturn\n"

-- Chamada de Procedimento (Void)
genCmd fun tab (Proc id args) = do
  argsCode <- mapM (genExpr fun tab) args
  let tiposArgs = map fst argsCode
      codeArgs  = concatMap snd argsCode
  case lookup id [(n, (as, t)) | (n :->: (as, t)) <- fun] of
    Just (_, tipoRet) ->
      return 
        (codeArgs ++ "\tinvokestatic Teste/" ++ id ++ "(" ++ concatMap tipoJVM tiposArgs ++ ")" ++ tipoJVM tipoRet ++ "\n")
    Nothing -> error $ "Processo nao declarado: " ++ id


-------------------------------------------------------------------------------
-- Geração de Funções e Métodos Auxiliares
-------------------------------------------------------------------------------
genFunComCorpo :: [Funcao] -> [(Id, [Var], Bloco)] -> Funcao -> State Int String
genFunComCorpo funs corpos (nome :->: (args, tipo)) =
  case lookup nome (map (\(n, a, b) -> (n, (a, b))) corpos) of
    Just (vars, bloco) -> do
      corpo <- genBloco funs vars bloco
      let tiposArgs = map (\(_ :#: (t, _)) -> t) args
      
      let nvars = calcTamanhoLocals vars -- Calcula o limite real
      cab <- genFunCab tipo nome tiposArgs nvars 20 -- Usa o nvars correto
      
      return $ cab ++ corpo ++ (if tipo == TVoid then "\treturn\n" else "") ++ ".end method\n\n"
    Nothing -> error $ "Função " ++ nome ++ " sem corpo encontrado"
  where
    varTamanho (_ :#: (TInt, n))    = n + 1
    varTamanho (_ :#: (TString, n)) = n + 1 -- Adicionado para TString
    varTamanho (_ :#: (TDouble, n)) = n + 2
    varTamanho (_ :#: (TVoid, n))   = n -- Não deve acontecer, mas cobre o caso

-- Gera o cabeçalho de uma função com tipo de retorno, nome, tamanho da pilha e número de variáveis locais
genFunCab :: Tipo -> String -> [Tipo] -> Int -> Int -> State Int String
genFunCab t nome args nvars stack = return $
  ".method public static " ++ nome ++
  "(" ++ concatMap tipoJVM args ++ ")" ++
  retTipo t ++ "\n" ++
  "\t.limit stack " ++ show stack ++ "\n" ++
  "\t.limit locals " ++ show nvars ++ "\n\n"

-- Converte tipo para representação no Jasmin
retTipo :: Tipo -> String
retTipo TInt    = "I"
retTipo TDouble = "D"
retTipo TString = "Ljava/lang/String;"
retTipo TFloat  = "F"
retTipo TVoid   = "V"