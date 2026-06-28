# Álgebra de Conjuntos

## O que é uma Álgebra?

O termo **álgebra** refere-se a cálculos. Um exemplo familiar são os números reais com as operações aritméticas (adição, multiplicação, etc.).

A Álgebra de Conjuntos é, inclusive, uma denominação alternativa para Matemática Discreta.

O conceito formal de álgebra será visto mais adiante. Informalmente, trata-se de **operações definidas sobre um conjunto**.

---

## Álgebra de Conjuntos

As operações da Álgebra de Conjuntos são definidas sobre **todos os conjuntos** e se dividem em:

- **Não Reversíveis:** união, interseção
- **Reversíveis:** complemento, conjunto das partes, produto cartesiano, união disjunta

Dois conceitos importantes no estudo:

- **Diagramas de Venn:** representação gráfica dos conjuntos e suas operações
- **Paradoxo de Russell:** problema gerado pela auto-referência em conjuntos

---

## Lógica × Álgebra de Conjuntos

Existe uma correspondência direta entre os conectivos lógicos e as operações sobre conjuntos:

| Conectivo Lógico | Operação sobre Conjuntos |
| :---: | :---: |
| negação ($\lnot$) | complemento ($\overline{A}$) |
| disjunção ($\lor$) | união ($\cup$) |
| conjunção ($\land$) | interseção ($\cap$) |

| Relação Lógica | Relação sobre Conjuntos |
| :---: | :---: |
| implicação ($\rightarrow$) | contingência ($\subseteq$) |
| equivalência ($\leftrightarrow$) | igualdade ($=$) |

---

## Diagramas de Venn

Os Diagramas de Venn são largamente conhecidos e utilizados. Utilizam **figuras geométricas no plano** como linguagem diagramática para:

- Auxiliar o entendimento de definições
- Facilitar o desenvolvimento de raciocínios
- Permitir a identificação e compreensão rápida de componentes e relacionamentos

### Convenções de Representação

- O **conjunto universo $U$** é representado por um retângulo
- Os demais conjuntos são representados por elipses, círculos, etc.
- Em $C \subseteq U$, o conjunto $C$ é destacado visualmente

---

## Transitividade da Contingência

> [!IMPORTANT]
> A noção de subconjunto é **transitiva**.

**Teorema (Transitividade da Contingência):**

Suponha $A$, $B$ e $C$ conjuntos. Se $A \subseteq B$ e $B \subseteq C$, então $A \subseteq C$.

**Demonstração:**

Relembrando que $X \subseteq Y \iff \forall x \in X,\, x \in Y$.

Suponha que $A$, $B$ e $C$ são conjuntos quaisquer com $A \subseteq B$ e $B \subseteq C$.

Seja $a \in A$. Então, pela definição de subconjunto e $A \subseteq B$:

$$a \in A \implies a \in B$$

E pela definição de subconjunto e $B \subseteq C$:

$$a \in B \implies a \in C$$

Portanto, para qualquer $a \in A$, temos $a \in C$. Logo $A \subseteq C$. $\blacksquare$

---

## Paradoxo de Russell

### Conjunto Ordinário

Revisando o conceito de conjunto: uma coleção de zero ou mais elementos distintos, sem qualquer ordem associada.

Como existem conjuntos de conjuntos, surge a questão: **um conjunto pode ser elemento de si mesmo?**

**Definição (Conjunto Ordinário):**
Um conjunto que **não pertence a si mesmo**.

### Formulação do Paradoxo

Considere o conjunto:

$$S = \{A \mid A \text{ é um conjunto ordinário}\}$$

Esse é o conjunto de todos os conjuntos que não são elementos de si mesmos. A definição de $S$ determina uma contradição — o **Paradoxo de Russell**.

**Teorema (Paradoxo de Russell):**

$S = \{A \mid A \text{ é um conjunto ordinário}\}$ **não é um conjunto.**

**Demonstração:**

Suponha que $S$ é conjunto. $S$ é um elemento de si mesmo?

**Caso 1:** Suponha que $S \in S$.

$$S \in S \implies \text{[pela definição de conj. ordinário]} \implies S \text{ não é um conjunto ordinário} \implies \text{[pela definição de } S\text{]} \implies S \notin S$$

**Caso 2:** Suponha que $S \notin S$.

$$S \notin S \implies \text{[pela definição de conj. ordinário]} \implies S \text{ é um conjunto ordinário} \implies \text{[pela definição de } S\text{]} \implies S \in S$$

Absurdo! Logo $S$ não é conjunto. $\blacksquare$

