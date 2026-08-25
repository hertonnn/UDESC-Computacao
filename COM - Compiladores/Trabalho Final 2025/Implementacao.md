# --- 🎲 Implementação do Random (Gerador Aleatório)
Este guia cobre todas as etapas: Árvore (RI) → Lexer → Parser → Semântico → Gerador.

Passo 1: Atualizar a Árvore Sintática (RI.hs)
Precisamos criar um nó na árvore para representar essa expressão. Como random() retorna um valor, ele é uma Expr.

Arquivo: RI.hs

Haskell

data Expr = ...
          | Sqr Expr
          | Len Expr
          | Random      -- <--- Adicione isto (Sem argumentos)
          deriving (Show, Eq)
Passo 2: Token e Lexer (Token.hs e Lex.x)
Precisamos ensinar o compilador a reconhecer a palavra reservada random.

Arquivo: Token.hs

Haskell

data Token = ...
           | TRANDOM    -- <--- Adicione o Token
           ...
Arquivo: Lex.x Adicione esta regra antes da regra geral de identificadores:

Haskell

"random"  { \s -> TRANDOM }
Passo 3: O Parser (Parser.y)
Aqui definimos a sintaxe. Vamos adotar o padrão de função sem argumentos: random().

Arquivo: Parser.y

Declare o token no cabeçalho:

Haskell

%token
  random { TRANDOM }
Adicione a regra dentro de Expr:

Haskell

Expr : ...
     | random '(' ')'   { Random }  -- Cria o nó Random na árvore
Passo 4: Análise Semântica (Semantic.hs)
Aqui validamos a operação. Como o Math.random() do Java sempre retorna um número decimal, o tipo de retorno será sempre TDouble.

Arquivo: Semantic.hs Adicione dentro da função tExpr:

Haskell

-- Random
tExpr tfun tvar Random = do
    -- Não há argumentos para analisar, apenas retornamos TDouble
    return (TDouble, Random)
Passo 5: Gerador de Código (Generator.hs)
Aqui fazemos a mágica acontecer chamando a biblioteca padrão do Java.

Arquivo: Generator.hs Adicione dentro da função genExpr:

Haskell

genExpr fun tab Random = 
    -- Chama o método estático da JVM. O 'D' no final indica que retorna Double.
    return (TDouble, "\tinvokestatic java/lang/Math/random()D\n")
📝 Como Testar
Crie um arquivo de teste (ex: testeRandom.txt) e use a lógica matemática para gerar números maiores, já que o random() puro só retorna entre 0.0 e 1.0.

Java

{
    double r;
    double nota;
    int dado;

    // 1. Aleatório simples (0.0 a 1.0)
    r = random();
    print("Aleatorio Puro:");
    print(r);

    // 2. Simulando uma nota de 0 a 10
    nota = random() * 10.0;
    print("Nota Gerada:");
    print(nota);

    // 3. Simulando um dado de 6 lados (Conversão para Int)
    // Lógica: (int) (random() * 6) + 1
    dado = (int) (random() * 6.0) + 1;
    print("Dado (1-6):");
    print(dado);
}
✅ Resultado Esperado na JVM
Ao rodar, ele deve imprimir números diferentes a cada execução (exceto se você rodar muito rápido em sequência, mas a JVM cuida da semente automaticamente).

Aleatorio Puro: algo como 0.732...

Nota Gerada: algo como 7.32...

Dado: um inteiro entre 1 e 6.

# --- 🔡 Comparação de Strings (== e !=)
O Problema
Na JVM:

"oi" == "oi" pode dar Falso se forem objetos diferentes na memória.

A instrução if_acmpeq (comparação de referências) não serve para conteúdo.

A Solução
Traduzir s1 == s2 para s1.equals(s2).

Passo 1: Análise Semântica (Semantic.hs)
Você precisa garantir que o "Policial" (Semantic) permita comparar duas Strings.

Vá na função coercaoExprR (que cuida de Relacionais: ==, !=, >, etc) e certifique-se de que esta linha existe:

Haskell

-- Semantic.hs

coercaoExprR op e1 e2 t1 t2
  -- ... regras de Int e Double ...
  | (t1 == TString && t2 == TString) = return (op e1 e2) -- <--- CONFIRA SE ISSO EXISTE
  -- ...
Passo 2: O Gerador de Código (Generator.hs)
Aqui é onde a mágica acontece. Você precisa interceptar o nó Req (Igual) e Rdif (Diferente) especificamente quando os tipos forem TString.

Adicione estes casos no seu genExpr, antes da regra geral de comparação de inteiros:

A. Igualdade (==)
Mapeamos para s1.equals(s2).

Haskell

-- Generator.hs

genExpr fun tab (Req e1 e2) = do
  (t1, code1) <- genExpr fun tab e1
  (t2, code2) <- genExpr fun tab e2
  
  if t1 == TString && t2 == TString 
    then return (TBool, code1 ++ code2 ++ "\tinvokevirtual java/lang/String/equals(Ljava/lang/Object;)Z\n")
    else do 
       -- ... aqui fica sua lógica antiga para Int/Double (if_icmpeq, dcmpl, etc) ...
       -- Se você usa uma função genérica para relacionais, mantenha ela no 'else'
B. Diferença (!=)
Mapeamos para !s1.equals(s2). O método .equals retorna 0 (falso) ou 1 (verdadeiro). Para inverter (fazer o !=), usamos um XOR com 1.

1 XOR 1 = 0 (Verdadeiro virou Falso)

0 XOR 1 = 1 (Falso virou Verdadeiro)

Haskell

-- Generator.hs

genExpr fun tab (Rdif e1 e2) = do
  (t1, code1) <- genExpr fun tab e1
  (t2, code2) <- genExpr fun tab e2
  
  if t1 == TString && t2 == TString 
    then return (TBool, code1 ++ code2 ++ 
                        "\tinvokevirtual java/lang/String/equals(Ljava/lang/Object;)Z\n" ++ 
                        "\ticonst_1\n" ++  -- Carrega 1
                        "\tixor\n")        -- Inverte o resultado (NOT)
    else do 
       -- ... sua lógica antiga para Int/Double ...
📝 Como Testar
Crie um teste que falharia se usasse comparação de memória, mas passa com comparação de conteúdo.

Java

{
    string s1 = "ola";
    string s2 = "ola";
    string s3 = "mundo";
    
    // Teste 1: Conteúdos iguais
    if (s1 == s2) {
        print("Iguais (Correto!)"); 
    } else {
        print("Diferentes (Erro!)");
    }

    // Teste 2: Conteúdos diferentes
    if (s1 != s3) {
        print("Diferentes (Correto!)");
    }
    
    // Teste 3: Input do usuário (Garante que não é a mesma referência de memória)
    print("Digite 'teste':");
    read(s1); 
    if (s1 == "teste") {
        print("Voce digitou teste!");
    }
}
⚠️ Atenção aos Comparadores de Grandeza (>, <, >=)
Strings em Java não suportam > ou < diretamente. Você precisa usar .compareTo(). Se o professor pedir isso:

s1.compareTo(s2) retorna:

0 se igual.

< 0 se s1 vem antes.

> 0 se s1 vem depois.

Você teria que chamar invokevirtual java/lang/String/compareTo(Ljava/lang/String;)I e depois verificar o resultado inteiro.

Mas, geralmente, apenas == e != são exigidos para Strings em trabalhos básicos.

