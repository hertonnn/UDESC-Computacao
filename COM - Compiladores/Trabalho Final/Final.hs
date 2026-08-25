module Final where
import RI
import Control.Monad.State
import Lex
import Parser
import Semantico
import Intermediario
import System.Process (system)
import System.FilePath ((</>))

main = do
  putStr "Qual arquivo voce quer ler? "
  arquivo <- getLine
  s <- readFile arquivo
  let parsed = Parser.calc (Lex.alexScanTokens s)
  let Result (houveErro, mensagens, progVerificado) = Semantico.tProg parsed
  putStrLn mensagens
  if houveErro
    then putStrLn "Houve erro(s) semantico(s). Nao e possível gerar codigo intermediario"
    else do
      putStrLn "Analise semantica ok!\n"
      let Prog funcoes definicoes variaveis bloco = progVerificado
      let variaveisIndexadas = atribuirIndicesVariaveis 0 variaveis
      let definicoesIndexadas = map indexarVariaveisFuncao definicoes
      let progComIndices = Prog funcoes definicoesIndexadas variaveisIndexadas bloco
      print progComIndices

atribuirIndicesVariaveis :: Int -> [Var] -> [Var]
atribuirIndicesVariaveis _ [] = []
atribuirIndicesVariaveis n ((id :#: (TInt, _)):resto) =
  (id :#: (TInt, n)) : atribuirIndicesVariaveis (n + 1) resto
atribuirIndicesVariaveis n ((id :#: (TDouble, _)):resto) =
  (id :#: (TDouble, n)) : atribuirIndicesVariaveis (n + 2) resto
atribuirIndicesVariaveis n ((id :#: (TString, _)):resto) =
  (id :#: (TString, n)) : atribuirIndicesVariaveis (n + 1) resto
-- Caso para erro
atribuirIndicesVariaveis n ((id :#: (t, _)):resto) =
  error $ "atribuirIndicesVariaveis: tipo não suportado para variável " ++ id ++ ": " ++ show t

indexarVariaveisFuncao :: (Id, [Var], Bloco) -> (Id, [Var], Bloco)
indexarVariaveisFuncao (nome, vars, bloco) =
  let vars' = atribuirIndicesVariaveis 0 vars
  in (nome, vars', bloco)

jasminize = do
  putStr "Qual arquivo voce quer ler? "
  arquivo <- getLine
  s <- readFile arquivo
  let parsed = Parser.calc (Lex.alexScanTokens s)
  let Result (houveErro, mensagens, progVerificado) = Semantico.tProg parsed
  putStrLn mensagens
  if houveErro
    then putStrLn "Houve erro(s) semantico(s). Nao e possível gerar codigo intermediario"
    else do
      putStrLn "Analise semantica ok!\n"
      let Prog funcoes definicoes variaveis bloco = progVerificado
      let variaveisIndexadas = atribuirIndicesVariaveis 0 variaveis
      let definicoesIndexadas = map indexarVariaveisFuncao definicoes
      let progComIndices = Prog funcoes definicoesIndexadas variaveisIndexadas bloco
      writeFile ("jasmin-2.4" </> "output_abstract") (show progComIndices)
      let codigoIntermediario = gerar "Teste" progComIndices
      writeFile ("jasmin-2.4" </> "output.j") codigoIntermediario
      let pastaJasmin = "jasmin-2.4"
      let caminhoJ = pastaJasmin </> "output.j"
      let jasminJar = pastaJasmin </> "jasmin.jar"
      let comando = "java -jar " ++ jasminJar ++ " " ++ caminhoJ
      putStrLn $ "Executando: " ++ comando
      _ <- system comando
      _ <- system "java Teste"
      return ()
