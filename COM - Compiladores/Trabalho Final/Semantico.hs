module Semantico where
import Control.Monad (zipWithM)

import RI

data Result a = Result (Bool, String, a) deriving Show

instance Functor Result where
  fmap f (Result (b, s, a)) = Result (b, s, f a)

instance Applicative Result where
  pure a = Result (False, "", a)
  Result (b1, s1, f) <*> Result (b2, s2, x) = Result (b1 || b2, s1 <> s2, f x)   

instance Monad Result where 
--  return a = Result (False, "", a)
  Result (b, s, a) >>= f = let Result (b', s', a') = f a
                           in Result (b || b', s++s', a')
  
errorMsg s = Result (True, "Erro: "++s++"\n", ())

warningMsg s = Result (False, "Advertencia: "++s++"\n", ())

-- Nossas implementações

-- verifica se uma variável existe e se sim retorna o tipo dela 

buscaVar [] nome = do {
  errorMsg ("Variavel nao declarada: " ++ show nome);
  return (TVoid, IdVar nome)
 }
buscaVar ((nomeVar :#: (tipo,_)) : resto) nome
  | nomeVar == nome = return (tipo, IdVar nome)
  | otherwise = buscaVar resto nome

-- verifica se a função existe e retorna os parâmetros e o tipo de retorno declarada

-- coercaoParametros nomeFuncao tipoRetorno params targs
coercaoParametros nomeFuncao tipoRetorno [] [] = []

buscaFuncao [] nome targs = do {
  errorMsg ("Funcao nao declarada: " ++ show nome);
  return (TVoid, Chamada nome (map (snd) targs))
 }
buscaFuncao ((nomeFunc :->: (params, tipoRetorno)) : resto) nome targs
  | nomeFunc == nome = if (length targs == length params)
                       then (
                        return (tipoRetorno, Chamada nome (map snd targs))
                       )
                       else (
                        do {
                          errorMsg ("Funcao " ++ show nome ++ " requer " ++ show (length params) ++ " parametro(s), " ++
                          "mas " ++ show (length targs) ++ " foi(ram) passado(s)." ++ "\n");
                          return (tipoRetorno, Chamada nome (map snd targs))
                        }
                       )
  | otherwise = buscaFuncao resto nome targs

-- verifica duplicatas de variáveis em um escopo
-- verificaVarsDuplicadas ["a" :#: (TDouble,0),"b" :#: (TDouble,0), "b" :#: (TDouble,0)]

verificaVarsDuplicadas vars = verifica vars []
  where
    verifica [] _ = return ()
    verifica ((nome :#: _) : resto) nomesDeclarados
      | nome `elem` nomesDeclarados = errorMsg ("Variavel ja declarada: " ++ show nome) >>= \_ -> return ()
      | otherwise = verifica resto (nome : nomesDeclarados)

-- verifica duplicatas de funções

verificaFuncsDuplicadas funcsList = verifica funcsList []
  where
    verifica [] _ = return ()
    verifica ((nomeFunc :->: (_,_)) : resto) nomesDeclarados
      | nomeFunc `elem` nomesDeclarados = errorMsg ("Funcao ja declarada: " ++ show nomeFunc) >>= \_ -> return ()
      | otherwise = verifica resto (nomeFunc : nomesDeclarados)

{-
-- verifica se a atribuiçao de uma variavel dá match com o tipo declarado
-- até agora só funciona com atribuições diretas (a = 0, b = 'a', etc.)

tipoExpr _ (Const (CInt _)) = return TInt
tipoExpr _ (Const (CDouble _)) = return TDouble
tipoExpr _ (Lit _) = return TString

verificaAtrib vars (Atrib id expr) = do
  tipoVar <- buscaVar vars id
  tipoExprRes <- tipoExpr vars expr
  if (tipoVar == tipoExprRes) ||
     (tipoVar == TDouble && tipoExprRes == TInt) ||
     (tipoVar == TInt && tipoExprRes == TDouble)
    then return ()
    else errorMsg ("Tipo incompatível na atribuição para variável " ++ show id ++
                   ". Esperado: " ++ show tipoVar ++ ", encontrado: " ++ show tipoExprRes) >>= \_ -> return ()
verificaAtrib _ _ = return ()
-}

coercaoExpr op e1 e2 t1 t2
  | (t1 /= TInt && t1 /= TDouble) = do {
      errorMsg ("Erro de tipos na expressao: " ++ show (op e1 e2) ++ ", " ++
                  show e1 ++ " eh do tipo " ++ show t1 ++ " \n");
      return (t2, op e1 e2)
    }
  | (t2 /= TInt && t2 /= TDouble) = do {
      errorMsg ("Erro de tipos na expressao: " ++ show (op e1 e2) ++ ", " ++
                  show e2 ++ " eh do tipo " ++ show t2 ++ " \n");
      return (t1, op e1 e2)
    }
  | t1 == t2                    = return (t1, op e1 e2)
  | t1 == TInt && t2 == TDouble = return (t2, op (IntDouble e1) e2)
  | t1 == TDouble && t2 == TInt = return (t1, op e1 (IntDouble e2))
  | otherwise                   = do
      errorMsg ("Erro de tipos na expressao: " ++ show (op e1 e2) ++ ", " ++
                  show e1 ++ " eh do tipo " ++ show t1 ++ " e " ++ show e2 ++
                  " eh do tipo " ++ show t2 ++" \n");
      return (t1, op e1 e2)

tExpr tfun tvar (Const (CInt c)) = return (TInt, Const (CInt c))
tExpr tfun tvar (Const (CDouble c)) = return (TDouble, Const (CDouble c))
tExpr tfun tvar (Lit s) = return (TString, Lit s)
tExpr tfun tvar (Add e1 e2) = do {
    (t1, e1') <- tExpr tfun tvar e1;
    (t2, e2') <- tExpr tfun tvar e2;
    coercaoExpr Add e1' e2' t1 t2
    }
tExpr tfun tvar (Sub e1 e2) = do {
    (t1, e1') <- tExpr tfun tvar e1;
    (t2, e2') <- tExpr tfun tvar e2;
    coercaoExpr Sub e1' e2' t1 t2
    }
tExpr tfun tvar (Mul e1 e2) = do {
    (t1, e1') <- tExpr tfun tvar e1;
    (t2, e2') <- tExpr tfun tvar e2;
    coercaoExpr Mul e1' e2' t1 t2
    }
tExpr tfun tvar (Div e1 e2) = do {
    (t1, e1') <- tExpr tfun tvar e1;
    (t2, e2') <- tExpr tfun tvar e2;
    coercaoExpr Div e1' e2' t1 t2
    }

tExpr tfun tvar (Neg e) = do {
    (t, e') <- tExpr tfun tvar e;
    if (t /= TInt && t/= TDouble) then (
        do {
          errorMsg ("Erro de tipos na expressao: " ++ show (Neg e) ++ ", " ++
                  show e ++ " eh do tipo " ++ show t ++ " \n");
          return (t, Neg e')
        }
      ) else (
        return (t, Neg e')
      )
    }

tExpr tfun tvar (IdVar nome) = buscaVar tvar nome

tExpr tfun tvar (Chamada nome args) = do
  -- Analisa cada argumento
  argsTipados <- mapM (tExpr tfun tvar) args
  let (tiposArgs, args') = unzip argsTipados

  -- Procura a função na tabela
  case lookup nome [(f, (params, ret)) | f :->: (params, ret) <- tfun] of
    Nothing -> do
      errorMsg ("Funcao nao declarada: " ++ nome)
      return (TVoid, Chamada nome args')  -- usamos args' já analisados
    Just (params, tipoRet) ->
      let tiposParams = [t | _ :#: (t, _) <- params]
      in
        if length tiposArgs /= length tiposParams
        then do
          errorMsg ("Numero de argumentos incorreto na chamada da funcao " ++ nome ++
                    ": esperados " ++ show (length tiposParams) ++
                    ", recebidos " ++ show (length tiposArgs))
          return (tipoRet, Chamada nome args')  -- coerções ignoradas
        else do
          -- Tenta fazer coerção um a um
          coeridos <- coerirLista (zip3 tiposArgs tiposParams args')
          return (tipoRet, Chamada nome coeridos)

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

tBloco contexto tfun tvar b = mapM (tComando contexto tfun tvar) b

tComando contexto tfun tvar (Atrib nome e) = do {
  (texpr,e') <- tExpr tfun tvar e;
  case lookup nome [(i, tv) | i :#: (tv, _) <- tvar] of
    Nothing -> do
      errorMsg ("Variavel nao declarada: " ++ show nome);
      return (Atrib nome e')
    Just tv -> case (tv, texpr) of
      (TInt, TInt) -> return (Atrib nome e')
      (TDouble, TDouble) -> return (Atrib nome e')
      (TString, TString) -> return (Atrib nome e')
      (TDouble, TInt) -> return (Atrib nome (IntDouble e'))
      (TInt, TDouble) -> do {
        warningMsg ("Conversao de Double para Int: " ++ show (Atrib nome e'));
        return (Atrib nome (DoubleInt e'))
      }
      _ -> do {
        errorMsg ("Erro de tipos na expressao: " ++ show (Atrib nome e') ++ ", " ++
                  show nome ++ " eh do tipo " ++ show tv ++ " e " ++ show e' ++
                  " eh do tipo " ++ show texpr ++" \n");
        return (Atrib nome e')
      }
}

tComando contexto tfun tvar (Ret Nothing)
  | contexto == TVoid = return (Ret Nothing)
  | otherwise         = do
                          errorMsg ("Tipo de retorno esperado: " ++ show contexto ++ ", mas nenhum valor foi retornado.");
                          return (Ret Nothing)

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

tComando contexto tfun tvar (If cond cmdsThen cmdsElse) = do
  cond' <- tExprL tfun tvar cond
  cmdsThen' <- tBloco contexto tfun tvar cmdsThen
  cmdsElse' <- tBloco contexto tfun tvar  cmdsElse
  return (If cond' cmdsThen' cmdsElse')

tComando contexto tfun tvar (While cond comandos) = do
  cond' <- tExprL tfun tvar cond
  comandos' <- tBloco contexto tfun tvar comandos
  return (While cond' comandos')

tComando contexto tfun tvar (For init cond incr comandos) = do
  init' <- tComando contexto tfun tvar init
  cond' <- tExprL tfun tvar cond
  incr' <- tComando contexto tfun tvar incr
  comandos'    <- tBloco contexto tfun tvar comandos
  return (For init' cond' incr' comandos')


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


tProg (Prog declaracoesFuncoes definicoesFuncoes variaveisPrincipais blocoPrincipal) = do {
  tfun <- tFuncao [] declaracoesFuncoes;
  definicoesFuncoes' <- mapM (tDefinicaoFuncao tfun) definicoesFuncoes;
  tvar <- tVariavel [] variaveisPrincipais;
  blocoPrincipal' <- tBloco TVoid tfun tvar blocoPrincipal; -- Pela descrição do trabalho, acho que deve ser isso aqui.....
  return (Prog tfun definicoesFuncoes' tvar blocoPrincipal') ;
}

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
-- Cole isto no final do seu Semantico.hs para testar
progTesteFor = Prog
  [ "somaFor" :->: (["n" :#: (TInt,0)], TInt) ]
  [ ("somaFor"
    , ["i" :#: (TInt,0), "s" :#: (TInt,0), "n" :#: (TInt,0)]
    , [ Atrib "s" (Const (CInt 0))
      , For (Atrib "i" (Const (CInt 0)))                 -- 1. Comando (init)
            (Rel (Rlt (IdVar "i") (IdVar "n")))         -- 2. ExprL (cond)
            (Atrib "i" (Add (IdVar "i") (Const (CInt 1)))) -- 3. Comando (inc)
            [ Atrib "s" (Add (IdVar "s") (IdVar "i")) ] -- 4. Bloco (body)
      , Ret (Just (IdVar "s"))
      ]
    )
  ]
  [ "resultado" :#: (TInt,0), "num" :#: (TInt,0) ]
  [ Imp (Lit "Digite um numero:")
  , Leitura "num"
  , Atrib "resultado" (Chamada "somaFor" [IdVar "num"])
  , Imp (Lit "Resultado:")
  , Imp (IdVar "resultado")
  , Ret (Just (Const (CInt 0)))
  ]