module Semantico where

import SintaxeAbstrata
import Control.Monad (zipWithM, foldM)
import Data.List (find) -- Evitar recursão manual

-- ============================================================================
-- 1. Mônada de Resultado (Result Monad)
-- ============================================================================

-- (Erro?, Log de Mensagens, Valor)
data Result a = Result (Bool, String, a) deriving Show

instance Functor Result where
  fmap f (Result (err, log, a)) = Result (err, log, f a)

instance Applicative Result where
  pure a = Result (False, "", a)
  Result (e1, l1, f) <*> Result (e2, l2, x) = Result (e1 || e2, l1 ++ l2, f x)

instance Monad Result where
  return = pure
  Result (e1, l1, a) >>= f = 
    let Result (e2, l2, b) = f a
    in Result (e1 || e2, l1 ++ l2, b)

-- ============================================================================
-- 2. Helpers de Mensagens e Erros
-- ============================================================================

-- Apenas registra o erro (retorna unit)
errorMsg :: String -> Result ()
errorMsg s = Result (True, "Error: " ++ s ++ "\n", ())

-- Apenas registra aviso (retorna unit)
warningMsg :: String -> Result ()
warningMsg s = Result (False, "Warning: " ++ s ++ "\n", ())

-- Registra erro e retorna um valor padrão (útil para recuperação de falhas)
retornarErro :: String -> a -> Result a
retornarErro msg valorPadrao = do
  errorMsg msg
  return valorPadrao

-- ============================================================================
-- 3. Buscas em Tabela de Símbolos (Lookup)
-- ============================================================================