### Consequência do Paradoxo

A notação por compreensão permite definir algo que não é conjunto. Como $S$ não é conjunto, concluímos que:

> **Não existe o conjunto de todos os conjuntos.**
>
> Nem toda coleção de elementos constitui um conjunto.

---

## Operações Não Reversíveis

As operações mais comuns na Álgebra de Conjuntos são a **União** e a **Interseção** — ambas são **não reversíveis**, pois a partir do resultado não é sempre possível recuperar os operandos originais.

### Definição de União

**Definição (União de Conjuntos):**
Dados $A$ e $B$ conjuntos, a **união** de $A$ e $B$, denotada $A \cup B$, é definida por:

$$x \in A \cup B \iff x \in A \lor x \in B$$

#### Exemplos de União

Sejam os conjuntos:
- $\text{Dígitos} = \{0, 1, 2, 3, 4, 5, 6, 7, 8, 9\}$
- $\text{Vogais} = \{a, e, i, o, u\}$
- $\text{Pares} = \{0, 2, 4, 6, 8, 10, 12, 14, \ldots\}$

$$\text{Dígitos} \cup \text{Vogais} = \{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, a, e, i, o, u\}$$

$$\text{Dígitos} \cup \text{Pares} = \{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, \ldots\}$$

Outros exemplos:

- Sejam $A = \{x \in \mathbb{N} \mid x > 2\}$ e $B = \{x \in \mathbb{N} \mid x^2 = x\}$. Então $A \cup B = \{0, 1, 3, 4, 5, 6, \ldots\}$
- $\mathbb{R} \cup \mathbb{Q} = \mathbb{R}$, $\quad \mathbb{R} \cup \mathbb{I} = \mathbb{R}$, $\quad \mathbb{Q} \cup \mathbb{I} = \mathbb{R}$
- Para $U$ conjunto universo e $A \subseteq U$:

$$\emptyset \cup \emptyset = \emptyset \qquad U \cup \emptyset = U \qquad U \cup A = U \qquad U \cup U = U$$

#### Propriedades da União

| Propriedade | Lei |
| :---: | :---: |
| Elemento Neutro | $A \cup \emptyset = A = \emptyset \cup A$ |
| Idempotência | $A \cup A = A$ |
| Comutatividade | $A \cup B = B \cup A$ |
| Associatividade | $A \cup (B \cup C) = (A \cup B) \cup C$ |

**Teorema (Associatividade da União):**

Suponha que $A$, $B$ e $C$ são conjuntos quaisquer. Então:

$$A \cup (B \cup C) = (A \cup B) \cup C$$

**Demonstração:**

$$x \in A \cup (B \cup C)$$
$$\iff \text{[definição de união]}$$
$$x \in A \lor x \in (B \cup C)$$
$$\iff \text{[definição de união]}$$
$$x \in A \lor (x \in B \lor x \in C)$$
$$\iff \text{[associatividade de } \lor\text{]}$$
$$(x \in A \lor x \in B) \lor x \in C$$
$$\iff \text{[definição de união]}$$
$$x \in (A \cup B) \lor x \in C$$
$$\iff \text{[definição de união]}$$
$$x \in (A \cup B) \cup C$$

Portanto $A \cup (B \cup C) = (A \cup B) \cup C$. $\blacksquare$

---

### Definição de Interseção

**Definição (Interseção de Conjuntos):**
Dados $A$ e $B$ conjuntos, a **interseção** de $A$ e $B$, denotada $A \cap B$, é definida por:

$$x \in A \cap B \iff x \in A \land x \in B$$

#### Exemplos de Interseção

$$\text{Dígitos} \cap \text{Vogais} = \emptyset$$

$$\text{Dígitos} \cap \text{Pares} = \{0, 2, 4, 6, 8\}$$

Outros exemplos:

- $A = \{x \in \mathbb{N} \mid x > 2\}$, $B = \{x \in \mathbb{N} \mid x^2 = x\}$: $\quad A \cap B = \emptyset$
- $\mathbb{R} \cap \mathbb{Q} = \mathbb{Q}$, $\quad \mathbb{R} \cap \mathbb{I} = \mathbb{I}$, $\quad \mathbb{Q} \cap \mathbb{I} = \emptyset$
- Para $U$ conjunto universo e $A \subseteq U$:

$$\emptyset \cap \emptyset = \emptyset \qquad U \cap \emptyset = \emptyset \qquad U \cap A = A \qquad U \cap U = U$$

#### Propriedades da Interseção

