# Sistemas de Tipos

## Introdução a Tipos

**Tipos:** Coleção de valores ou objetos que possuem alguma propriedade em comum. 

Na matemática, os tipos impõem restrições que evitam paradoxos. Universos não tipados apresentam inconsistências lógicas tais como o **Paradoxo de Russell**.



![Paradoxo de Russell](imagens/Sistemas%20de%20Tipos/slide_3_img_1.png)


### O Paradoxo de Russell
Alguns conjuntos não são membros de si próprios, como por exemplo o conjunto de todas as cadeiras. Outros, como por exemplo o conjunto formado por tudo que não é cadeira, são membros de si mesmos. Definindo $R$ como o conjunto de todos os conjuntos que não são membros de si próprio:

$$R = \{A \mid A \notin A\}$$

- Se $R$ é membro dele mesmo, então, por definição, $R$ não é membro de $R$.
- Se $R$ não é membro de $R$, então, por definição, $R$ é membro de $R$.

O próprio Russell respondeu ao seu paradoxo usando a teoria de tipos, definindo uma hierarquia para as proposições. Um dado predicado é válido para todos os objetos que estiverem em um mesmo nível (ou forem do mesmo tipo).

## A Necessidade de Tipos na Computação
Linguagens que não definem um intervalo de valores que uma variável pode armazenar são classificadas como **não tipadas**. Essas linguagens suportam um único tipo que representa todos os valores. O $\lambda$-cálculo puro é um exemplo extremo de linguagem não tipada.

Uma linguagem de programação é considerada **segura (safe)** se todos os erros de tipos podem ser detectados, ou seja, se as regras de tipos não podem ser violadas. Linguagens não tipadas podem ser consideradas seguras se efetuarem a verificação em tempo de execução.

A definição de um sistema de tipos no projeto de linguagens de programação é útil para:
- **Estruturação dos programas e documentação:** os tipos representam abstrações dos dados manipulados pelo programa e podem ajudar na compreensão do código.
- **Detecção de erros:** uma grande variedade de erros pode ser detectada automaticamente quando dados e funções são usados de forma inconsistente.
- **Eficiência:** informações sobre tipos permitem ao computador executar otimizações no código gerado.

## O Que é um Sistema de Tipos?
Sistemas de tipos são conjuntos de regras de inferência que permitem atribuir tipos às variáveis e expressões de linguagens de programação. O principal objetivo de um sistema de tipos é determinar, em tempo de compilação, se um programa é bem comportado, garantindo a ausência de erros de tipos em tempo de execução. 

Um sistema capaz de fornecer essa garantia é dito **consistente (sound)**. Para que seja possível provar a consistência do sistema de tipos, é necessária a sua formalização através de provas matemáticas (verificação de uma proposição por encadeamento de deduções lógicas a partir de um conjunto de axiomas).

### Formalização
A definição formal de um sistema de tipos é feita por um conjunto de enunciados (regras) denominadas **sentenças (judgments)**. Sentenças são afirmações sobre objetos sintáticos de um determinado tipo e têm a forma:

$$\Gamma \vdash e : \sigma$$

Essa sentença é lida como: *no contexto $\Gamma$ a expressão $e$ tem tipo $\sigma$*, ou *$\Gamma$ implica (deriva) que $e$ tem tipo $\sigma$*. Onde $\Gamma$ é um contexto, possivelmente vazio, onde estão definidos os tipos das variáveis que ocorrem livres em $e$ ($\Gamma = \{x_1 : \sigma_1, x_2 : \sigma_2, \dots, x_n : \sigma_n\}$).

A forma geral das regras de inferência é:

$$
\frac{\Gamma_1 \vdash e_1 : \sigma_1 \quad \Gamma_2 \vdash e_2 : \sigma_2 \quad \dots \quad \Gamma_n \vdash e_n : \sigma_n}{\Gamma \vdash e : \sigma}
$$

As sentenças acima da linha horizontal são as **premissas** e a sentença abaixo é a **conclusão**. Exemplo:

$$
\frac{\Gamma \vdash e_1 : Nat \quad \Gamma \vdash e_2 : Nat}{\Gamma \vdash e_1 + e_2 : Nat}
$$

