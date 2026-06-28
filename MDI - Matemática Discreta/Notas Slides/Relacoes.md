# Relações

## Conceito Intuitivo

A noção de **relação** em matemática é muito próxima do conceito cotidiano. Exemplos de relações:

- parentesco
- maior ou igual ($\geq$)
- igualdade ($=$)
- faz fronteira com
- pertence ($\in$)
- está contido ($\subseteq$)

Dentro da computação, os exemplos de maior destaque são os **bancos de dados relacionais** e a **Teoria dos Grafos**.

---

## Cardinalidade de Relações

As **relações binárias** relacionam dois elementos de cada vez. Seguindo o mesmo raciocínio, existem também relações ternárias, quaternárias, unárias, etc.

Relações podem ser definidas sobre coleções que não são conjuntos — por exemplo, a relação "está contido" sobre todos os conjuntos.

> [!NOTE]
> Na disciplina, o enfoque será em **relações binárias** e de pequeno porte.

---

## Conceito Formal

**Definição (Relação Binária):**
Uma **relação binária** $R$ de $A$ em $B$ é um subconjunto:

$$R \subseteq A \times B$$

**Notações:** $R \subseteq A \times B$ ou $R : A \to B$

- $A$: **domínio**, origem ou conjunto de partida
- $B$: **contradomínio**, codomínio, destino ou conjunto de chegada

Se $\langle a, b \rangle \in R$, dizemos que **$a$ se relaciona com $b$**. Notação alternativa: $aRb$.

---

## Exemplos de Relações

Sejam $A = \{a\}$, $B = \{a, b\}$ e $C = \{0, 1, 2\}$:

- $\emptyset$ é relação de $A$ em $B$ (e também de $A$ em $C$, de $B$ em $A$, de $A$ em $A$, etc.)
- $A \times B = \{\langle a, a \rangle, \langle a, b \rangle\}$ é relação com origem em $A$ e destino em $B$
- $\{\langle a, a \rangle\} \subseteq A \times B$ é a relação de igualdade
- $\langle C, < \rangle = \{\langle 0,1\rangle, \langle 0,2\rangle, \langle 1,2\rangle\}$ é a relação "menor" de $C$ em $C$
- $R : C \to B$ tal que $R = \{\langle 0, a \rangle, \langle 1, b \rangle\}$

---

## Endorrelação

Uma relação não necessariamente relaciona entidades de um mesmo conjunto — por exemplo, uma listagem de contatos do celular relaciona pessoas com números de telefone.

Quando a relação relaciona entidades de um **mesmo conjunto**, ela é especialmente importante.

**Definição (Endorrelação):**
Seja $A$ um conjunto. Uma relação $R : A \to A$ é uma **endorrelação**. Dizemos que $R$ é uma relação **em $A$**.

**Notação:** $\langle A, R \rangle$

**Exemplos de endorrelações:**

- $\langle \mathbb{N}, \leq \rangle$
- $\langle \mathbb{Z}, < \rangle$
- $\langle \mathbb{Q}, = \rangle$
- $\langle 2^A, \subseteq \rangle$
- $\langle 2^A, \subsetneq \rangle$

---

## Representações de Relações

### Diagrama de Venn (Setas)

Uma relação $R : A \to B$ pode ser representada por **ligações com setas** entre os elementos relacionados — cada par $\langle a, b \rangle \in R$ é representado por uma seta de $a$ para $b$.

**Exemplo:** Para $C = \{0, 1, 2\}$, a endorrelação $\langle C, < \rangle = \{\langle 0,1\rangle, \langle 0,2\rangle, \langle 1,2\rangle\}$ é representada por setas de $0$ para $1$, de $0$ para $2$ e de $1$ para $2$.

---

### Endorrelação como Grafo

Uma endorrelação $R : A \to A$ pode ser vista como um **grafo dirigido**:

- **Toda** endorrelação é um grafo
- Mas **nem todo** grafo é uma endorrelação

**Terminologia de Grafos Dirigidos:**

- Nodos, lugares, vértices
- Arestas, caminhos, setas

**Como representar:**

- **Nodos:** elementos de $A$
- **Arestas:** pares da relação $R$

A visão como grafo oferece uma perspectiva mais clara do relacionamento e das propriedades da relação. É especialmente conveniente para relações com poucos pares.

**Exemplos:** Sejam $A = \{a\}$, $B = \{a,b\}$, $C = \{0,1,2\}$.

- $\emptyset : A \to A$ — nenhuma aresta
- $\langle B, = \rangle$ — setas de $a$ para $a$ e de $b$ para $b$ (auto-laços)
- $\langle C, < \rangle$ — setas de $0$ para $1$, de $0$ para $2$ e de $1$ para $2$
- $R = \{\langle 0,2\rangle, \langle 2,0\rangle, \langle 2,2\rangle\}$ em $C$ — seta de $0$ para $2$, de $2$ para $0$, e auto-laço em $2$