| Propriedade | Lei |
| :---: | :---: |
| Elemento Neutro | $A \cap U = A = U \cap A$ |
| Idempotência | $A \cap A = A$ |
| Comutatividade | $A \cap B = B \cap A$ |
| Associatividade | $A \cap (B \cap C) = (A \cap B) \cap C$ |

#### Distributividade entre União e Interseção

$$A \cap (B \cup C) = (A \cap B) \cup (A \cap C)$$

$$A \cup (B \cap C) = (A \cup B) \cap (A \cup C)$$

**Teorema (Distributividade da Interseção sobre a União):**

Suponha que $A$, $B$ e $C$ são conjuntos quaisquer. Então:

$$A \cap (B \cup C) = (A \cap B) \cup (A \cap C)$$

**Demonstração:**

$$x \in A \cap (B \cup C)$$
$$\iff \text{[definição de interseção]}$$
$$x \in A \land x \in (B \cup C)$$
$$\iff \text{[definição de união]}$$
$$x \in A \land (x \in B \lor x \in C)$$
$$\iff \text{[tautologia: distributividade de } \land \text{ sobre } \lor\text{]}$$
$$(x \in A \land x \in B) \lor (x \in A \land x \in C)$$
$$\iff \text{[definição de interseção]}$$
$$x \in (A \cap B) \lor x \in (A \cap C)$$
$$\iff \text{[definição de união]}$$
$$x \in (A \cap B) \cup (A \cap C)$$

Portanto $A \cap (B \cup C) = (A \cap B) \cup (A \cap C)$. $\blacksquare$

---

## Operações Reversíveis

Uma **operação reversível** é aquela a partir da qual é possível recuperar os operandos originais dado o resultado.

As operações reversíveis na Álgebra de Conjuntos são:

- Complemento
- Conjunto das Partes
- Produto Cartesiano
- União Disjunta

### Complemento

**Definição (Complemento de um Conjunto):**
Dado $A$ um conjunto qualquer, o seu **complemento**, denotado $\overline{A}$, é tal que:

$$x \in \overline{A} \iff x \notin A$$

#### Exemplos de Complemento

- $U = \text{Dígitos} = \{0,1,2,3,4,5,6,7,8,9\}$, $A = \{0,1,2\}$:

$$\overline{A} = \{3, 4, 5, 6, 7, 8, 9\}$$

- $A = \{0,1,2\}$, $U = \mathbb{N}$:

$$\overline{A} = \{x \in \mathbb{N} \mid x > 2\}$$

- $\mathbb{R}$ como conjunto universo: $\quad \overline{\mathbb{Q}} = \mathbb{I}$, $\quad \overline{\mathbb{I}} = \mathbb{Q}$

- Para $U$ conjunto universo e $A \subseteq U$:

$$\overline{\emptyset} = U \qquad \overline{U} = \emptyset \qquad A \cup \overline{A} = U \qquad A \cap \overline{A} = \emptyset$$

#### Propriedades com o Complemento

| Propriedade | Lei |
| :---: | :---: |
| Duplo Complemento | $\overline{\overline{A}} = A$ |
| De Morgan | $\overline{A \cup B} = \overline{A} \cap \overline{B}$ |
| De Morgan | $\overline{A \cap B} = \overline{A} \cup \overline{B}$ |

---

### Conjunto das Partes

**Definição (Conjunto das Partes):**
Dado $A$ um conjunto qualquer, o seu **conjunto das partes**, denotado $2^A$ ou $\mathcal{P}(A)$, é o conjunto de todos os subconjuntos de $A$:

$$2^A = \{X \mid X \subseteq A\}$$

#### Exemplos

Dados $A = \{a\}$, $B = \{a, b\}$, $C = \{a, b, c\}$:

- $2^\emptyset = \{\emptyset\}$
- $2^A = \{\emptyset, \{a\}\}$
- $2^B = \{\emptyset, \{a\}, \{b\}, \{a, b\}\}$
- $2^C = \{\emptyset, \{a\}, \{b\}, \{c\}, \{a,b\}, \{a,c\}, \{b,c\}, \{a,b,c\}\}$

Dado $D = \{a, \emptyset, \{a, b\}\}$:

$$2^D = \{\emptyset,\, \{a\},\, \{\emptyset\},\, \{\{a,b\}\},\, \{a,\emptyset\},\, \{a,\{a,b\}\},\, \{\emptyset,\{a,b\}\},\, \{a,\emptyset,\{a,b\}\}\}$$

#### Número de Elementos de $2^A$

Dado $X$ um conjunto finito com $n = |X|$ elementos:

$$|2^X| = 2^n = 2^{|X|}$$

