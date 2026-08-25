module Intermediario where

import RI
import Control.Monad.State

novoLabel :: State Int String 
novoLabel = do {n <- get; put (n+1); return ("l" ++ show n)}

genCab :: String -> State Int String
genCab nome = return (".class public " ++ nome ++ 
                      "\n.super java/lang/Object\n\n.method public <init>()V\n\taload_0\n\tinvokenonvirtual java/lang/Object/<init>()V\n\treturn\n.end method\n\n")

genMainCab :: Int -> Int -> State Int String
genMainCab s l = return (".method public static main([Ljava/lang/String;)V" ++
                         "\n\t.limit stack " ++ show s ++
                         "\n\t.limit locals " ++ show l ++ "\n\n")

-- Expressões aritméticas 
genCmd :: [Funcao] -> [Var] -> Comando -> State Int String
genExpr fun tab (Const (CInt i)) = return (TInt, genInt i)
genExpr fun tab (Const (CDouble d)) = return (TDouble, genDouble d)
genExpr fun tab (IdVar v) = case lookupVar v tab of
  Just (TInt, n)    -> return (TInt, "\tiload " ++ show n ++ "\n")
  Just (TDouble, n) -> return (TDouble, "\tdload " ++ show n ++ "\n")
  Just (TString, n) -> return (TString, "\taload " ++ show n ++ "\n")
  _                 -> error ("Variável não encontrada ou tipo inválido: " ++ v)
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

genExpr fun tab (Lit s) =
  return (TString, "\tldc \"" ++ s ++ "\"\n")