## $\lambda$-Cálculo Simplesmente Tipado

- **Variáveis de Tipos:** $\alpha, \beta$
- **Variáveis de Expressões:** $x, y, z$
- **Expressões:** $e ::= x \mid \lambda x. e \mid e~e'$
- **Tipo Simples:** $\alpha ::= \tau \mid \tau \to \tau'$

Regras:
- **(VAR):**
  $$ \frac{\{x : \tau\} \in \Gamma}{\Gamma \vdash x : \tau} $$
- **(APP):**
  $$ \frac{\Gamma \vdash e : \tau \to \tau' \quad \Gamma \vdash e' : \tau}{\Gamma \vdash e~e' : \tau'} $$
- **(ABS):**
  $$ \frac{\Gamma, x : \tau' \vdash e : \tau}{\Gamma \vdash \lambda x.e : \tau' \to \tau} $$

> Onde $\Gamma, x : \tau$ representa $\Gamma \cup \{x : \tau\}$, sendo que $\Gamma$ não apresenta qualquer suposição de tipo prévia para $x$.

## Inferência de Tipos e Unificação

**Unificação** é a ideia central do processo de inferência de tipos. Um unificador para dois tipos é uma substituição $S$ que faz $S\tau_1 = S\tau_2$.

Uma **substituição** é uma função que mapeia variáveis de tipos em expressões de tipos: $S = \{\alpha_1 \mapsto \tau_1, \alpha_2 \mapsto \tau_2, \dots, \alpha_n \mapsto \tau_n\}$. A aplicação de uma substituição $S$ em um tipo $\tau$ ($S\tau$) resulta na troca de todas as variáveis de tipo que ocorrem em $\tau$ e pertencem ao domínio de $S$ pelo tipo correspondente.

A composição de substituições é representada por $S \circ S'$. Um unificador $S_g$ é chamado de **unificador mais geral** se, para qualquer outro unificador $S$, existe uma substituição $S'$ tal que $S' \circ S_g = S$.

### Implementação (Haskell)
Definição dos dados:
```haskell
data SimpleType = TVar Id
                | TArr SimpleType SimpleType
                  deriving (Eq, Show)
                  
data Expr = Var Id
          | App Expr Expr
          | Lam Id Expr
            deriving (Eq, Show)
```

Inferência:
```haskell
tiExpr g (Var i) = return (tiContext g i, [])

tiExpr g (App e e') = do
    (t, s1) <- tiExpr g e
    (t', s2) <- tiExpr g e'
    b <- freshVar
    let s3 = unify (apply s2 t) (t' --> b)
    return (apply s3 b, s3 @@ s2 @@ s1)

tiExpr g (Lam i e) = do
    b <- freshVar
    (t, s) <- tiExpr (g /+/ [i:>:b]) e
    return (apply s (b --> t), s)
```

## Tipos Estruturados

### Tipo Produto (Product Type, Record)
O produto de dois tipos consiste em um par ordenado de valores, sendo cada valor do tipo especificado. Pode-se generalizar como o produto de um conjunto finito de $n$ tipos ($n \ge 0$). O tipo *unit* (tipo unitário) é o produto nulo ($\Gamma \vdash \langle\rangle : unit$).

- **(PAIR):**
  $$ \frac{\Gamma \vdash e : \tau \quad \Gamma \vdash e' : \tau'}{\Gamma \vdash e \times e' : \tau \times \tau'} $$