#### Reversibilidade de $2^X$

Sabendo-se quem é $2^X$, podemos recuperar $X$ pela união de todos os conjuntos que pertencem a $2^X$:

$$X = \bigcup_{A \in 2^X} A$$

**Exemplos:**

- $2^F = \{\emptyset, \{a\}, \{b\}, \{a,b\}\} \implies F = \emptyset \cup \{a\} \cup \{b\} \cup \{a,b\} = \{a,b\}$
- $2^G = \{\emptyset, \{\clubsuit\}, \{\diamondsuit\}, \{\heartsuit\}, \{\clubsuit,\diamondsuit\}, \{\clubsuit,\heartsuit\}, \{\heartsuit,\diamondsuit\}, \{\clubsuit,\diamondsuit,\heartsuit\}\} \implies G = \{\clubsuit, \diamondsuit, \heartsuit\}$

---

### Produto Cartesiano

#### Noção de Sequência Finita

Uma **sequência de $n$ componentes** é chamada de **$n$-upla ordenada** — $n$ objetos dispostos em uma ordem fixa.

- **Par ordenado:** $\langle x, y \rangle$ ou $(x, y)$
- **$n$-upla ordenada:** $\langle x_1, x_2, \ldots, x_n \rangle$ ou $(x_1, x_2, \ldots, x_n)$

> [!IMPORTANT]
> Não confundir $\langle x_1, x_2, \ldots, x_n \rangle$ (sequência ordenada) com $\{x_1, x_2, \ldots, x_n\}$ (conjunto).
> Em particular: $\langle x, y \rangle \neq \langle y, x \rangle$

**Definição (Produto Cartesiano):**
Sejam $A$ e $B$ conjuntos. O **produto cartesiano** $A \times B$ é o conjunto:

$$A \times B = \{\langle a, b \rangle \mid a \in A \land b \in B\}$$

**Notação:** $A \times A = A^2$

#### Exemplos de Produto Cartesiano

Para $A = \{a\}$, $B = \{a, b\}$, $C = \{0, 1, 2\}$:

$$A \times B = \{\langle a, a \rangle, \langle a, b \rangle\}$$

$$B \times C = \{\langle a,0\rangle, \langle a,1\rangle, \langle a,2\rangle, \langle b,0\rangle, \langle b,1\rangle, \langle b,2\rangle\}$$

$$C \times B = \{\langle 0,a\rangle, \langle 0,b\rangle, \langle 1,a\rangle, \langle 1,b\rangle, \langle 2,a\rangle, \langle 2,b\rangle\}$$

$$A^2 = \{\langle a, a \rangle\} \qquad A \times \mathbb{N} = \{\langle a,0\rangle, \langle a,1\rangle, \langle a,2\rangle, \ldots\}$$

> [!NOTE]
> O Produto Cartesiano é **não associativo**:
>
> $A \times (B \times C) \neq (A \times B) \times C$
>
> pois $\langle a, \langle a, 0 \rangle \rangle \neq \langle \langle a, a \rangle, 0 \rangle$.

Para qualquer conjunto $A$:

$$\emptyset \times A = \emptyset \qquad A \times \emptyset = \emptyset \qquad \emptyset^2 = \emptyset$$

#### Distributividade do Produto Cartesiano

$$A \times (B \cup C) = (A \times B) \cup (A \times C)$$

$$A \times (B \cap C) = (A \times B) \cap (A \times C)$$

#### Reversibilidade do Produto Cartesiano

Nem sempre é possível. Se o resultado for o conjunto vazio, não é possível definir todos os operandos originais.

Caso $A \times B \neq \emptyset$:

$$A = \{x \mid \langle x, y \rangle \in A \times B\} \qquad B = \{y \mid \langle x, y \rangle \in A \times B\}$$

**Exemplos:**

- $\{\langle a,a\rangle, \langle a,b\rangle\}$ — Operandos: $\{a\}$ e $\{a,b\}$
- $\{\langle a,a\rangle, \langle a,b\rangle, \langle b,a\rangle, \langle b,b\rangle\}$ — Operandos: $\{a,b\}$ e $\{a,b\}$
- $\{\langle a,0\rangle, \langle a,1\rangle, \langle a,2\rangle, \ldots\}$ — Operandos: $\{a\}$ e $\mathbb{N}$

---

### União Disjunta

#### Motivação

Considere as famílias Silva e Souza:

- $\text{Silva} = \{\text{João, Maria, José}\}$
- $\text{Souza} = \{\text{Pedro, Ana, José}\}$

