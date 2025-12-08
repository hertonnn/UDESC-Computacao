module Main where

import SintaxeAbstrata
import Lexico
import Analisador
import Semantico
import Gerador_de_codigo

import Control.Monad (unless, when)
import System.Process (system)
import System.FilePath ((</>))
import System.IO (hFlush, stdout)

-- CONFIGURAÇÃO

jasminDir :: FilePath
jasminDir = "jasmin-2.4"

outputFileName :: String
outputFileName = "output.j"

classePrincipal :: String
classePrincipal = "Teste"

-- LÓGICA DE ALOCAÇÃO DE ÍNDICES (JVM)
-- Retorna quantos slots um tipo ocupa na JVM (Sem assinatura explicita para evitar erro)
getSlots TDouble = 2
getSlots TFloat  = 1 -- Float ocupa 1 slot
getSlots _       = 1 -- Outros tipos ocupam 1 slot

atribuirIndicesVariaveis :: Int -> [Var] -> [Var]
atribuirIndicesVariaveis _ [] = []
atribuirIndicesVariaveis n ((id :#: (tipo, _)):resto) =
  let slots = getSlots tipo
      varIndexada = id :#: (tipo, n)
  in varIndexada : atribuirIndicesVariaveis (n + slots) resto

indexarVariaveisFuncao :: (Id, [Var], Bloco) -> (Id, [Var], Bloco)
indexarVariaveisFuncao (nome, vars, bloco) =
  let vars' = atribuirIndicesVariaveis 0 vars
  in (nome, vars', bloco)

-- PIPELINE DE COMPILAÇÃO

runCompiler :: FilePath -> IO ()
runCompiler arquivo = do
    conteudo <- readFile arquivo
    
    putStrLn $ "Compilando: " ++ arquivo ++ "..."
    
    -- 1. Análise Léxica e Sintática
    let tokens = Lexico.alexScanTokens conteudo
    let ast = Analisador.calc tokens
    
    -- 2. Análise Semântica
    let Result (houveErro, mensagens, progVerificado) = Semantico.tProg ast
    
    putStrLn mensagens 
    
    if houveErro
        then putStrLn "[ERRO] Erro Semantico: Nao foi possivel gerar codigo intermediario."
        else do
            putStrLn "[OK] Analise Semantica OK!"
            
            -- 3. Preparação para Geração de Código (Indexação)
            let (Prog funcoes definicoes variaveis bloco) = progVerificado
            let variaveisIndexadas = atribuirIndicesVariaveis 0 variaveis
            let definicoesIndexadas = map indexarVariaveisFuncao definicoes
            let progFinal = Prog funcoes definicoesIndexadas variaveisIndexadas bloco
            
            -- Debug: Salvar AST processada
            writeFile (jasminDir </> "output_abstract") (show progFinal)
            
            -- 4. Geração de Código Jasmin
            let codigoJasmin = gerar classePrincipal progFinal
            let caminhoOutput = jasminDir </> outputFileName
            writeFile caminhoOutput codigoJasmin
            putStrLn $ "Arquivo gerado: " ++ caminhoOutput
            
            -- 5. Montagem (Assembler) e Execução
            executarJasmin caminhoOutput

executarJasmin :: FilePath -> IO ()
executarJasmin caminhoJ = do
    let jasminJar = jasminDir </> "jasmin.jar"
    -- ADICIONADO: "-d " ++ jasminDir
    -- Isso força o .class a ser salvo dentro da pasta jasmin-2.4
    let cmdMontagem = "java -jar " ++ jasminJar ++ " -d " ++ jasminDir ++ " " ++ caminhoJ
    
    putStrLn $ "\n[JVM] Montando: " ++ cmdMontagem
    _ <- system cmdMontagem
    
    putStrLn $ "\n[JVM] Executando " ++ classePrincipal ++ "..."
    putStrLn "---------------------------------------------------"
    -- Agora sim o arquivo estará lá dentro
    _ <- system $ "java -cp " ++ jasminDir ++ " " ++ classePrincipal
    putStrLn "\n---------------------------------------------------"

-- MAIN

main :: IO ()
main = do
    putStr "Nome do arquivo fonte: "
    hFlush stdout 
    arquivo <- getLine
    runCompiler arquivo