genExpr fun tab (IntDouble e) = do
  (t, e') <- genExpr fun tab e
  return (TDouble, e' ++ "\ti2d\n")

genExpr fun tab (DoubleInt e) = do
  (t, e') <- genExpr fun tab e
  return (TInt, e' ++ "\td2i\n")

genExpr fun tab (Chamada id args) = do
  argsCode <- mapM (genExpr fun tab) args
  let tiposArgs = map fst argsCode
      codeArgs  = concatMap snd argsCode
  case lookup id [(n, (as, t)) | (n :->: (as, t)) <- fun] of
    Just (_, tipoRet) ->
      return (tipoRet,
        codeArgs ++ "\tinvokestatic Teste/" ++ id ++ "(" ++ concatMap tipoJVM tiposArgs ++ ")" ++ tipoJVM tipoRet ++ "\n")
    Nothing -> error $ "Função não declarada: " ++ id

-- genExpr c tab fun (Chamada id args) = do

tipoJVM :: Tipo -> String
tipoJVM TInt    = "I"
tipoJVM TDouble = "D"
tipoJVM TString = "Ljava/lang/String;"
tipoJVM TVoid   = "V"


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
genOp _ _ = error "Operação inválida para tipo"

genNeg :: Tipo -> String
genNeg TInt = "\tineg\n"
genNeg TDouble = "\tdneg\n"
genNeg _ = error "Negação inválida para tipo"

lookupVar :: String -> [Var] -> Maybe (Tipo, Int)
lookupVar _ [] = Nothing
lookupVar v ((v' :#: info):xs)
  | v == v'   = Just info
  | otherwise = lookupVar v xs

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

---------------------------
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

-- Gera o código de um bloco de comandos
genBloco :: [Funcao] -> [Var] -> [Comando] -> State Int String
genBloco _ _ [] = return ""
genBloco fun tab (cmd:cmds) = do
  c1 <- genCmd fun tab cmd
  c2 <- genBloco fun tab cmds
  return (c1 ++ c2)

genCmd fun tab (Atrib v e) = do
  (t, e') <- genExpr fun tab e
  case lookupVar v tab of
    Just (TInt, n)    -> return (e' ++ "\tistore " ++ show n ++ "\n")
    Just (TDouble, n) -> return (e' ++ "\tdstore " ++ show n ++ "\n")
    Just (TString, n) -> return (e' ++ "\tastore " ++ show n ++ "\n")
    _                 -> error ("Variável não encontrada ou tipo inválido: " ++ v)

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

genCmd fun tab (For init cond inc bloco) = do
  -- 1. Gerar código para 'init'. Roda SÓ UMA VEZ.
  init' <- genCmd fun tab init

  -- 2. Criar os labels.
  lInicio <- novoLabel  -- Label para o TESTE DA CONDIÇÃO
  lTrue   <- novoLabel  -- Label para o CORPO
  lInc    <- novoLabel  -- Label para o INCREMENTO
  lFim    <- novoLabel  -- Label para SAIR do loop

  -- 3. Gerar código da condição (pula para lTrue se VERDADEIRO, lFim se FALSO)
  cond'   <- genExprL fun tab lTrue lFim cond

  -- 4. Gerar o corpo do loop
  bloco'  <- genBloco fun tab bloco

  -- 5. Gerar o código de incremento
  inc'    <- genCmd fun tab inc

  -- 6. Montar tudo na ordem correta
  return $
    init' ++                -- 1. Executa a inicialização
    lInicio ++ ":\n" ++     -- 2. Label do início (teste)
    cond' ++                -- 3. Código da condição (com pulos)
    lTrue ++ ":\n" ++       -- 4. Label do corpo
    bloco' ++               -- 5. Código do corpo
    lInc ++ ":\n" ++        -- 6. Label do incremento
    inc' ++                 -- 7. Código do incremento
    "\tgoto " ++ lInicio ++ "\n" ++ -- 8. Volta para o TESTE (lInicio)
    lFim ++ ":\n"           -- 9. Label de saída


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

    Just (TDouble, n) -> return $
      "\tnew java/util/Scanner\n" ++
      "\tdup\n" ++
      "\tgetstatic java/lang/System/in Ljava/io/InputStream;\n" ++
      "\tinvokespecial java/util/Scanner/<init>(Ljava/io/InputStream;)V\n" ++
      "\tinvokevirtual java/util/Scanner/nextDouble()D\n" ++
      "\tdstore " ++ show n ++ "\n"

    _ -> error $ "Tipo não suportado ou variável não encontrada: " ++ nome

-- Adaptado do acima usando o Compiler Explorer
genCmd fun tab (Imp e) = do
  (t, e') <- genExpr fun tab e
  case t of
    TInt -> return $ "\tgetstatic java/lang/System/out Ljava/io/PrintStream;\n" ++ e' ++
                      "\tinvokevirtual java/io/PrintStream/println(I)V\n"
    TDouble -> return $ "\tgetstatic java/lang/System/out Ljava/io/PrintStream;\n" ++ e' ++
                         "\tinvokevirtual java/io/PrintStream/println(D)V\n"
    TString -> return $ "\tgetstatic java/lang/System/out Ljava/io/PrintStream;\n" ++ e' ++
                         "\tinvokevirtual java/io/PrintStream/println(Ljava/lang/String;)V\n"

genCmd fun tab (Ret (Nothing)) = do
  return "\treturn\n"

genCmd fun tab (Ret (Just e)) = do
  (t, e') <- genExpr fun tab e
  case t of
    TInt -> return $ e' ++ "\tireturn\n"
    TDouble -> return $ e' ++ "\tdreturn\n"
    TString -> return $ e' ++ "\tareturn\n"
    TVoid -> return $ e' ++ "\treturn\n"

genCmd fun tab (Proc id args) = do
  argsCode <- mapM (genExpr fun tab) args
  let tiposArgs = map fst argsCode
      codeArgs  = concatMap snd argsCode
  case lookup id [(n, (as, t)) | (n :->: (as, t)) <- fun] of
    Just (_, tipoRet) ->
      return 
        (codeArgs ++ "\tinvokestatic Teste/" ++ id ++ "(" ++ concatMap tipoJVM tiposArgs ++ ")" ++ tipoJVM tipoRet ++ "\n")
    Nothing -> error $ "Processo nao declarado: " ++ id



genFunComCorpo :: [Funcao] -> [(Id, [Var], Bloco)] -> Funcao -> State Int String
genFunComCorpo funs corpos (nome :->: (args, tipo)) =
  case lookup nome (map (\(n, a, b) -> (n, (a, b))) corpos) of
    Just (vars, bloco) -> do
      corpo <- genBloco funs vars bloco
      let tiposArgs = map (\(_ :#: (t, _)) -> t) args
      
      -- AQUI ESTÁ A CORREÇÃO:
      let nvars = calcTamanhoLocals vars -- Calcula o limite real
      cab <- genFunCab tipo nome tiposArgs nvars 20 -- Usa o nvars correto
      
      return $ cab ++ corpo ++ (if tipo == TVoid then "\treturn\n" else "") ++ ".end method\n\n"
    Nothing -> error $ "Função " ++ nome ++ " sem corpo encontrado"
  where
    -- ... (o resto da função retInstr)

-- Gera o cabeçalho de uma função com tipo de retorno, nome, tamanho da pilha e número de variáveis locais
genFunCab :: Tipo -> String -> [Tipo] -> Int -> Int -> State Int String
genFunCab t nome args nvars stack = return $
  ".method public static " ++ nome ++
  "(" ++ concatMap tipoJVM args ++ ")" ++
  retTipo t ++ "\n" ++
  "\t.limit stack " ++ show stack ++ "\n" ++
  "\t.limit locals " ++ show nvars ++ "\n\n"

-- Converte tipo para sua representação no Jasmin
retTipo :: Tipo -> String
retTipo TInt    = "I"
retTipo TDouble = "D"
retTipo TString = "Ljava/lang/String;"
retTipo TVoid   = "V"