---

### Relação como Matriz

Dados conjuntos finitos $A = \{a_1, a_2, \ldots, a_n\}$ e $B = \{b_1, b_2, \ldots, b_m\}$, uma relação $R : A \to B$ pode ser representada como uma **matriz booleana** com:

- $n$ linhas (correspondentes aos elementos de $A$)
- $m$ colunas (correspondentes aos elementos de $B$)
- $m \times n$ posições no total

A posição $(i, j)$ recebe valor $1$ se $a_i R b_j$, e valor $0$ caso contrário.

Essa representação é especialmente interessante para **implementação computacional**.

**Exemplos:** Sejam $A = \{a\}$, $B = \{a,b\}$, $C = \{0,1,2\}$.

- $\emptyset : A \to A$ — matriz $1 \times 1$ com valor $0$

$$\begin{array}{c|c}
\emptyset & a \\ \hline
a & 0
\end{array}$$

- $\langle B, = \rangle$ — matriz $2 \times 2$ identidade:

$$\begin{array}{c|cc}
= & a & b \\ \hline
a & 1 & 0 \\
b & 0 & 1
\end{array}$$

- $\langle C, < \rangle$ — matriz $3 \times 3$:

$$\begin{array}{c|ccc}
< & 0 & 1 & 2 \\ \hline
0 & 0 & 1 & 1 \\
1 & 0 & 0 & 1 \\
2 & 0 & 0 & 0
\end{array}$$

- $R = \{\langle 0,2\rangle, \langle 2,0\rangle, \langle 2,2\rangle\}$ em $C$:

$$\begin{array}{c|ccc}
R & 0 & 1 & 2 \\ \hline
0 & 0 & 0 & 1 \\
1 & 0 & 0 & 0 \\
2 & 1 & 0 & 1
\end{array}$$

---

## Relação Inversa

**Definição (Relação Inversa):**
Seja $R \subseteq A \times B$ uma relação. A **relação inversa** (ou relação dual), denotada $R^{-1}$, é:

$$R^{-1} \subseteq B \times A \quad \text{tal que} \quad R^{-1} = \{\langle b, a \rangle \mid \langle a, b \rangle \in R\}$$

A relação inversa é obtida pela **inversão (troca) das componentes** de cada par de uma relação.

### Exemplos de Relação Inversa

Sejam $A = \{a\}$, $B = \{a,b\}$, $C = \{0,1,2\}$:

- $= : A \to B$ dada por $\{\langle a,a\rangle\}$ $\implies$ $=^{-1} : B \to A$ dada por $\{\langle a,a\rangle\}$
- $\{\langle 0,a\rangle, \langle 1,b\rangle\} : C \to B$ $\implies$ $\{\langle a,0\rangle, \langle b,1\rangle\} : B \to C$
- $< : C \to C$ $\implies$ $<^{-1} = > : C \to C$

### Inversa na Representação Matricial e Gráfica

- **Matriz da relação dual:** é a **matriz transposta** (troca linhas por colunas)

> [!WARNING]
> Não confundir **matriz transposta** (da relação dual) com **matriz inversa** (da álgebra linear)!

- **Grafo da relação inversa:** troca o sentido de todas as arestas

---

## Composição de Relações

**Definição (Composição de Relações):**
Sejam $R : A \to B$ e $S : B \to C$ relações. A **composição** de $R$ e $S$, denotada $S \circ R : A \to C$, é o conjunto:

$$S \circ R = \{\langle a, c \rangle \mid \exists\, b \in B\; (aRb \land bSc)\}$$

A relação composta aplica uma relação sobre o resultado de outra.

### Exemplo de Composição

Sejam $R : A \to B$ e $S : B \to C$, logo $S \circ R : A \to C$:

- $R = \{\langle a,1\rangle, \langle b,3\rangle, \langle b,4\rangle, \langle d,5\rangle\}$
- $S = \{\langle 1,x\rangle, \langle 2,y\rangle, \langle 5,y\rangle, \langle 5,z\rangle\}$

Calculando $S \circ R$:
- $a \to 1 \to x$: $\langle a, x \rangle$
- $d \to 5 \to y$: $\langle d, y \rangle$
- $d \to 5 \to z$: $\langle d, z \rangle$
- $b \to 3$: nenhum par com $3$ em $S$
- $b \to 4$: nenhum par com $4$ em $S$

$$S \circ R = \{\langle a, x \rangle, \langle d, y \rangle, \langle d, z \rangle\}$$

---

## O que Vem a Seguir

Os próximos tópicos explorarão:

- **Propriedades de relações e endorrelações** (reflexividade, simetria, transitividade, etc.)
- **Fechos de propriedades**
- **Tipos especiais de endorrelações:** relações de equivalência e relações de ordem