Aqui está o README com o passo a passo para liberar o Resto da Divisão (%) para números decimais (double) e mistos.

A JVM possui uma instrução específica para isso chamada drem, mas seu compilador atual bloqueia qualquer coisa que não seja inteiro. Vamos mudar isso.

# --- ➗ Resto da Divisão com Double (%)
O Problema
Atualmente, o analisador semântico proíbe 5.5 % 2. Além disso, a instrução irem (usada para inteiros) não funciona com números de ponto flutuante.

A Solução
Permitir Double na análise semântica.

Converter automaticamente (Coerção) se misturar Int com Double.

Usar a instrução drem (Double Remainder) no gerador.

Passo 1: Atualizar o Semântico (Semantic.hs)
Substitua a sua regra atual do Mod (que provavelmente lança erro se não for int) por esta versão mais flexível. Ela trata os 4 casos possíveis.

Arquivo: Semantic.hs

Haskell

tExpr tfun tvar (Mod e1 e2) = do
    (t1, e1') <- tExpr tfun tvar e1
    (t2, e2') <- tExpr tfun tvar e2

    case (t1, t2) of
        -- Caso 1: Inteiro % Inteiro (Comportamento Padrão)
        (TInt, TInt) -> return (TInt, Mod e1' e2')

        -- Caso 2: Double % Double (Usa drem)
        (TDouble, TDouble) -> return (TDouble, Mod e1' e2')

        -- Caso 3: Int % Double (Converte o da esquerda para Double)
        (TInt, TDouble) -> return (TDouble, Mod (IntDouble e1') e2')

        -- Caso 4: Double % Int (Converte o da direita para Double)
        (TDouble, TInt) -> return (TDouble, Mod e1' (IntDouble e2'))

        -- Erro (Ex: String % Int)
        _ -> do 
             errorMsg ("Tipos invalidos para Modulo (%): " ++ show t1 ++ " e " ++ show t2)
             return (TDouble, Mod e1' e2')
Passo 2: Atualizar o Gerador (Generator.hs)
Agora ensinamos o gerador a escolher a instrução certa.

Se o resultado for Int, usa irem.

Se o resultado for Double, usa drem.

Arquivo: Generator.hs

Haskell

genExpr fun tab (Mod e1 e2) = do
    (t1, code1) <- genExpr fun tab e1
    (t2, code2) <- genExpr fun tab e2

    -- A verificação aqui é simples: Se qualquer um for Double, 
    -- o Semantic.hs já garantiu que o outro também foi convertido.
    if t1 == TDouble || t2 == TDouble
        then return (TDouble, code1 ++ code2 ++ "\tdrem\n") -- Double Remainder
        else return (TInt,    code1 ++ code2 ++ "\tirem\n") -- Integer Remainder
📝 Como Testar
Crie um arquivo de teste para garantir que a matemática e a conversão automática estão funcionando:

Java

{
    double a = 5.5;
    double b = 2.0;
    
    int x = 10;
    double y = 4.2;
    
    // Teste 1: Double puro (5.5 % 2.0 = 1.5)
    print("5.5 % 2.0: ");
    print(a % b);

    // Teste 2: Int com Double (10 % 4.2 -> 10.0 % 4.2 = 1.6)
    print("10 % 4.2: ");
    print(x % y);
    
    // Teste 3: Double com Int (5.5 % 2 -> 5.5 % 2.0 = 1.5)
    print("5.5 % 2: ");
    print(a % 2);
}
O Resultado Esperado
1.5

1.600000... (Pode haver pequenas variações de precisão flutuante, é normal na JVM)

1.5

# --- 🌍 Implementação de Variáveis Globais

O Objetivo
Permitir declarar variáveis fora das funções que sejam visíveis por todos.

Locais: iload / istore (Vivem na pilha da função).

Globais: getstatic / putstatic (Vivem na classe).

Passo 1: Atualizar a Árvore (RI.hs)
Precisamos mudar a estrutura do programa (Prog) para aceitar uma lista de declarações globais antes das funções.

Arquivo: RI.hs

Haskell

-- Adicione um campo [Var] extra no início para as Globais
data Prog = Prog [Var]                  -- <--- NOVAS GLOBAIS
                 [Funcao]               -- Assinaturas
                 [(Id, [Var], [Cmd])]   -- Corpos das Funções
                 [Var]                  -- Vars do Main
                 [Cmd]                  -- Comandos do Main
                 deriving (Show, Eq)
Passo 2: Atualizar o Parser (Parser.y)
Vamos permitir que o usuário declare variáveis antes de começar a escrever funções.

Arquivo: Parser.y Altere a regra principal Program:

Haskell

-- Adicione 'Declaracoes' no início
Program : Declaracoes ListaFuncoes BlocoPrincipal 
          { case $3 of 
              BlocoP v c -> Prog (fst $1)       -- Globais (fst de Declaracoes)
                                 (map funcaoDeFundef $2) 
                                 (map defDeFundef $2) 
                                 v c 
          }
        | ListaFuncoes BlocoPrincipal 
          { case $2 of 
              BlocoP v c -> Prog []             -- Sem globais
                                 (map funcaoDeFundef $1) 
                                 (map defDeFundef $1) 
                                 v c 
          }
Nota: Reutilizamos a regra Declaracoes que você já tem. Ela retorna ([Var], [Cmd]), mas para globais ignoramos os comandos de inicialização (snd) por enquanto ou tratamos no bloco estático <clinit> (avançado).

Passo 3: O Semântico (Semantic.hs)
O "Policial" precisa aprender a olhar em dois lugares: Escopo Local (prioridade) e Escopo Global.

1. Atualize a função buscaVar: Ela deve receber duas listas: locais e globais.

Haskell

buscaVar locais globais nome = 
    case lookup nome [(n, t) | n :#: (t, _) <- locais] of
        Just tipo -> return (tipo, IdVar nome) -- Achou na Local
        Nothing   -> 
            case lookup nome [(n, t) | n :#: (t, _) <- globais] of
                Just tipo -> return (tipo, IdVar nome) -- Achou na Global
                Nothing   -> errorMsg ("Variavel nao declarada: " ++ show nome)
2. Propague a lista de globais: Você precisará passar a lista de globais para dentro de tExpr e tComando e atualizar todas as chamadas recursivas.

De: tExpr tfun tvar ...

Para: tExpr tfun tglobais tlocais ...

Passo 4: O Gerador de Código (Generator.hs)
Aqui é a mudança mais drástica. Precisamos diferenciar Local de Global na hora de gerar o Assembly.

1. Declarando as Globais (.field) No genProg, antes de gerar os métodos, itere sobre a lista de globais e gere os campos:

Haskell

genGlobal (nome :#: (tipo, _)) = 
    let desc = case tipo of { TInt -> "I"; TDouble -> "D"; TString -> "Ljava/lang/String;"; TBool -> "I"; _ -> "V" }
    in ".field public static " ++ nome ++ " " ++ desc ++ "\n"
2. Acessando Variáveis (genExpr -> IdVar) Quando for usar uma variável, verifique se ela é local. Se não for, assuma global.

Haskell

genExpr fun tlocais tglobais (IdVar nome) = 
    case lookup nome (zip [n | n :#: _ <- tlocais] [0..]) of
        -- CASO 1: É Local (Existe um índice na pilha)
        Just index -> return (tipoLocal, "iload " ++ show index ++ "\n") 
        
        -- CASO 2: É Global (Não está na lista local)
        Nothing -> do
             -- Procure o tipo na lista de globais para saber o descritor (I ou D)
             let tipoGlobal = ... (busque em tglobais)
             let desc = ... (I, D, etc)
             return (tipoGlobal, "\tgetstatic Program/" ++ nome ++ " " ++ desc ++ "\n")
3. Atribuindo Variáveis (genCmd -> Atrib) Mesma lógica:

Haskell

genCmd fun tlocais tglobais (Atrib nome expr) = do
    (_, codeExpr) <- genExpr ... expr
    
    case lookup nome (zip [n | n :#: _ <- tlocais] [0..]) of
        -- Local
        Just index -> return (codeExpr ++ "\tistore " ++ show index ++ "\n")
        
        -- Global
        Nothing -> do
             let desc = ...
             return (codeExpr ++ "\tputstatic Program/" ++ nome ++ " " ++ desc ++ "\n")
📝 Exemplo de Teste
Java

// Variáveis Globais (Fora de tudo)
int contadorGlobal;
double taxa;

void incrementa() {
    // Acessa global dentro da função
    contadorGlobal = contadorGlobal + 1;
}

{
    contadorGlobal = 0;
    taxa = 5.5;
    
    incrementa();
    print(contadorGlobal); // Deve imprimir 1
}

# --- 📥 Entrada de Dados (Scanner)
O Objetivo
Transformar o comando read(x) em bytecode que:

Cria um objeto Scanner.

Lê o dado correto (nextInt, nextDouble, next) dependendo do tipo de x.

Armazena o valor em x.

Passo 1: O Parser e RI (RI.hs e Parser.y)
Você provavelmente já tem isso, mas confirme. O comando de leitura precisa guardar qual variável vai receber o valor.

Arquivo: RI.hs

Haskell

data Cmd = ...
         | Leitura String  -- Guarda o nome da variável (ex: "x")
Arquivo: Parser.y

Haskell

CmdLeitura : read '(' id ')' ';' { Leitura $3 }
Passo 2: O Semântico (Semantic.hs)
O "Policial" precisa garantir que a variável existe.

Arquivo: Semantic.hs

Haskell

tComando contexto tfun tvar (Leitura nome) = do
  -- Verifica se a variável foi declarada
  case lookup nome [(n, t) | n :#: (t, _) <- tvar] of
    Just _  -> return (Leitura nome) -- Sucesso, a variável existe
    Nothing -> do
       errorMsg ("Variavel nao declarada no read: " ++ show nome)
       return (Leitura nome)
Nota: Se você já implementou globais, lembre-se de procurar na lista de globais também.

Passo 3: O Gerador de Código (Generator.hs)
Esta é a parte principal. Vamos criar um Scanner novo a cada leitura (é ineficiente num sistema real, mas perfeito para compiladores acadêmicos pela simplicidade).

Lógica do Bytecode:

new java/util/Scanner (Cria objeto)

dup (Duplica referência)

getstatic java/lang/System/in (Pega o teclado)

invokespecial java/util/Scanner/<init> (Chama construtor)

invokevirtual java/util/Scanner/nextTipo() (Lê o valor)

istore / dstore / astore (Salva na variável)

Implementação no genCmd:

Haskell

genCmd fun tlocais tglobais (Leitura nome) = do
    -- 1. Descobre o tipo da variável e o índice (Local ou Global)
    let (tipo, comandoStore) = 
          case lookup nome (zip [n | n :#: _ <- tlocais] [0..]) of
            -- CASO LOCAL:
            Just index -> 
               let tipoVar = [t | n :#: (t,_) <- tlocais, n == nome] !! 0
                   store   = case tipoVar of
                               TInt    -> "\tistore " ++ show index ++ "\n"
                               TDouble -> "\tdstore " ++ show index ++ "\n"
                               TString -> "\tastore " ++ show index ++ "\n"
                               TBool   -> "\tistore " ++ show index ++ "\n"
                               _       -> ""
               in (tipoVar, store)
            
            -- CASO GLOBAL (Se tiver implementado):
            Nothing -> 
               case lookup nome [(n, t) | n :#: (t,_) <- tglobais] of
                 Just tipoVar -> 
                    let desc = case tipoVar of { TInt->"I"; TDouble->"D"; TString->"Ljava/lang/String;"; TBool->"I"; _->"V" }
                        store = "\tputstatic Program/" ++ nome ++ " " ++ desc ++ "\n"
                    in (tipoVar, store)
                 Nothing -> error "Erro interno: Var nao achada no gerador"

    -- 2. Define qual método do Scanner chamar
    let metodoScanner = case tipo of
            TInt    -> "nextInt()I"
            TDouble -> "nextDouble()D"
            TString -> "next()Ljava/lang/String;" -- Lê uma palavra. Use "nextLine" para frase.
            TBool   -> "nextBoolean()Z"
            _       -> "nextInt()I"

    -- 3. Gera o bloco de código completo
    return $ 
        -- A: Instancia o Scanner
        "\tnew java/util/Scanner\n" ++
        "\tdup\n" ++
        "\tgetstatic java/lang/System/in Ljava/io/InputStream;\n" ++
        "\tinvokespecial java/util/Scanner/<init>(Ljava/io/InputStream;)V\n" ++
        
        -- B: Chama o método de leitura correto
        "\tinvokevirtual java/util/Scanner/" ++ metodoScanner ++ "\n" ++
        
        -- C: Salva na variável
        comandoStore
📝 Como Testar
Crie um teste interativo (testeScanner.txt):

Java

{
    int idade;
    double altura;
    string nome;
    bool estudante;

    print("Digite seu nome:");
    read(nome);

    print("Digite sua idade:");
    read(idade);

    print("Digite sua altura (com vírgula ou ponto dependendo do seu PC):");
    read(altura);

    print("Voce eh estudante? (true/false):");
    read(estudante);

    print("--- Dados Recebidos ---");
    print(nome);
    print(idade);
    print(altura);
    
    if (estudante) {
        print("Estudante: Sim");
    } else {
        print("Estudante: Nao");
    }
}
⚠️ Importante sobre Locale (Ponto vs Vírgula)
O Scanner do Java usa a configuração do sistema operacional para ler Double.

Se seu PC está em Português, digite 10,5 (vírgula).

Se está em Inglês, digite 10.5 (ponto). Se digitar errado, o programa Java vai crashar com InputMismatchException. Isso é normal e esperado para o Scanner padrão.

# --- 🚫 Implementação do null
O Objetivo
Permitir escrever string s = null;.

Permitir comparações if (s == null).

Proibir int x = null;.

Passo 1: Atualizar a Árvore e Tipos (RI.hs)
Precisamos de um tipo para representar o literal null e um nó na árvore de expressão.

Arquivo: RI.hs

Haskell

-- Adicione ao Data Tipo
data Tipo = ... 
          | TNull   -- Tipo específico do literal null
          deriving (Eq, Show)

-- Adicione ao Data Expr
data Expr = ...
          | Null    -- O valor literal
          deriving (Eq, Show)
Passo 2: Token e Lexer (Token.hs e Lex.x)
Arquivo: Token.hs

Haskell

data Token = ... | TNULL | ...
Arquivo: Lex.x

Haskell

"null"   { \s -> TNULL }
Passo 3: O Parser (Parser.y)
Arquivo: Parser.y

Declare o token:

Haskell

%token
  null { TNULL }
Adicione a regra em Expr:

Haskell

Expr : ...
     | null  { Null }
Passo 4: O Semântico (Semantic.hs) — A Parte Crítica
Aqui definimos as regras do jogo.

1. Tipagem da Expressão

Haskell

tExpr tfun tvar Null = return (TNull, Null)
2. Regra de Atribuição (tComando -> Atrib) Você precisa permitir que uma variável String receba Null. Vá na parte onde verifica Atrib e adicione:

Haskell

case (tv, texpr) of
    ...
    (TString, TNull) -> return (Atrib nome e') -- String aceita Null
    (TNull, TString) -> return (Atrib nome e') -- (Raro, mas consistente)
    (TString, TString) -> return (Atrib nome e')
    -- Se tentar (TInt, TNull) vai cair no 'otherwise' e dar erro (Correto!)
3. Regra de Comparação (coercaoExprR -> == e !=) Você precisa permitir comparar uma String com Null. Se você não fizer isso, seu if (s == null) vai dar erro de tipos incompatíveis.

Haskell

coercaoExprR op e1 e2 t1 t2
  -- ... suas regras anteriores ...
  | (t1 == TString && t2 == TNull)   = return (op e1 e2) -- String == Null
  | (t1 == TNull   && t2 == TString) = return (op e1 e2) -- Null == String
  | (t1 == TNull   && t2 == TNull)   = return (op e1 e2) -- Null == Null
Passo 5: O Gerador de Código (Generator.hs)
Aqui temos duas situações: gerar o valor null e comparar com null.

1. Gerar o valor (genExpr) A JVM tem uma instrução específica para empilhar null.

Haskell

genExpr fun tab Null = return (TNull, "\taconst_null\n")
2. Comparação (Req / ==) — Cuidado! Se você implementou comparação de Strings usando .equals, isso vai quebrar com null (porque null.equals(...) trava o programa). Para null, temos que usar comparação de referência (if_acmpeq).

Atualize o seu genExpr do Req:

Haskell

genExpr fun tab (Req e1 e2) = do
  (t1, code1) <- genExpr fun tab e1
  (t2, code2) <- genExpr fun tab e2
  
  -- Lógica Especial para String e Null
  if (t1 == TString && t2 == TString) 
     then return (TBool, code1 ++ code2 ++ "\tinvokevirtual java/lang/String/equals(Ljava/lang/Object;)Z\n")
     
  -- Se um dos lados for Null, usa comparação de memória (acmpeq)
  else if (t1 == TString && t2 == TNull) || (t1 == TNull && t2 == TString) || (t1 == TNull && t2 == TNull)
     then do
        lTrue <- novoLabel
        lSaida <- novoLabel
        return (TBool, code1 ++ code2 ++ 
                       "\tif_acmpeq " ++ lTrue ++ "\n" ++  -- Pula se referências forem iguais (null == null)
                       "\ticonst_0\n" ++                   -- Coloca False
                       "\tgoto " ++ lSaida ++ "\n" ++
                       lTrue ++ ":\n" ++
                       "\ticonst_1\n" ++                   -- Coloca True
                       lSaida ++ ":\n")
  
  else do 
     -- ... sua lógica normal para Int/Double/Bool ...
Para o Rdif (!=), a lógica é a mesma, mas usando if_acmpne (Not Equal).

📝 Como Testar
Java

{
    string s1 = "ola";
    string vazia = null;
    int x = 10;

    // Teste 1: Atribuição
    print(vazia); // Deve imprimir "null" (Java faz isso automático)

    // Teste 2: Comparação True
    if (vazia == null) {
        print("Vazia eh null (Correto)");
    }

    // Teste 3: Comparação False
    if (s1 != null) {
        print("s1 nao eh null (Correto)");
    }

    // Teste de Erro (Descomente para testar o Semântico)
    // x = null;  <-- Deve dar erro de compilação: Int não aceita Null
}

# -- 🔤 Implementação do Tipo char
O Objetivo
Permitir declarar: char letra = 'A';

Permitir literais entre aspas simples: 'z'

Imprimir caracteres corretamente.

Passo 1: Atualizar a Árvore (RI.hs)
Precisamos de um novo Tipo e de um novo nó de Expressão para guardar o caractere.

Arquivo: RI.hs

Haskell

-- Adicione ao Data Tipo
data Tipo = ... 
          | TChar   -- O tipo da variável
          deriving (Eq, Show)

-- Adicione ao Data Expr
data Expr = ...
          | LitChar Char -- O valor literal (ex: 'a')
          deriving (Eq, Show)
Passo 2: Token e Lexer (Token.hs e Lex.x)
Precisamos ler a palavra reservada char e os literais 'x'.

Arquivo: Token.hs

Haskell

data Token = ... 
           | TCHAR          -- Para a palavra reservada 'char'
           | TLITCHAR Char  -- Para o valor literal 'a'
Arquivo: Lex.x Adicione as regras:

Haskell

-- Palavra reservada
"char"   { \s -> TCHAR }

-- Literal de char (entre aspas simples)
-- A regex simplificada: aspas, qualquer coisa, aspas
\' . \'  { \s -> TLITCHAR (head (tail s)) } 
Nota: head (tail s) pega o segundo caractere da string 'a', que é o próprio a.

Passo 3: O Parser (Parser.y)
Conecte os tokens à árvore.

Arquivo: Parser.y

Declare os tokens:

Haskell

%token
  char     { TCHAR }
  litchar  { TLITCHAR $$ } -- $$ carrega o valor Char
Adicione na regra de Tipo:

Haskell

Tipo : ...
     | char { TChar }
Adicione na regra de Expr:

Haskell

Expr : ...
     | litchar { LitChar $1 }

Passo 4: O Semântico (Semantic.hs)

O "Policial" precisa garantir que char só receba char.

1. Tipagem da Expressão (tExpr)

Haskell

tExpr tfun tvar (LitChar c) = return (TChar, LitChar c)
2. Regra de Atribuição (tComando -> Atrib) Adicione ao case da atribuição:

Haskell

case (tv, texpr) of
    ...
    (TChar, TChar) -> return (Atrib nome e') -- Permite char = 'a'
3. Comparações (coercaoExprR) Permita comparar dois caracteres ('a' == 'b').

Haskell

coercaoExprR op e1 e2 t1 t2
  ...
  | (t1 == TChar && t2 == TChar) = return (op e1 e2)
Passo 5: O Gerador de Código (Generator.hs)
Aqui tratamos o char como um número inteiro (código ASCII/Unicode).

1. Tamanho da Variável (varTamanho) Ocupa 1 slot na pilha, igual ao Int.

Haskell

varTamanho TChar = 1
2. Gerar o Literal (genExpr) Para colocar um char na pilha, empilhamos seu código numérico ASCII usando bipush (se for pequeno) ou ldc. Vamos usar uma função auxiliar ord do Haskell que converte Char para Int.

No topo do arquivo, importe: import Data.Char (ord)

Haskell

genExpr fun tab (LitChar c) = 
    let valorAscii = ord c
    in return (TChar, "\tldc " ++ show valorAscii ++ "\n")
3. Descritor de Campo Global (Opcional, se implementou Globais) Se tiver globais, o descritor de char na JVM é C.

Haskell

-- Na função genGlobal
... case tipo of { ...; TChar -> "C"; ... }
4. Impressão (genCmd -> Imp) Se você usa System.out.println, precisa garantir que chame a versão que aceita char, senão ele vai imprimir o número inteiro.

Haskell

genCmd fun tlocais tglobais (Imp expr) = do
    (tipo, code) <- genExpr ... expr
    
    let metodo = case tipo of
           TInt    -> "println(I)V"
           TDouble -> "println(D)V"
           TString -> "println(Ljava/lang/String;)V"
           TBool   -> "println(I)V"
           TChar   -> "println(C)V"  -- <--- VERSÃO ESPECÍFICA PARA CHAR
           
    return $ code ++ 
             "\tgetstatic java/lang/System/out Ljava/io/PrintStream;\n" ++
             "\tswap\n" ++
             "\tinvokevirtual java/io/PrintStream/" ++ metodo ++ "\n"
📝 Como Testar
Java

{
    char letra;
    char digito = '9';
    
    letra = 'A';
    
    print("Letra:");
    print(letra);   // Deve imprimir A
    
    print("Digito:");
    print(digito);  // Deve imprimir 9
    
    if (letra == 'A') {
        print("Eh a letra A! (Correto)");
    }
    
    if (letra != 'B') {
        print("Nao eh a letra B (Correto)");
    }
}
Curiosidade JVM
Se você fizer char c = 'A'; print((int) c);, ele imprimirá 65. Isso acontece porque, na memória da JVM, o char é apenas um número de 16 bits sem sinal.

📦 Implementação de Vetores (Arrays)
O Objetivo
Declarar vetores: int[] v;

Inicializar: v = new int[10];

Escrever: v[0] = 50;

Ler: x = v[0];

Passo 1: Atualizar a Árvore e Tipos (RI.hs)
Precisamos representar o Tipo Array, o comando de Atribuição em Array e a expressão de Acesso/Criação.

Arquivo: RI.hs

Haskell

-- 1. No Data Tipo (Adicione suporte a arrays genéricos)
data Tipo = ... 
          | TArray Tipo  -- Ex: TArray TInt representa int[]
          deriving (Eq, Show)

-- 2. No Data Expr (Leitura e Criação)
data Expr = ...
          | AcessoArray String Expr   -- Nome[Indice]
          | NewArray Tipo Expr        -- new Tipo[Tamanho]
          deriving (Eq, Show)

-- 3. No Data Cmd (Escrita)
data Cmd = ...
         | AtribArray String Expr Expr -- Nome[Indice] = Valor
         deriving (Eq, Show)
Passo 2: Token e Lexer (Token.hs e Lex.x)
Precisamos dos colchetes [ ] e da palavra new.

Arquivo: Token.hs

Haskell

data Token = ... | TLBRACK | TRBRACK | TNEW
Arquivo: Lex.x

Haskell

"["    { \s -> TLBRACK }
"]"    { \s -> TRBRACK }
"new"  { \s -> TNEW }
Passo 3: O Parser (Parser.y)
Aqui a gramática fica um pouco mais complexa para suportar a sintaxe de colchetes.

1. Tokens:

Haskell

%token
  '[' { TLBRACK }
  ']' { TRBRACK }
  new { TNEW }
2. Regra de Tipo (Permitir int[]):

Haskell

Tipo : ...
     | Tipo '[' ']' { TArray $1 }
3. Regra de Expr (Acesso e Criação):

Haskell

Expr : ...
     | id '[' Expr ']'             { AcessoArray $1 $3 }
     | new Tipo '[' Expr ']'       { NewArray $2 $4 }
4. Regra de Comando (Atribuição):

Haskell

Comando : ...
        | id '[' Expr ']' '=' Expr ';' { AtribArray $1 $3 $6 }
Passo 4: O Semântico (Semantic.hs)
O "Policial" precisa verificar se o índice é Inteiro e se os tipos batem.

1. Criação (NewArray)

Haskell

tExpr tfun tvar (NewArray tipo tamanho) = do
    (tTam, eTam') <- tExpr tfun tvar tamanho
    if tTam == TInt 
       then return (TArray tipo, NewArray tipo eTam')
       else do
           errorMsg "Tamanho do array deve ser inteiro."
           return (TArray tipo, NewArray tipo eTam')
2. Leitura (AcessoArray)

Haskell

tExpr tfun tvar (AcessoArray nome indice) = do
    (tipoVar, _) <- buscaVar tvar nome -- (Se tiver globais, passe tglobais tb)
    (tInd, eInd') <- tExpr tfun tvar indice
    
    if tInd /= TInt 
       then errorMsg "Indice do array deve ser inteiro" >> return (TVoid, AcessoArray nome eInd')
       else case tipoVar of
               TArray tipoBase -> return (tipoBase, AcessoArray nome eInd')
               _ -> errorMsg "Tentativa de indexar variavel que nao eh array" >> return (TVoid, AcessoArray nome eInd')
3. Escrita (AtribArray) Adicione em tComando:

Haskell

tComando contexto tfun tvar (AtribArray nome indice valor) = do
    (tipoVar, _) <- buscaVar tvar nome
    (tInd, eInd') <- tExpr tfun tvar indice
    (tVal, eVal') <- tExpr tfun tvar valor
    
    -- Validações: Indice é Int? Variável é Array? Valor bate com tipo base?
    -- (Implemente similar ao AcessoArray, verificando se tVal == tipoBase)
    return (AtribArray nome eInd' eVal')
Passo 5: O Gerador de Código (Generator.hs)
Aqui usamos instruções específicas para arrays (ia... para int array, da... para double array).

1. Criando o Array (newarray)

Haskell

genExpr fun tab (NewArray tipoBase tamanho) = do
    (_, codeTam) <- genExpr fun tab tamanho
    let instrucao = case tipoBase of
                      TInt -> "newarray int"
                      TDouble -> "newarray double"
                      TString -> "anewarray java/lang/String"
                      _ -> "newarray int" -- Fallback
    return (TArray tipoBase, codeTam ++ "\t" ++ instrucao ++ "\n")
2. Lendo do Array (aload + xaload)

Haskell

genExpr fun tab (AcessoArray nome indice) = do
    (_, codeIndice) <- genExpr fun tab indice
    
    -- 1. Carrega a referência do array (aload)
    (_, codeArray) <- genExpr fun tab (IdVar nome) -- Reutiliza lógica de var
    
    -- 2. Descobre o tipo para saber qual load usar
    let tipoBase = ... (Descubra o tipo da variável 'nome' na tabela)
    let instrucao = case tipoBase of { TArray TInt -> "iaload"; TArray TDouble -> "daload"; _ -> "aaload" }

    return (tipoBase, codeArray ++ codeIndice ++ "\t" ++ instrucao ++ "\n")
3. Escrevendo no Array (aload + xastore)

Haskell

genCmd fun tlocais tglobais (AtribArray nome indice valor) = do
    (_, codeIndice) <- genExpr ... indice
    (_, codeValor)  <- genExpr ... valor
    
    -- 1. Pega referência do array
    let (indexVar, codeLoadArray) = ... (Lógica para achar índice local da variavel array e gerar 'aload X')
    
    let instrucao = case tipoVar of { TArray TInt -> "iastore"; TArray TDouble -> "dastore"; _ -> "aastore" }

    return $ codeLoadArray ++  -- Coloca array na pilha
             codeIndice ++     -- Coloca índice
             codeValor ++      -- Coloca valor
             "\t" ++ instrucao ++ "\n"
📝 Exemplo de Teste (testeArray.txt)
Java

{
    int[] numeros;
    int x;
    
    // 1. Alocação
    numeros = new int[5];
    
    // 2. Escrita
    numeros[0] = 10;
    numeros[1] = 20;
    
    // 3. Leitura e Operação
    x = numeros[0] + numeros[1];
    
    print("Soma do vetor:");
    print(x); // Deve imprimir 30
}

# --- ▦ Implementação de Matrizes (2D)
O Objetivo
Declarar: int[][] m;

Inicializar: m = new int[5][5];

Escrever: m[0][1] = 10;

Ler: x = m[0][1];

Passo 1: Atualizar a Árvore (RI.hs)
Para facilitar e não quebrar o que você já fez com Vetores, vamos criar estruturas específicas para Matriz.

Arquivo: RI.hs

Haskell

-- No Data Tipo
data Tipo = ... 
          | TMatriz Tipo   -- Representa int[][] (Matriz de Tipo)
          deriving (Eq, Show)

-- No Data Expr
data Expr = ...
          | NewMatriz Tipo Expr Expr     -- new Tipo[Linhas][Colunas]
          | AcessoMatriz String Expr Expr -- Nome[Linha][Coluna]
          deriving (Eq, Show)

-- No Data Cmd
data Cmd = ...
         | AtribMatriz String Expr Expr Expr -- Nome[L][C] = Valor
         deriving (Eq, Show)
Passo 2: O Parser (Parser.y)
Vamos definir a sintaxe de dois colchetes [][].

1. Regra de Tipo:

Haskell

Tipo : ...
     | Tipo '[' ']' '[' ']' { TMatriz $1 }
2. Regra de Expr (Criação e Leitura):

Haskell

Expr : ...
     -- Criação: new int[5][5]
     | new Tipo '[' Expr ']' '[' Expr ']'  { NewMatriz $2 $4 $7 }
     
     -- Leitura: m[0][0]
     | id '[' Expr ']' '[' Expr ']'        { AcessoMatriz $1 $3 $6 }
3. Regra de Comando (Escrita):

Haskell

Comando : ...
        -- Escrita: m[0][0] = 10;
        | id '[' Expr ']' '[' Expr ']' '=' Expr ';' { AtribMatriz $1 $3 $6 $9 }
Passo 3: O Semântico (Semantic.hs)
Validar se os dois índices são inteiros.

1. Criação (NewMatriz)

Haskell

tExpr tfun tvar (NewMatriz tipo l c) = do
    (tL, eL') <- tExpr tfun tvar l
    (tC, eC') <- tExpr tfun tvar c
    
    if tL == TInt && tC == TInt 
       then return (TMatriz tipo, NewMatriz tipo eL' eC')
       else do
           errorMsg "Dimensoes da matriz devem ser inteiras."
           return (TMatriz tipo, NewMatriz tipo eL' eC')
2. Leitura (AcessoMatriz)

Haskell

tExpr tfun tvar (AcessoMatriz nome l c) = do
    (tipoVar, _) <- buscaVar tvar nome
    (tL, eL') <- tExpr tfun tvar l
    (tC, eC') <- tExpr tfun tvar c
    
    if tL == TInt && tC == TInt 
       then case tipoVar of
               TMatriz tipoBase -> return (tipoBase, AcessoMatriz nome eL' eC')
               _ -> errorMsg "Variavel nao eh matriz" >> return (TVoid, AcessoMatriz nome eL' eC')
       else errorMsg "Indices devem ser inteiros" >> return (TVoid, AcessoMatriz nome eL' eC')
3. Escrita (AtribMatriz) Adicione em tComando:

Haskell

tComando contexto tfun tvar (AtribMatriz nome l c valor) = do
    -- Faça as mesmas validações de índices acima...
    -- Valide se o 'valor' bate com o 'tipoBase' da matriz
    return (AtribMatriz nome l' c' valor')
Passo 4: O Gerador de Código (Generator.hs)
Aqui usamos multianewarray para criar e lógica de array duplo para acessar.

1. Criando (NewMatriz)

Haskell

genExpr fun tab (NewMatriz tipoBase l c) = do
    (_, codeL) <- genExpr fun tab l
    (_, codeC) <- genExpr fun tab c
    
    -- Descritor: [[I para int, [[D para double
    let desc = case tipoBase of { TInt -> "[[I"; TDouble -> "[[D"; _ -> "[[I" }
    
    return (TMatriz tipoBase, 
            codeL ++ codeC ++ 
            "\tmultianewarray " ++ desc ++ " 2\n") -- O '2' indica 2 dimensões
2. Lendo (AcessoMatriz) Lógica: CarregaMatriz -> PegaArrayDaLinha (aaload) -> PegaValorDaColuna (xaload)

Haskell

genExpr fun tab (AcessoMatriz nome l c) = do
    (_, codeL) <- genExpr fun tab l
    (_, codeC) <- genExpr fun tab c
    
    -- 1. Carrega a matriz (aload)
    (_, codeMatriz) <- genExpr fun tab (IdVar nome) 
    
    let instrucaoLoad = case tipoBase of { TInt -> "iaload"; TDouble -> "daload"; _ -> "iaload" }

    return (tipoBase, 
            codeMatriz ++      -- Pilha: [MatrizRef]
            codeL ++           -- Pilha: [MatrizRef, Linha]
            "\taaload\n" ++    -- Pilha: [ArrayInternoRef] (Pegou a linha)
            codeC ++           -- Pilha: [ArrayInternoRef, Coluna]
            "\t" ++ instrucaoLoad ++ "\n") -- Pilha: [Valor]
3. Escrevendo (AtribMatriz) Lógica: CarregaMatriz -> PegaArrayDaLinha (aaload) -> Coluna -> Valor -> xastore

Haskell

genCmd fun tlocais tglobais (AtribMatriz nome l c valor) = do
    (_, codeL) <- genExpr ... l
    (_, codeC) <- genExpr ... c
    (_, codeVal) <- genExpr ... valor
    
    -- Lógica para carregar a variável 'nome' (aload X)
    let (_, codeMatriz) = ... (use a mesma lógica do IdVar/AcessoArray)
    
    let instrucaoStore = case tipoBase of { TInt -> "iastore"; TDouble -> "dastore"; _ -> "iastore" }

    return $ codeMatriz ++     -- Pilha: [MatrizRef]
             codeL ++          -- Pilha: [MatrizRef, Linha]
             "\taaload\n" ++   -- Pilha: [ArrayInternoRef]
             codeC ++          -- Pilha: [ArrayInternoRef, Coluna]
             codeVal ++        -- Pilha: [ArrayInternoRef, Coluna, Valor]
             "\t" ++ instrucaoStore ++ "\n"
📝 Teste (testeMatriz.txt)
Java

{
    int[][] tab;
    int val;

    // Tabuleiro 3x3
    tab = new int[3][3];

    // Preenchendo a diagonal
    tab[0][0] = 1;
    tab[1][1] = 1;
    tab[2][2] = 1;

    // Lendo
    val = tab[1][1];
    print("Centro da matriz:");
    print(val);
}

# --- 🛑 Implementação de break e continue
O Objetivo
break: Pula para o label de FIM do loop.

continue: Pula para o label de INÍCIO/INCREMENTO do loop.

Passo 1: Atualizar a Árvore (RI.hs)
Adicione os comandos na sua estrutura.

Arquivo: RI.hs

Haskell

data Cmd = ...
         | Break
         | Continue
         deriving (Show, Eq)
Passo 2: Token e Lexer (Token.hs e Lex.x)
Arquivo: Token.hs

Haskell

data Token = ... | TBREAK | TCONTINUE
Arquivo: Lex.x

Haskell

"break"    { \s -> TBREAK }
"continue" { \s -> TCONTINUE }
Passo 3: O Parser (Parser.y)
Arquivo: Parser.y

Tokens:

Haskell

%token
  break    { TBREAK }
  continue { TCONTINUE }
Regra de Comando:

Haskell

Comando : ...
        | break ';'    { Break }
        | continue ';' { Continue }
Passo 4: O Semântico (Semantic.hs)
Aqui seria ideal verificar se o break está dentro de um loop, mas isso exige passar um estado extra. Para simplificar (e garantir nota), vamos apenas validar que é um comando válido.

Arquivo: Semantic.hs

Haskell

-- Apenas deixe passar
tComando contexto tfun tvar Break = return Break
tComando contexto tfun tvar Continue = return Continue
Passo 5: O Gerador de Código (Generator.hs) — A GRANDE MUDANÇA
Aqui precisamos alterar a assinatura das funções genCmd e genBloco para aceitarem um argumento extra: o Contexto do Loop.

O contexto será um Maybe (String, String), onde:

fst: Label de Início/Continue.

snd: Label de Fim/Break.

1. Defina o Tipo no topo do arquivo:

Haskell

type LoopContext = Maybe (String, String) -- (LabelContinue, LabelBreak)
2. Atualize genBloco: Ela precisa receber o contexto e repassar para os comandos.

Haskell

-- Antes: genBloco fun tab cmds
-- Agora:
genBloco :: [Funcao] -> [Var] -> LoopContext -> [Cmd] -> Result String
genBloco fun tab loopCtx [] = return ""
genBloco fun tab loopCtx (c:cs) = do
    codeCmd <- genCmd fun tab loopCtx c  -- Repassa loopCtx
    codeResto <- genBloco fun tab loopCtx cs
    return (codeCmd ++ codeResto)
3. Atualize genCmd: Agora todos os comandos recebem esse loopCtx. Para a maioria (atribuição, print, if), você só repassa ou ignora.

A. Implementando o Break e Continue:

Haskell

genCmd fun tab loopCtx Break = 
    case loopCtx of
        Just (_, lBreak) -> return ("\tgoto " ++ lBreak ++ "\n")
        Nothing -> error "Erro: 'break' utilizado fora de loop!"

genCmd fun tab loopCtx Continue = 
    case loopCtx of
        Just (lContinue, _) -> return ("\tgoto " ++ lContinue ++ "\n")
        Nothing -> error "Erro: 'continue' utilizado fora de loop!"
B. Atualizando o While (Para criar o contexto):

Haskell

genCmd fun tab _ (While cond bloco) = do -- Note o '_' ignorando o contexto anterior
    lInicio <- novoLabel
    lFim    <- novoLabel
    lTrue   <- novoLabel -- (Se sua lógica usa lTrue para entrar no bloco)

    -- Define o contexto deste loop: (lInicio, lFim)
    let novoContexto = Just (lInicio, lFim)

    condCode <- genExprL ... cond
    
    -- Passa o NOVO CONTEXTO para o bloco filho
    blocoCode <- genBloco fun tab novoContexto bloco 

    return $ lInicio ++ ":\n" ++ 
             condCode ++ ... 
             blocoCode ++ 
             "\tgoto " ++ lInicio ++ "\n" ++ 
             lFim ++ ":\n"
C. Atualizando o For (Cuidado com o incremento): No for, o continue deve pular para o incremento, não para a condição.

Haskell

genCmd fun tab _ (For init cond incr bloco) = do
    lCond <- novoLabel
    lIncr <- novoLabel  -- O 'continue' vem pra cá
    lFim  <- novoLabel
    
    -- Contexto: (lIncr, lFim)
    let novoContexto = Just (lIncr, lFim)
    
    codeInit <- genCmd fun tab Nothing init
    codeCond <- genExprL ... cond
    codeIncr <- genCmd fun tab Nothing incr
    codeBloco <- genBloco fun tab novoContexto bloco
    
    return $ 
       codeInit ++
       lCond ++ ":\n" ++
       codeCond ++ ...
       codeBloco ++
       lIncr ++ ":\n" ++  -- Label do incremento
       codeIncr ++
       "\tgoto " ++ lCond ++ "\n" ++
       lFim ++ ":\n"
D. Atualizando outros comandos: Para If, Atrib, Print, etc., você apenas adiciona o argumento loopCtx e, se eles tiverem blocos internos (como o If), repassa o mesmo loopCtx que recebeu.

Haskell

genCmd fun tab loopCtx (If cond bThen bElse) = do
    ...
    cThen <- genBloco fun tab loopCtx bThen -- Repassa o contexto
    cElse <- genBloco fun tab loopCtx bElse -- Repassa o contexto
    ...
📝 Como Testar
Java

{
    int i = 0;
    
    print("--- Teste Break ---");
    while (true) { // Loop infinito
        print(i);
        i++;
        if (i == 5) {
            print("Saindo...");
            break; // Deve pular para fora
        }
    }
    print("Saiu do While.");

    print("--- Teste Continue (Apenas Pares) ---");
    for (i = 0; i < 10; i++) {
        if (i % 2 != 0) {
            continue; // Pula o print e vai pro i++
        }
        print(i);
    }
}
✅ Resultado Esperado
Break: Imprime 0, 1, 2, 3, 4, "Saindo...", "Saiu do While".

Continue: Imprime 0, 2, 4, 6, 8.

Você tocou num ponto crucial. A resposta curta é: Sim, vai "quebrar" o seu código inteiro na hora de compilar. Mas não se assuste, isso é esperado e faz parte da refatoração.

O erro não será de execução ("cascata" de bugs rodando), mas sim um erro de compilação massivo inicialmente.

Por que isso acontece?
No Haskell, as funções são rígidas.

Antes: genCmd aceitava 2 argumentos (funções, tabela).

Depois: genCmd aceita 3 argumentos (funções, tabela, loopContext).

Como você mudou a "assinatura" da função, todos os lugares do seu código onde estava escrito genCmd antigo vão gritar: "Ei! Estão faltando argumentos aqui!".

O que vai acontecer (e como corrigir rápido)
Você terá que fazer uma "varredura" no arquivo Generator.hs.

1. Corrigindo os padrões (O Lado Esquerdo da função)
Você vai ter que adicionar o argumento extra em todas as linhas do genCmd.

Comandos que NÃO usam break/continue (Atribuição, Print, etc): Use _ (underline) para ignorar o contexto.

Haskell

-- ANTES
genCmd fun tab (Assign nome val) = ...

-- DEPOIS (Adicione o _ ou ctx)
genCmd fun tab _ (Assign nome val) = ...
Comandos que TEM blocos dentro (If): Você precisa capturar o contexto (ctx) para repassar para os blocos internos.

Haskell

-- ANTES
genCmd fun tab (If cond bThen bElse) = do
     ...
     c1 <- genBloco fun tab bThen
     c2 <- genBloco fun tab bElse

-- DEPOIS
genCmd fun tab ctx (If cond bThen bElse) = do -- Recebe 'ctx'
     ...
     c1 <- genBloco fun tab ctx bThen         -- Repassa 'ctx'
     c2 <- genBloco fun tab ctx bElse         -- Repassa 'ctx'
2. Corrigindo o genBloco
O genBloco chama o genCmd. Como o genCmd mudou, o genBloco também precisa mudar para repassar a informação.

Haskell

-- ANTES
genBloco fun tab (c:cs) = do
    c1 <- genCmd fun tab c
    c2 <- genBloco fun tab cs

-- DEPOIS
genBloco fun tab ctx (c:cs) = do
    c1 <- genCmd fun tab ctx c   -- Passa o ctx atual
    c2 <- genBloco fun tab ctx cs -- Continua passando pro resto
3. Corrigindo a chamada inicial (Main)
Lá no começo do seu compilador (provavelmente no Main.hs ou na função que dispara o gerador), você vai chamar o genCmd pela primeira vez. Como o código começa fora de qualquer loop, você passa Nothing.

Haskell

-- ANTES
codigo <- genBloco funcoes tabela arvore

-- DEPOIS
codigo <- genBloco funcoes tabela Nothing arvore
Resumo
O "erro em cascata" que você teme é, na verdade, o compilador te obrigando a ser consistente. Se você adicionar o argumento ctx (ou _) em todos os genCmd e atualizar o genBloco, tudo volta a compilar perfeitamente.

Dica: Comece alterando a assinatura de tipo (type) e vá corrigindo erro por erro de cima para baixo. É trabalhoso, mas é rápido.

Quer que eu escreva como ficaria o código do genCmd para um comando simples (tipo Print) e para um complexo (If) lado a lado para você copiar?

# -- Claro! Aqui está a implementação completa e modularizada para adicionar Float (Ponto Flutuante de 32 bits) ao seu compilador.

Separei por "arquivos" ou seções lógicas para você copiar e colar onde for necessário.

1. Atualizando a AST e Tipos (Grammar.hs ou Types.hs)
Primeiro, precisamos dizer ao compilador que o tipo Float existe.

Haskell

-- Definição dos Tipos da Linguagem
data Tipo 
    = TInt 
    | TFloat      -- <--- NOVO
    | TString
    | TVoid
    | TBool 
    deriving (Eq, Show)

-- Definição das Expressões
data Expr 
    = LitInt Int 
    | LitFloat Float  -- <--- NOVO (Guarda o valor decimal)
    | Var String 
    | Atrib String Expr 
    | Add Expr Expr 
    | Sub Expr Expr 
    | Mul Expr Expr 
    | Div Expr Expr
    -- ... outras expressões
    deriving (Show)

-- Definição dos Tokens (Para passar do Lexer pro Parser)
data Token 
    = TokenInt Int 
    | TokenFloat Float -- <--- NOVO
    | TokenSoma 
    -- ...
    deriving (Show)
2. O Lexer (Lexer.x)
Adicione a regra para reconhecer números com ponto (ex: 3.14, 0.5). Importante: Coloque esta regra antes da regra de ponto final ou de inteiros genéricos para evitar conflitos.

Haskell

tokens :-
  -- Dígitos, ponto, dígitos
  $digit+ \. $digit+    { \s -> TokenFloat (read s) } 
3. O Parser (Parser.y)
Ensine o Parser a aceitar o token e transformá-lo na AST.

Haskell

%token 
    float   { TokenFloat $$ }

%%

Exp : float           { LitFloat $1 }
    | Exp '+' Exp     { Add $1 $3 }
    | Exp '-' Exp     { Sub $1 $3 }
    | Exp '*' Exp     { Mul $1 $3 }
    | Exp '/' Exp     { Div $1 $3 }
4. Geração de Código (CodeGen.hs)
Aqui está a lógica pesada. Precisamos lidar com a Conversão Automática (Casting). Se somar Int com Float, o Int tem que virar Float.

A. Gerando Literais
Haskell

genExpr fun tab (LitFloat f) = return (TFloat, "\tldc " ++ show f ++ "\n")
B. Operações Aritméticas (Exemplo com Soma Add)
Substitua ou adapte sua lógica de Add atual por esta:

Haskell

genExpr fun tab (Add e1 e2) = do
  (t1, c1) <- genExpr fun tab e1 -- Gera código da esq
  (t2, c2) <- genExpr fun tab e2 -- Gera código da dir
  
  case (t1, t2) of
    -- Caso 1: Int + Int = Int (Usa iadd)
    (TInt, TInt) -> return (TInt, c1 ++ c2 ++ "\tiadd\n")

    -- Caso 2: Float + Float = Float (Usa fadd)
    (TFloat, TFloat) -> return (TFloat, c1 ++ c2 ++ "\tfadd\n")

    -- Caso 3: Int + Float = Float (Converte o 1º para float)
    (TInt, TFloat) -> return (TFloat, c1 ++ "\ti2f\n" ++ c2 ++ "\tfadd\n")

    -- Caso 4: Float + Int = Float (Converte o 2º para float)
    (TFloat, TInt) -> return (TFloat, c1 ++ c2 ++ "\ti2f\n" ++ "\tfadd\n")
    
    _ -> error "Tipos incompatíveis na soma."
(Repita essa mesma lógica de case para Sub, Mul e Div, trocando apenas fadd por fsub, fmul, fdiv).

C. Comparações (Relacionais)
Você precisa atualizar a função genRel que discutimos antes. Floats usam fcmpg.

Haskell

-- Atualize sua função genRel para suportar TFloat
genRel :: Tipo -> String -> String -> String
genRel TInt label op    = "\tif_icmp" ++ op ++ " " ++ label ++ "\n"

-- Para Float, a lógica é: Compara (fcmpg) -> Verifica Resultado (if...)
genRel TFloat label "eq" = "\tfcmpg\n\tifeq " ++ label ++ "\n" -- Igual
genRel TFloat label "ne" = "\tfcmpg\n\tifne " ++ label ++ "\n" -- Diferente
genRel TFloat label "gt" = "\tfcmpg\n\tifgt " ++ label ++ "\n" -- Maior
genRel TFloat label "ge" = "\tfcmpg\n\tifge " ++ label ++ "\n" -- Maior igual
genRel TFloat label "lt" = "\tfcmpg\n\tiflt " ++ label ++ "\n" -- Menor
genRel TFloat label "le" = "\tfcmpg\n\tifle " ++ label ++ "\n" -- Menor igual
D. Funções Auxiliares Atualizadas
Atualize aquelas funções helpers (tipoJVM, etc) para saberem o que é um Float.

Haskell

tipoJVM :: Tipo -> String
tipoJVM TInt    = "I"
tipoJVM TFloat  = "F"  -- <--- Muda de D (Double) para F (Float) se for 32bits
tipoJVM TDouble = "D"
tipoJVM TString = "Ljava/lang/String;"
tipoJVM TVoid   = "V"

-- Se você tiver uma função genPrint, atualize ela também:
genPrint TFloat = "\tinvokevirtual java/io/PrintStream/println(F)V\n"
Resumo das Instruções JVM usadas
ldc <x.x>: Carrega constante float.

fadd, fsub, fmul, fdiv: Operações matemáticas.

i2f: Converte Inteiro para Float (Obrigatório antes de operar tipos mistos).

fcmpg: Compara dois floats na pilha.