-- Busca variável na lista. Se não achar, retorna erro e assume TVoid.
buscaVar :: [Var] -> Id -> Result (Tipo, Expr)
buscaVar vars nome = 
  case find (\(n :#: _) -> n == nome) vars of
    Just (_ :#: (tipo, _)) -> return (tipo, IdVar nome)
    Nothing -> retornarErro ("Variavel nao declarada: " ++ show nome) (TVoid, IdVar nome)

-- Busca função. Verifica existência e aridade (número de parâmetros).
buscaFuncao :: [Funcao] -> Id -> [(Tipo, Expr)] -> Result (Tipo, Expr)
buscaFuncao funcs nome argsTipados = 
  case find (\(n :->: _) -> n == nome) funcs of
    Nothing -> 
      retornarErro ("Funcao nao declarada: " ++ show nome) (TVoid, Chamada nome args)
    
    Just (_ :->: (params, tipoRetorno)) -> do
      let nEsperado = length params
      let nRecebido = length args
      
      if nEsperado == nRecebido
        then return (tipoRetorno, Chamada nome args)
        else retornarErro 
               ("Funcao " ++ show nome ++ " requer " ++ show nEsperado ++ 
                " parametro(s), mas " ++ show nRecebido ++ " foi(ram) passado(s).")
               (tipoRetorno, Chamada nome args)
  where 
    args = map snd argsTipados

-- ============================================================================
-- 4. Verificações de Escopo
-- ============================================================================

-- Função Genérica para verificar duplicatas em qualquer lista
-- Recebe:
--   getName: uma função que sabe extrair o nome do item (Id)
--   label: o nome do tipo de coisa sendo verificada (para msg de erro)
--   items: a lista de itens
verificaDuplicatas :: (a -> Id) -> String -> [a] -> Result ()
verificaDuplicatas getName label items = go [] items
  where
    go _ [] = return ()
    go vistos (x:xs) = do
      let nome = getName x
      if nome `elem` vistos
        then errorMsg (label ++ " ja declarada: " ++ show nome)
        else return ()
      go (nome:vistos) xs

-- Wrapper específico para Variáveis
verificaVarsDuplicadas :: [Var] -> Result ()
verificaVarsDuplicadas = verificaDuplicatas (\(n :#: _) -> n) "Variavel"

-- Wrapper específico para Funções
verificaFuncsDuplicadas :: [Funcao] -> Result ()
verificaFuncsDuplicadas = verificaDuplicatas (\(n :->: _) -> n) "Funcao"

-- ============================================================================
-- 5. Coerção e Análise de Expressões (tExpr)
-- ============================================================================

-- 5.1. Lógica de Coerção Aritmética (Int vs Double)
-- ----------------------------------------------------------------------------

-- Verifica os tipos de uma operação binária e insere conversões se necessário
coercaoBinaria :: (Expr -> Expr -> Expr) -> Expr -> Expr -> Tipo -> Tipo -> Result (Tipo, Expr)
coercaoBinaria op e1 e2 t1 t2 = case (t1, t2) of
  (TInt, TInt)       -> return (TInt, op e1 e2)
  (TFloat, TFloat)   -> return (TFloat, op e1 e2)
  (TDouble, TDouble) -> return (TDouble, op e1 e2)
  
  -- Int vs Float (Promove Int para Float)
  (TInt, TFloat)     -> return (TFloat, op (IntFloat e1) e2)
  (TFloat, TInt)     -> return (TFloat, op e1 (IntFloat e2))
  
  -- Int vs Double (Promove Int para Double)
  (TInt, TDouble)    -> return (TDouble, op (IntDouble e1) e2)
  (TDouble, TInt)    -> return (TDouble, op e1 (IntDouble e2))

  -- Float vs Double (Promove Float para Double)
  (TFloat, TDouble)  -> return (TDouble, op (FloatDouble e1) e2)
  (TDouble, TFloat)  -> return (TDouble, op e1 (FloatDouble e2))
  
  _ -> retornarErro ("Tipos incompativeis: " ++ show t1 ++ " e " ++ show t2) (TDouble, op e1 e2)

-- Verifica os tipos de uma atribuição ou passagem de parâmetro
-- Tenta converter o valor 'expr' (tipoExpr) para o 'tipoEsperado'
coerirValor :: Tipo -> Tipo -> Expr -> Result Expr
coerirValor tipoEsperado tipoExpr expr
  | tipoEsperado == tipoExpr = return expr
  -- Conversões Seguras (Promoção)
  | tipoEsperado == TFloat  && tipoExpr == TInt   = return (IntFloat expr)
  | tipoEsperado == TDouble && tipoExpr == TInt   = return (IntDouble expr)
  | tipoEsperado == TDouble && tipoExpr == TFloat = return (FloatDouble expr)
  
  -- Conversões com Perda (Truncamento) - Gere Warning
  | tipoEsperado == TInt    && tipoExpr == TFloat = do
      warningMsg ("Truncamento: Float para Int em " ++ show expr)
      return (FloatInt expr)
  | tipoEsperado == TFloat  && tipoExpr == TDouble = do
      warningMsg ("Perda de precisao: Double para Float em " ++ show expr)
      return (DoubleFloat expr)
  -- ... (mantenha as lógicas existentes de Double/Int)
  | otherwise = do
      errorMsg ("Tipo incompativel...")
      return expr

-- Aplica coerção numa lista de argumentos (para chamadas de função)
coerirArgs :: [(Tipo, Tipo, Expr)] -> Result [Expr]
coerirArgs [] = return []
coerirArgs ((tEsperado, tReal, exp):resto) = do
  e' <- coerirValor tEsperado tReal exp
  resto' <- coerirArgs resto
  return (e' : resto')

-- 5.2. Analisador Principal de Expressões
-- ----------------------------------------------------------------------------

tExpr :: [Funcao] -> [Var] -> Expr -> Result (Tipo, Expr)

-- Valores Literais
tExpr _ _ (Const (CInt c))    = return (TInt, Const (CInt c))
tExpr _ _ (Const (CDouble c)) = return (TDouble, Const (CDouble c))
tExpr _ _ (Lit s)             = return (TString, Lit s)
tExpr _ _ (Const (CFloat c))  = return (TFloat, Const (CFloat c))

-- Variáveis (Usa o helper refatorado anteriormente)
tExpr _ vars (IdVar nome)     = buscaVar vars nome

-- Operações Aritméticas Básicas (Reutiliza a lógica de coercaoBinaria)
tExpr env vars (Add e1 e2) = analisarOpBinaria env vars Add e1 e2
tExpr env vars (Sub e1 e2) = analisarOpBinaria env vars Sub e1 e2
tExpr env vars (Mul e1 e2) = analisarOpBinaria env vars Mul e1 e2
tExpr env vars (Div e1 e2) = analisarOpBinaria env vars Div e1 e2


tExpr env vars (IntFloat e)   = tExpr env vars e >>= \(_, e') -> return (TFloat, IntFloat e')
tExpr env vars (FloatDouble e)= tExpr env vars e >>= \(_, e') -> return (TDouble, FloatDouble e')
-- Operação Unária (Neg)
tExpr env vars (Neg e) = do
  (t, e') <- tExpr env vars e
  if t `elem` [TInt, TDouble]
    then return (t, Neg e')
    else retornarErro ("Negacao requer numero, recebeu: " ++ show t) (t, Neg e')

-- Potenciação (Pow): Sempre retorna Double
tExpr env vars (Pow e1 e2) = do
  (t1, e1') <- tExpr env vars e1
  (t2, e2') <- tExpr env vars e2
  
  if t1 `elem` [TInt, TDouble] && t2 `elem` [TInt, TDouble]
    then do
      -- Converte operandos para Double se forem Int
      let base = if t1 == TInt then IntDouble e1' else e1'
      let expo = if t2 == TInt then IntDouble e2' else e2'
      return (TDouble, Pow base expo)
    else retornarErro "Potencia requer base e expoente numericos." (TDouble, Pow e1' e2')


-- Adicionando Resto da divisão
tExpr tfun tvar (Mod e1 e2) = do {
    (t1, e1') <- tExpr tfun tvar e1;
    (t2, e2') <- tExpr tfun tvar e2;

    -- Verifica se são inteiros
    if (t1 == TInt && t2 == TInt) 
    then return (TInt, Mod e1' e2')
    else do {
      errorMsg "Operacao de Modulo (%) requer dois inteiros.";
      return (TInt, Mod e1' e2')
    }
}
-- Raiz Quadrada (Sqr): Sempre retorna Double
tExpr env vars (Sqr e) = do
  (t, e') <- tExpr env vars e
  if t `elem` [TInt, TDouble]
    then do
      let val = if t == TInt then IntDouble e' else e'
      return (TDouble, Sqr val)
    else retornarErro "Raiz quadrada requer numero." (TDouble, Sqr e')

-- Chamada de Função
tExpr env vars (Chamada nome args) = do
  -- 1. Analisa os argumentos passados
  argsResult <- mapM (tExpr env vars) args
  let (tiposPassados, argsExprs) = unzip argsResult

  -- 2. Busca a assinatura da função (usando 'find' para evitar list comprehension repetitiva)
  case Data.List.find (\(n :->: _) -> n == nome) env of
    Nothing -> 
      retornarErro ("Funcao nao declarada: " ++ nome) (TVoid, Chamada nome argsExprs)
    
    Just (_ :->: (paramsDeclarados, tipoRetorno)) -> do
      let tiposEsperados = map (\(_ :#: (t, _)) -> t) paramsDeclarados
      
      -- 3. Verifica Aridade
      if length tiposPassados /= length tiposEsperados
        then retornarErro 
              ("Funcao " ++ nome ++ " espera " ++ show (length tiposEsperados) ++ " argumentos.") 
              (tipoRetorno, Chamada nome argsExprs)
        else do
          -- 4. Coerção dos Argumentos (ex: passar Int onde se espera Double)
          argsFinais <- coerirArgs (zip3 tiposEsperados tiposPassados argsExprs)
          return (tipoRetorno, Chamada nome argsFinais)

-- Coerções de Tipo Explícitas (geradas pelo próprio semântico ou parser)
tExpr env vars (IntDouble e) = tExpr env vars e >>= \(t, e') -> return (TDouble, IntDouble e')
tExpr env vars (DoubleInt e) = tExpr env vars e >>= \(t, e') -> return (TInt, DoubleInt e')

-- Helper para reduzir boilerplate das operações binárias (+, -, *, /)
analisarOpBinaria :: [Funcao] -> [Var] -> (Expr -> Expr -> Expr) -> Expr -> Expr -> Result (Tipo, Expr)
analisarOpBinaria env vars op e1 e2 = do
  (t1, e1') <- tExpr env vars e1
  (t2, e2') <- tExpr env vars e2
  coercaoBinaria op e1' e2' t1 t2

-- ============================================================================
-- 6. Coerção e Análise de Expressões Relacionais (tExprR)
-- ============================================================================
  
-- Aplica coerirArg para cada argumento e tipo esperado
coerirLista :: [(Tipo, Tipo, Expr)] -> Result [Expr]
coerirLista [] = return []
coerirLista ((tipoArg, tipoParam, arg):xs) = do
  coerido <- coerirArg tipoArg tipoParam arg
  resto <- coerirLista xs
  return (coerido : resto)

coerirArg :: Tipo -> Tipo -> Expr -> Result Expr
coerirArg tipoArg tipoParam arg
  | tipoArg == tipoParam = return arg
  | tipoArg == TInt && tipoParam == TDouble = return (IntDouble arg)
  | tipoArg == TDouble && tipoParam == TInt = do
      warningMsg ("Conversao de Double para Int: " ++ show arg)
      return (DoubleInt arg)
  | otherwise = do
      errorMsg ("Tipo do argumento " ++ show arg ++ " (" ++ show tipoArg ++
                ") nao compativel com tipo do parametro (" ++ show tipoParam ++ ")")
      return arg

coercaoExprR op e1 e2 t1 t2
  | (t1==TInt && t2==TInt) = return (op e1 e2)
  | (t1==TDouble && t2==TDouble) = return (op e1 e2)
  | (t1==TString && t2==TString) = return (op e1 e2)
  | (t1==TInt && t2==TDouble) = return (op (IntDouble e1) e2)
  | (t1==TDouble && t2==TInt) = return (op e1 (IntDouble e2))
  | otherwise = do {
      errorMsg ("Tipos incompativeis na expressao relacional: " ++
                show (op e1 e2) ++ ", " ++ show t1 ++ " e " ++ show t2);
      return (op e1 e2)
    }

tExprR tfun tvar (Req e1 e2) = do {
  (t1, e1') <- tExpr tfun tvar e1;
  (t2, e2') <- tExpr tfun tvar e2;
  coercaoExprR Req e1' e2' t1 t2
}
tExprR tfun tvar (Rdif e1 e2) = do {
  (t1, e1') <- tExpr tfun tvar e1;
  (t2, e2') <- tExpr tfun tvar e2;
  coercaoExprR Rdif e1' e2' t1 t2
}
tExprR tfun tvar (Rlt e1 e2) = do {
  (t1, e1') <- tExpr tfun tvar e1;
  (t2, e2') <- tExpr tfun tvar e2;
  coercaoExprR Rlt e1' e2' t1 t2
}
tExprR tfun tvar (Rgt e1 e2) = do {
  (t1, e1') <- tExpr tfun tvar e1;
  (t2, e2') <- tExpr tfun tvar e2;
  coercaoExprR Rgt e1' e2' t1 t2
}
tExprR tfun tvar (Rle e1 e2) = do {
  (t1, e1') <- tExpr tfun tvar e1;
  (t2, e2') <- tExpr tfun tvar e2;
  coercaoExprR Rle e1' e2' t1 t2
}
tExprR tfun tvar (Rge e1 e2) = do {
  (t1, e1') <- tExpr tfun tvar e1;
  (t2, e2') <- tExpr tfun tvar e2;
  coercaoExprR Rge e1' e2' t1 t2
}

-- ============================================================================
-- 7. Análise de Expressões Lógicas (tExprL)
-- ============================================================================

tExprL tfun tvar (Rel e) = do {
  e' <- tExprR tfun tvar e;
  return (Rel e');
}
tExprL tfun tvar (Not e) = do {
  e' <- tExprL tfun tvar e;
  return (Not e');
}
tExprL tfun tvar (And e1 e2) = do {
  e1' <- tExprL tfun tvar e1;
  e2' <- tExprL tfun tvar e2;
  return (And e1' e2');
}
tExprL tfun tvar (Or e1 e2) = do {
  e1' <- tExprL tfun tvar e1;
  e2' <- tExprL tfun tvar e2;
  return (Or e1' e2');
}

-- ============================================================================
-- 8. Análise de Comandos e Blocos (tComando)
-- ============================================================================

-- Analisa uma lista de comandos sequencialmente
tBloco contexto tfun tvar b = mapM (tComando contexto tfun tvar) b

-- 8.1. Atribuição
-- ----------------------------------------------------------------------------
tComando contexto tfun tvar (Atrib nome e) = do {
  (texpr,e') <- tExpr tfun tvar e;
  case lookup nome [(i, tv) | i :#: (tv, _) <- tvar] of
    Nothing -> do
      errorMsg ("Variavel nao declarada: " ++ show nome);
      return (Atrib nome e')
    Just tv -> case (tv, texpr) of
      (TInt, TInt) -> return (Atrib nome e')
      (TDouble, TDouble) -> return (Atrib nome e')
      (TFloat, TFloat) -> return (Atrib nome e')
      (TString, TString) -> return (Atrib nome e')

      -- Conversões de Promoção (Int -> Float/Double)
      (TDouble, TInt)    -> return (Atrib nome (IntDouble e'))
      (TFloat, TInt)     -> return (Atrib nome (IntFloat e'))  -- Int sobe para Float
      (TDouble, TFloat)  -> return (Atrib nome (FloatDouble e')) -- Float sobe para Double
      
      -- Conversões de Truncamento (Float/Double -> Int) << AQUI ESTAVA FALTANDO
      (TInt, TDouble) -> do {
        warningMsg ("Conversao de Double para Int (truncamento): " ++ show (Atrib nome e'));
        return (Atrib nome (DoubleInt e'))
      }
      (TInt, TFloat) -> do {    -- <--- ADICIONE ESTE BLOCO
        warningMsg ("Conversao de Float para Int (truncamento): " ++ show (Atrib nome e'));
        return (Atrib nome (FloatInt e')) 
      }
      (TFloat, TDouble) -> do {
         warningMsg ("Atencao: Conversao implicita de Double para Float (perda de precisao) em: " ++ show (Atrib nome e'));
         return (Atrib nome (DoubleFloat e'))
      }
      _ -> do {
        errorMsg ("Erro de tipos na expressao: " ++ show (Atrib nome e') ++ ", " ++
                  show nome ++ " eh do tipo " ++ show tv ++ " e " ++ show e' ++
                  " eh do tipo " ++ show texpr ++" \n");
        return (Atrib nome e')
      }
}

-- 8.2. Incremento e Decremento (i++, i--)
-- ----------------------------------------------------------------------------
tComando contexto tfun tvar (Incr nome) = do
  case lookup nome [(i, tv) | i :#: (tv, _) <- tvar] of
    Nothing -> do
      errorMsg ("Variavel nao declarada: " ++ show nome)
      return (Incr nome)
    Just tv -> if tv == TInt || tv == TDouble
               then return (Incr nome)
               else do
                 errorMsg ("Operador ++ so pode ser aplicado a Int ou Double. Variavel " ++ show nome ++ " eh " ++ show tv)
                 return (Incr nome)

tComando contexto tfun tvar (Decr nome) = do
  case lookup nome [(i, tv) | i :#: (tv, _) <- tvar] of
    Nothing -> do
      errorMsg ("Variavel nao declarada: " ++ show nome)
      return (Decr nome)
    Just tv -> if tv == TInt || tv == TDouble
               then return (Decr nome)
               else do
                 errorMsg ("Operador -- so pode ser aplicado a Int ou Double. Variavel " ++ show nome ++ " eh " ++ show tv)
                 return (Decr nome)        
-- 8.3. Retorno
-- ----------------------------------------------------------------------------
-- Retorno Vazio (return;)
tComando contexto tfun tvar (Ret Nothing)
  | contexto == TVoid = return (Ret Nothing)
  | otherwise         = do
                          errorMsg ("Tipo de retorno esperado: " ++ show contexto ++ ", mas nenhum valor foi retornado.");
                          return (Ret Nothing)
-- Retorno com Valor (return expr;)
tComando contexto tfun tvar (Ret (Just e)) = do
  (texpr, e') <- tExpr tfun tvar e
  case (contexto, texpr) of
    (TInt, TInt) -> return (Ret (Just e'))
    (TDouble, TDouble) -> return (Ret (Just e'))
    (TString, TString) -> return (Ret (Just e'))
    (TDouble, TInt) -> return (Ret (Just (IntDouble e')))
    (TInt, TDouble) -> do
      warningMsg ("Conversao de Double para Int na funcao de retorno: " ++ show e');
      return (Ret (Just (DoubleInt e')))
    _ -> do
      errorMsg ("Tipo de retorno incompativel: " ++ show e' ++ ", tipo esperado: " ++ show contexto ++
                ", tipo encontrado: " ++ show texpr);
      return (Ret (Just e'))

-- 8.4. Controle de Fluxo 
-- ----------------------------------------------------------------------------
tComando contexto tfun tvar (If cond cmdsThen cmdsElse) = do
  cond' <- tExprL tfun tvar cond
  cmdsThen' <- tBloco contexto tfun tvar cmdsThen
  cmdsElse' <- tBloco contexto tfun tvar  cmdsElse
  return (If cond' cmdsThen' cmdsElse')

tComando contexto tfun tvar (While cond comandos) = do
  cond' <- tExprL tfun tvar cond
  comandos' <- tBloco contexto tfun tvar comandos
  return (While cond' comandos')

tComando contexto tfun tvar (DoWhile bloco cond) = do
  cond' <- tExprL tfun tvar cond
  bloco' <- tBloco contexto tfun tvar bloco
  return (DoWhile bloco' cond')

tComando contexto tfun tvar (For init cond incr bloco) = do
  init' <- tComando contexto tfun tvar init
  cond' <- tExprL tfun tvar cond
  incr' <-  tComando contexto tfun tvar incr
  bloco' <- tBloco contexto tfun tvar bloco
  return (For init' cond' incr' bloco')

-- 8.5. I/O e Outros
-- ----------------------------------------------------------------------------
tComando contexto tfun tvar (Imp e) = do
  (_, e') <- tExpr tfun tvar e
  return (Imp e')

tComando contexto tfun tvar (Leitura nome) = do {
  case lookup nome [(i, tv) | i :#: (tv, _) <- tvar] of
    Nothing -> do
      errorMsg ("Variavel nao declarada: " ++ show nome);
      return (Leitura nome)
    Just tv -> return (Leitura nome)
}

-- Chamada de Procedimento (Função void ou ignorando retorno)
tComando contexto tfun tvar (Proc nome args) = do
  -- Analisa cada argumento
  argsTipados <- mapM (tExpr tfun tvar) args
  let (tiposArgs, args') = unzip argsTipados

  -- Procura a função na tabela
  case lookup nome [(f, (params, ret)) | f :->: (params, ret) <- tfun] of
    Nothing -> do
      errorMsg ("Funcao nao declarada: " ++ nome)
      return (Proc nome args')  -- usamos args' já analisados
    Just (params, tipoRet) ->
      let tiposParams = [t | _ :#: (t, _) <- params]
      in
        if length tiposArgs /= length tiposParams
        then do
          errorMsg ("Numero de argumentos incorreto na chamada da funcao " ++ nome ++
                    ": esperados " ++ show (length tiposParams) ++
                    ", recebidos " ++ show (length tiposArgs))
          return (Proc nome args')  -- coerções ignoradas
        else do
          -- Tenta fazer coerção um a um
          coeridos <- coerirLista (zip3 tiposArgs tiposParams args')
          return (Proc nome coeridos)

-- ============================================================================
-- 9. Análise de Declarações e Programa Principal
-- ============================================================================
tFuncao tfun [] = return tfun

tFuncao tfun ((nome:->:assinatura): resto) = do
  resto' <- tFuncao tfun resto
  case elem nome [n | (n:->:_) <- resto'] of
    True -> do {
      errorMsg("Funcao " ++ (show nome) ++ " duplamente declarada.");
      return resto'
    }
    False -> do {
      return ((nome:->:assinatura):resto');
    }

tVariavel tvar [] = return tvar
tVariavel tvar ((nome:#:tp):resto) = do
  resto' <- tVariavel tvar resto
  case elem nome [n | (n:#:_) <- resto'] of
    True -> do {
      errorMsg("Variavel " ++ (show nome) ++ " duplamente declarada.");
      return resto'
    }
    False -> do {
      return ((nome:#:tp):resto');
    }

tDefinicaoFuncao tfun (nome,vars,bloco) = do
  vars'<- tVariavel [] vars
  let contexto = case lookup nome [(f, (params, ret)) | f :->: (params, ret) <- tfun] of
                  Just (_, ret) -> ret
                  Nothing -> TVoid  -- se não encontrar, assume TVoid
  bloco' <- tBloco contexto tfun vars' bloco
  return (nome, vars', bloco')

-- ============================================================================
-- 10. Ponto de Entrada (tProg)
-- ============================================================================

tProg (Prog declaracoesFuncoes definicoesFuncoes variaveisPrincipais blocoPrincipal) = do {
  tfun <- tFuncao [] declaracoesFuncoes;
  definicoesFuncoes' <- mapM (tDefinicaoFuncao tfun) definicoesFuncoes;
  tvar <- tVariavel [] variaveisPrincipais;
  blocoPrincipal' <- tBloco TVoid tfun tvar blocoPrincipal; 
  return (Prog tfun definicoesFuncoes' tvar blocoPrincipal') ;
}

-- ============================================================================
-- 11. Testes 
-- ============================================================================

teste1 = tBloco TInt [] [] [If (Rel (Rgt (IdVar "a") (IdVar "b"))) [Atrib "m" (IdVar "a")] [Atrib "m" (IdVar "b")],Ret (Just (IdVar "m"))]

teste2 = tBloco TInt [] ["a":#:(TDouble,0), "b":#:(TInt,0), "m":#:(TInt,0)] [If (Rel (Rgt (IdVar "a") (IdVar "b"))) [Atrib "m" (IdVar "a")] [Atrib "m" (IdVar "b")],Ret (Just (IdVar "m"))]



teste3 = tFuncao [] [
                      "maior" :->: (["a" :#: (TDouble,0), "b" :#: (TDouble,0)], TDouble),
                      "fat" :->: (["n" :#: (TInt,0)], TInt), 
                      "somatorio" :->: (["n" :#: (TInt,0)], TInt),
                      "imprimir" :->: (["s" :#: (TString,0), "r" :#: (TDouble,0)], TVoid)
                    ]

teste4 = tFuncao [] [
                      "maior" :->: (["a" :#: (TDouble,0), "b" :#: (TDouble,0)], TDouble),
                      "fat" :->: (["n" :#: (TInt,0)], TInt), 
                      "somatorio" :->: (["n" :#: (TInt,0)], TInt),
                      "imprimir" :->: (["s" :#: (TString,0), "r" :#: (TDouble,0)], TVoid),
                      "maior" :->: (["a" :#: (TDouble,0), "b" :#: (TDouble,0)], TDouble)
                    ]

progTesteFor = Prog
  -- Declarações de Funções
  [ "somaFor" :->: (["n" :#: (TInt,0)], TInt) ]

  -- Definições de Funções
  [ ("somaFor"
    , ["i" :#: (TInt,0), "s" :#: (TInt,0), "n" :#: (TInt,0)] -- Vars locais
    , [ Atrib "s" (Const (CInt 0))                         -- s = 0
      , For (Atrib "i" (Const (CInt 0)))                   -- 1. Init: i = 0
            (Rel (Rlt (IdVar "i") (IdVar "n")))            -- 2. Cond: i < n
            (Atrib "i" (Add (IdVar "i") (Const (CInt 1)))) -- 3. Incr: i = i + 1
            [ Atrib "s" (Add (IdVar "s") (IdVar "i")) ]    -- 4. Bloco: s = s + i
      , Ret (Just (IdVar "s"))                             -- return s
      ]
    )
  ]

  -- Variáveis Globais
  [ "resultado" :#: (TInt,0), "num" :#: (TInt,0) ]

  -- Bloco Principal
  [ Imp (Lit "Digite um numero:")
  , Leitura "num"
  , Atrib "resultado" (Chamada "somaFor" [IdVar "num"])
  , Imp (Lit "Resultado:")
  , Imp (IdVar "resultado")
  , Ret (Just (Const (CInt 0))) -- (Assumindo que o principal pode ter um Ret)
  ]
progTeste1 = Prog
  [ "maior" :->: (["a" :#: (TDouble,0), "b" :#: (TDouble,0)], TDouble)
  , "fat" :->: (["n" :#: (TInt,0)], TInt)
  , "somatorio" :->: (["n" :#: (TInt,0)], TInt)
  , "imprimir" :->: (["s" :#: (TInt,0), "s2" :#: (TString,0), "r" :#: (TDouble,0)], TVoid)
  ]
  [ ("maior"
    , ["m" :#: (TInt,0), "a" :#: (TDouble,0), "b" :#: (TDouble,0)]
    , [ If (Rel (Rgt (IdVar "a") (IdVar "b")))
          [ Atrib "m" (IdVar "a") ]
          [ Atrib "m" (IdVar "b") ]
      , Ret (Just (IdVar "m"))
      ]
    )
  , ("fat"
    , ["f" :#: (TInt,0), "n" :#: (TInt,0)]
    , [ Atrib "f" (Const (CInt 0))
      , While (Rel (Rgt (IdVar "n") (Const (CInt 0))))
          [ Atrib "f" (Mul (IdVar "f") (IdVar "n"))
          , Atrib "n" (Sub (IdVar "n") (Const (CInt 1)))
          ]
      , Ret (Just (IdVar "f"))
      ]
    )
  , ("somatorio"
    , ["i" :#: (TInt,0), "s" :#: (TDouble,0), "n" :#: (TInt,0)]
    , [ Atrib "s" (Const (CInt 0))
      , Atrib "i" (Const (CInt 0))
      , While (Rel (Rlt (IdVar "i") (IdVar "n")))
          [ Atrib "s" (Add (IdVar "s") (IdVar "i"))
          , Atrib "i" (Add (IdVar "i") (Const (CInt 1)))
          ]
      , Ret (Just (IdVar "s"))
      ]
    )
  , ("imprimir"
    , ["s" :#: (TInt,0), "s2" :#: (TString,0), "r" :#: (TDouble,0)]
    , [ Imp (IdVar "s")
      , Imp (IdVar "r")
      , Ret (Just (Const (CInt 0)))
      ]
    )
  ]
  [ "x" :#: (TInt,0), "num" :#: (TInt,0), "a" :#: (TDouble,0) ]
  [ Imp (Lit "Numero:")
  , Leitura "num"
  , Atrib "x" (Chamada "fat" [Const (CDouble 4.5)])
  , Atrib "a" (Chamada "maior" [Const (CDouble 2.5), Const (CInt 10)])
  , Proc "imprimir" [Const (CInt 1), Lit "teste:", Const (CInt 2)]
  , Ret (Just (Const (CInt 0)))
  ]

progTeste3 = Prog
  [ "maior" :->:
      ( [ "a" :#: (TDouble, 0)
        , "b" :#: (TDouble, 0)
        ]
      , TDouble
      )
  ]
  [ ( "maior"
    , [ "m" :#: (TInt, 0)
      , "a" :#: (TDouble, 0)
      , "b" :#: (TDouble, 0)
      ]
    , [ If (Rel (Rgt (IdVar "a") (IdVar "b")))
          [ Atrib "m" (IdVar "a") ]
          [ Atrib "m" (IdVar "b") ]
      , Ret (Just (IdVar "m"))
      ]
    )
  ]
  [ "a" :#: (TInt, 0) ]
  [ Atrib "a" (Chamada "maior"
      [ Const (CDouble 2.5)
      , Const (CInt 10)
      ])
  , Ret (Just (Const (CInt 0)))
  ]