$$\text{Silva} \cup \text{Souza} = \{\text{João, Maria, Pedro, Ana, José}\}$$

O "José" aparece apenas uma vez, mas **José Silva não é a mesma pessoa que José Souza**. A união comum não reflete essa distinção. Por isso, surge a **União Disjunta**.

#### Definição

A União Disjunta:
- Distingue elementos com mesma identificação
- Considera os operandos como conjuntos disjuntos
- Garante que não existem elementos em comum
- Associa a cada elemento uma identificação da origem (um tipo de "sobrenome"): $\langle \text{elemento},\, \text{identificação da origem} \rangle$

**Definição (União Disjunta):**
Dados $A$ e $B$ conjuntos, sua **união disjunta**, $A \uplus B$, é o conjunto:

$$A \uplus B = \{\langle a, 0 \rangle \mid a \in A\} \cup \{\langle b, 1 \rangle \mid b \in B\}$$

Notação alternativa: $A \uplus B = \{a_A \mid a \in A\} \cup \{b_B \mid b \in B\}$

> [!NOTE]
> Há diversas formas de denotar $A \uplus B$. O importante é distinguir o conjunto originário de cada elemento.

#### Exemplos de União Disjunta

$$\text{Silva} \uplus \text{Souza} = \{\langle \text{João},\text{Silva}\rangle, \langle \text{Maria},\text{Silva}\rangle, \langle \text{José},\text{Silva}\rangle, \langle \text{Ana},\text{Souza}\rangle, \langle \text{Pedro},\text{Souza}\rangle, \langle \text{José},\text{Souza}\rangle\}$$

Dados $D = \{0,1,...,9\}$, $V = \{a,e,i,o,u\}$, $P = \{0,2,4,6,8,10,...\}$:

$$D \uplus V = \{0_D, 1_D, 2_D, 3_D, 4_D, 5_D, 6_D, 7_D, 8_D, 9_D,\, a_V, e_V, i_V, o_V, u_V\}$$

$$D \uplus P = \{0_D, 1_D, 2_D, \ldots, 9_D,\, 0_P, 2_P, 4_P, \ldots\}$$

Para $A = \{a, b, c\}$:

$$\emptyset \uplus \emptyset = \emptyset$$

$$A \uplus \emptyset = \{\langle a, 0 \rangle, \langle b, 0 \rangle, \langle c, 0 \rangle\}$$

$$A \uplus A = \{\langle a,0\rangle, \langle b,0\rangle, \langle c,0\rangle, \langle a,1\rangle, \langle b,1\rangle, \langle c,1\rangle\}$$

#### Reversibilidade da União Disjunta

Dado $A \uplus B$, é sempre possível recuperar os operandos:

$$A = \{x \mid \langle x, 0 \rangle \in A \uplus B\} \qquad B = \{x \mid \langle x, 1 \rangle \in A \uplus B\}$$

**Exemplos:**

- $\{\langle a,0\rangle, \langle b,0\rangle, \langle a,1\rangle, \langle b,1\rangle, \langle c,1\rangle\}$ — Operandos: $\{a,b\}$ e $\{a,b,c\}$
- $\emptyset$ — Operandos: $\emptyset$ e $\emptyset$
- $\{\langle a,1\rangle, \langle b,1\rangle\}$ — Operandos: $\emptyset$ e $\{a,b\}$

---

## Diferença de Conjuntos

Existe ainda uma **operação não reversível** importante:

**Definição (Diferença):**
Dados $A$ e $B$ conjuntos, a **diferença** $A - B$ é:

$$A - B = \{x \mid x \in A \land x \notin B\} = A \cap \overline{B}$$

#### Exemplos de Diferença

$$\text{Dígitos} - \text{Vogais} = \text{Dígitos} \qquad \text{Dígitos} - \text{Pares} = \{1, 3, 5, 7, 9\}$$

- $A = \{x \in \mathbb{N} \mid x > 2\}$, $B = \{x \in \mathbb{N} \mid x^2 = x\}$:
  - $A - B = \{3, 4, 5, 6, \ldots\}$
  - $B - A = \{0, 1\}$

- $\mathbb{R} - \mathbb{Q} = \mathbb{I}$, $\quad \mathbb{R} - \mathbb{I} = \mathbb{Q}$, $\quad \mathbb{Q} - \mathbb{I} = \mathbb{Q}$

- Para $U$ conjunto universo e $A \subseteq U$:

$$\emptyset - \emptyset = \emptyset \qquad U - \emptyset = U \qquad U - A = \overline{A} \qquad U - U = \emptyset$$