- **(PROJ 1 e 2):**
  $$ \frac{\Gamma \vdash e \times e' : \tau \times \tau'}{\Gamma \vdash \pi_1(e \times e') : \tau} \quad \frac{\Gamma \vdash e \times e' : \tau \times \tau'}{\Gamma \vdash \pi_2(e \times e') : \tau'} $$

### Tipo União Disjunta (Disjoint Union, Sum Type)
Oferece uma escolha entre dois elementos de tipos possivelmente distintos. Cada tipo é marcado com uma etiqueta que permite a seleção por casamento de padrões (pattern match).

- **(SUM):**
  $$ \frac{\Gamma \vdash e : \tau}{\Gamma \vdash e + e' : \tau + \tau'} \quad \frac{\Gamma \vdash e' : \tau'}{\Gamma \vdash e + e' : \tau + \tau'} $$
- **(CASE):**
  $$ \frac{\Gamma \vdash e : \tau_1 + \tau_2 \quad \Gamma, x_1 : \tau_1 \vdash e_1 : \tau \quad \Gamma, x_2 : \tau_2 \vdash e_2 : \tau}{\Gamma \vdash \text{case } e \text{ of } \{x_1 \Rightarrow e_1 \mid x_2 \Rightarrow e_2\} : \tau} $$

### Booleanos
Um exemplo de união disjunta é o tipo booleano:
$$ \Gamma \vdash True : Bool \quad \Gamma \vdash False : Bool $$

- **(IF):**
  $$ \frac{\Gamma \vdash e : Bool \quad \Gamma \vdash e_1 : \tau \quad \Gamma \vdash e_2 : \tau}{\Gamma \vdash \text{if } e \text{ then } e_1 \text{ else } e_2 : \tau} $$

### Tipos Recursivos
Para representar tipos recursivos usa-se um operador de ponto fixo de tipos. A expressão de tipo $\mu\alpha.\tau$ denota o isomorfismo dos tipos que satisfazem a equação $\mu\alpha.\tau \cong \{\alpha \mapsto \mu\alpha.\tau\}\tau$.

Por exemplo, uma lista de inteiros pode ser definida como: $\mu\alpha.\langle\rangle + (Int \times \alpha)$. Isso admite infinitas substituições.

Esse isomorfismo é definido por regras de conversão:
- **(FOLD):**
  $$ \frac{\Gamma \vdash e : \{\alpha \mapsto \mu\alpha.\tau\}\tau}{\Gamma \vdash \text{fold } e : \mu\alpha.\tau} $$
- **(UNFOLD):**
  $$ \frac{\Gamma \vdash e : \mu\alpha.\tau}{\Gamma \vdash \text{unfold } e : \{\alpha \mapsto \mu\alpha.\tau\}\tau} $$

## Correspondência Curry-Howard
Demonstra uma correspondência direta entre tipos e teoremas. Uma função é uma prova, e o tipo de uma função é a fórmula provada. Essa correspondência é demonstrada utilizando a lógica intuicionista.

### Lógica Clássica vs. Intuicionista
**Lógica Clássica** tem três princípios fundamentais:
1. Reflexividade: $\phi \vdash \phi$
2. Terceiro-excluído: $\vdash \phi \vee \neg\phi$
3. Não-Contradição: $\vdash \neg(\phi \wedge \neg\phi)$

**Lógica Intuicionista** é um sistema mais fraco. Algo somente é verdade caso exista uma prova construtiva (provas por absurdo não são permitidas e o terceiro-excluído não é válido, pois seria necessária uma prova da validade ou falsidade para toda fórmula proposicional).
A negação $\neg\phi$ é definida como a obtenção do falso caso $\phi$ for vista como verdade: $\neg\phi \equiv \phi \to \bot$.

**Fórmulas Não Deriváveis na Lógica Intuicionista:**
- $\phi \vee \neg\phi$
- $\neg\neg\phi \to \phi$
- $(\neg\psi \to \neg\phi) \to (\phi \to \psi)$
- $((\phi \to \psi) \to \phi) \to \phi$
- $\neg(\phi \wedge \psi) \to (\neg\phi \vee \neg\psi)$

### A Correspondência

| Lógica Intuicionista | Tipagem ($\lambda$-Cálculo) | Regra Correspondente |
|----------------------|-----------------------------|----------------------|
| $\Gamma, \phi \vdash \phi$ (Ax) | $\Gamma, x : \tau \vdash x : \tau$ | (VAR) |
| $\frac{\Gamma \vdash \phi \to \psi \quad \Gamma \vdash \phi}{\Gamma \vdash \psi}$ ($\to$E) | $\frac{\Gamma \vdash e : \tau \to \tau' \quad \Gamma \vdash e' : \tau}{\Gamma \vdash e~e' : \tau'}$ | (APP) |
| $\frac{\Gamma, \phi \vdash \psi}{\Gamma \vdash \phi \to \psi}$ ($\to$I) | $\frac{\Gamma, x : \tau' \vdash e : \tau}{\Gamma \vdash \lambda x.e : \tau' \to \tau}$ | (ABS) |
| $\frac{\Gamma \vdash \phi \quad \Gamma \vdash \psi}{\Gamma \vdash \phi \wedge \psi}$ ($\wedge$I) | $\frac{\Gamma \vdash e : \tau \quad \Gamma \vdash e' : \tau'}{\Gamma \vdash e \times e' : \tau \times \tau'}$ | (PROD) |
| $\frac{\Gamma \vdash \phi \wedge \psi}{\Gamma \vdash \phi}$ ($\wedge$E) | $\frac{\Gamma \vdash e \times e' : \tau \times \tau'}{\Gamma \vdash \pi_1(e \times e') : \tau}$ | (PROJ 1) |
| $\frac{\Gamma \vdash \phi}{\Gamma \vdash \phi \vee \psi}$ ($\vee$I) | $\frac{\Gamma \vdash e : \tau}{\Gamma \vdash e + e' : \tau + \tau'}$ | (SUM) |
| $\frac{\Gamma, \phi \vdash \rho \quad \Gamma, \psi \vdash \rho \quad \Gamma \vdash \phi \vee \psi}{\Gamma \vdash \rho}$ ($\vee$E) | $\frac{\Gamma \vdash e : \tau_1 + \tau_2 \quad \Gamma, x_1 : \tau_1 \vdash e_1 : \tau \quad \Gamma, x_2 : \tau_2 \vdash e_2 : \tau}{\Gamma \vdash \text{case } e \dots}$ | (CASE) |

## Sistema Hindley-Milner
No $\lambda$-cálculo simplesmente tipado os tipos são monomórficos. No sistema Hindley-Milner, são introduzidos **tipos quantificados** para o suporte ao polimorfismo paramétrico.

- **Variáveis de Tipos:** $\alpha, \beta, \gamma$
- **Tipo Simples:** $\tau ::= \alpha \mid \tau \to \tau'$
- **Tipo Polimórfico:** $\sigma ::= \tau \mid \forall\alpha.\sigma$
- **Expressões:** $e ::= x \mid \lambda x. e \mid e~e' \mid \text{let } x = e \text{ in } e'$

Podemos dizer que o tipo $\forall\beta.\tau$ é mais específico ou o mesmo que $\forall\alpha.\tau'$ ($\forall\alpha.\tau \leqslant \forall\beta.\tau'$).

Regras do Sistema:
- **(INST):** $\frac{\Gamma \vdash e : \sigma \quad (\sigma \leqslant \sigma')}{\Gamma \vdash e : \sigma'}$
- **(GEN):** $\frac{\Gamma \vdash e : \sigma \quad (\alpha \notin ftv(\Gamma))}{\Gamma \vdash e : \forall\alpha.\sigma}$
- **(LET):** $\frac{\Gamma \vdash e : \sigma \quad \Gamma, x : \sigma \vdash e' : \tau}{\Gamma \vdash \text{let } x = e \text{ in } e' : \tau}$

### Algoritmo W
O Algoritmo W realiza a inferência do tipo mais geral em Hindley-Milner.
- **Consistência (Soundness):** Se $W(\Gamma, e)$ retorna $(\tau, S)$, então $\Gamma \vdash e : \tau$.
- **Completude (Completeness):** Se $\Gamma \vdash e : \tau'$, então $W(\Gamma, e) = (\tau, S)$ tal que para qualquer substituição $S'$, $\tau \leqslant S'\tau'$.

## Sistema F
Também chamado de **Cálculo Lambda Polimórfico**, foi proposto por Jean-Yves Girard (1972) e John C. Reynolds (1974). É uma linguagem que ilustra o polimorfismo de maneira explícita (o tipo é um parâmetro). Diferente de Hindley-Milner, onde o polimorfismo é implícito.

- **Tipos:** $\tau ::= \alpha \mid \tau \to \tau' \mid \forall\alpha.\tau$
- **Expressões:** $e ::= x \mid \lambda x:\tau.e \mid e_1~e_2 \mid \Lambda\alpha.e \mid e[\tau]$

Um termo $\Lambda\alpha.e$ denota uma expressão $e$ que recebe um tipo $\alpha$ como parâmetro. A aplicação de tipo $e[\tau]$ corresponde ao chamado passando o tipo real. Termos no Sistema F são fortemente normalizáveis (não é possível definir um combinador de ponto fixo com termos fechados).

Exemplos:
- Identidade polimórfica: $\Lambda\alpha.\lambda x:\alpha.x$

Regras Exclusivas do Sistema F:
- **(TABS):** $\frac{\Gamma \vdash e : \tau}{\Gamma \vdash \Lambda\alpha.e : \forall\alpha.\tau}$
- **(TAPP):** $\frac{\Gamma \vdash e : \forall\alpha.\tau}{\Gamma \vdash e[\tau'] : \{\alpha \mapsto \tau'\}\tau}$

### Sistema F e Tipos de Dados Abstratos
Um tipo abstrato fornece uma interface que oculta a implementação. No Sistema F, isso é feito através do quantificador existencial $\exists\alpha.\tau$.

Novas expressões:
- $\text{pack } \tau' \text{ with } e \text{ as } \exists\alpha.\tau$ (Implementação)
- $\text{open } e \text{ as } x:\tau \text{ in } e'$ (Uso)

Regras:
- **(PACK):** $\frac{\Gamma \vdash e : \{\alpha \mapsto \tau'\}\tau}{\Gamma \vdash \text{pack } \tau' \text{ with } e \text{ as } \exists\alpha.\tau : \exists\alpha.\tau}$
- **(OPEN):** $\frac{\Gamma \vdash e : \exists\alpha.\tau \quad \Gamma, x : \tau \vdash e' : \tau'}{\Gamma \vdash \text{open } e \text{ as } x : \tau \text{ in } e' : \tau'}$

### Codificação de Church no Sistema F
Podemos representar booleanos e numerais naturais introduzindo os tipos:

**Booleanos:**
$CBool = \forall\alpha.\alpha \to \alpha \to \alpha$
- $true = \Lambda\alpha.\lambda v:\alpha.\lambda f:\alpha.v$
- $false = \Lambda\alpha.\lambda v:\alpha.\lambda f:\alpha.f$

**Naturais:**
$CNat = \forall\alpha.(\alpha \to \alpha) \to \alpha \to \alpha$
- $zero = \Lambda\alpha.\lambda s:\alpha \to \alpha.\lambda z:\alpha.z$
- $one = \Lambda\alpha.\lambda s:\alpha \to \alpha.\lambda z:\alpha.s(z)$

## Sistema F$\omega$
O Sistema F permite abstrair termos e tipos, mas não permite construir construtores de tipos parametrizados puros (como um tipo "Par" ou "Lista" que requeira argumentos de tipo para se tornar um tipo propriamente dito). O **Sistema F$\omega$** eleva isso introduzindo operadores de tipo.

### Kind (Aridade de Tipos)
Podemos considerar tipos polimórficos como construtores de tipos. Um tipo que não exige parâmetros tem aridade 0 e o seu Kind é denotado por $\star$ (proper type).
$k ::= \star \mid k \Rightarrow k$

Exemplos de Kinds:
- `Bool :: ` $\star$
- `List :: ` $\star \Rightarrow \star$
- `Either :: ` $\star \Rightarrow \star \Rightarrow \star$

A sintaxe de tipos e expressões agora inclui abstração e aplicação no nível dos tipos:
- **Tipos:** $\tau ::= \dots \mid \Lambda\alpha::k.\tau \mid \tau~\tau'$
- **Expressões:** $e ::= \dots \mid \Lambda\alpha::k.e \mid e[\tau]$

### Equivalência Estrutural
Como um tipo pode ser escrito de várias formas, torna-se necessário definir a equivalência:
$$(\Lambda\alpha::k.\tau)~\tau' \equiv \{\alpha \mapsto \tau'\}\tau$$
E a regra de igualdade de tipos:
- **(EQ):** $\frac{\Gamma \vdash e : \tau \quad \tau \equiv \tau' \quad \Gamma \vdash \tau' :: \star}{\Gamma \vdash e : \tau'}$

Exemplo prático no Sistema F$\omega$:
$Pair = \Lambda\beta::\star.\Lambda\gamma::\star.\forall\alpha.(\beta \to \gamma \to \alpha) \to \alpha$
