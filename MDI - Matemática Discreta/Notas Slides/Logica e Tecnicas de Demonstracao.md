# Noções de Lógica e Técnicas de Demonstração

## Por que Matemática Discreta?

A Matemática Discreta surge da necessidade de lidar com as **limitações finitas** de um computador:

- Tamanho da memória
- Número de instruções que pode executar
- Número de símbolos que pode tratar

Por isso é necessário o estudo de estruturas baseadas em **conjuntos finitos** — porém isso não implica a pré-fixação de tamanhos máximos (por exemplo: armazenamento).

Conjuntos de recursos computacionais são **contáveis** ou **discretos** (em oposição ao termo *contínuo*) — podem ser enumerados, pois não há elemento entre quaisquer outros dois.

**Exemplo:** $\mathbb{N}$ *versus* $\mathbb{R}$

### Matemática Discreta vs. Matemática do Contínuo

O estudo é baseado em **Conjuntos Contáveis**, finitos ou infinitos — diferentemente da Matemática do Contínuo, que inclui:

- Cálculo Diferencial e Integral
- Análise Matemática

---

## Conjuntos

Os tópicos fundamentais de conjuntos cobertos nesta disciplina incluem:

- **Conceito** de conjunto
- **Denotação:** por extensão e por compreensão
- **Pertinência** de elementos
- **Contingência** (subconjuntos)
- Conjuntos finitos e infinitos
- Conjunto vazio e conjunto universo

---

## Por que Lógica?

**Teoremas** podem ser vistos como problemas a serem implementados — a prova ou demonstração é a solução computacional (se não for por absurdo).

**Programação** segue os operadores lógicos, que obedecem à **lógica proposicional clássica**.

---

## Lógica Proposicional Clássica

### Proposição

Uma **proposição** é uma sentença, frase ou construção à qual se pode atribuir um juízo de valor. É o "átomo" da lógica — assume valor **Verdadeiro** ou **Falso**.

### Conectivos

Os **conectivos** operam sobre proposições e constroem fórmulas mais complexas:

- **e** (conjunção) $\land$
- **ou** (disjunção) $\lor$
- **não** (negação) $\lnot$
- **se-então** (condicional) $\rightarrow$

---

## Tabelas-Verdade

### Conjunção e Disjunção

| $p$ | $q$ | $p \land q$ | $p \lor q$ |
| :---: | :---: | :---: | :---: |
| V | V | V | V |
| V | F | F | V |
| F | V | F | V |
| F | F | F | F |

### Negação

| $p$ | $\lnot p$ |
| :---: | :---: |
| V | F |
| F | V |

### Condicional

| $p$ | $q$ | $p \rightarrow q$ |
| :---: | :---: | :---: |
| V | V | V |
| V | F | F |
| F | V | V |
| F | F | V |

> [!IMPORTANT]
> O condicional $p \rightarrow q$ é **falso** somente quando a hipótese $p$ é verdadeira e a tese $q$ é falsa. Em todos os outros casos, o condicional é verdadeiro.

---

## Tautologia e Contradição

### Tautologia

Uma **tautologia** é uma fórmula que é **sempre** verdadeira, para **qualquer** combinação de valores das proposições que a compõem.

### Contradição

Uma **contradição** é uma fórmula que é **sempre** falsa, para **qualquer** combinação de valores das proposições que a compõem.

---

## Quantificadores

### Passagem da Lógica Proposicional para a Lógica de Primeira Ordem

Seja uma proposição sobre um conjunto de valores, como

$$n > 1$$

Dependendo do valor de $n$, o valor-verdade possivelmente muda. Para cada valor de $n$, uma proposição diferente é considerada — denotada por $p(n)$.

### Quantificador Universal

Expressa a ideia de "**para todo** $x$":

$$\forall x \in U,\; p(x)$$

### Quantificador Existencial

Expressa a ideia de "**existe** $x$":

$$\exists x \in U,\; p(x)$$

### Existência vs. Unicidade

"Existe somente um" e "Existe e é único" são conceitos distintos, simbolizados por $\exists!$:

$$\exists!\, x\; p(x) \iff (\exists x\; p(x)) \land (\forall x \forall y\; p(x) \land p(y) \rightarrow x = y)$$

---

## Teoremas

Um **teorema** é uma sentença do tipo

$$p \rightarrow q$$

que deve ser **demonstrada**.

- $p$ — hipótese
- $q$ — tese

Uma **demonstração** é uma sequência de sentenças que seguem a partir da hipótese e que devem ser justificadas com passos lógicos, definições ou teoremas anteriormente demonstrados.

---

## Verdadeiro ou Falso?

A partir de uma afirmação qualquer, por exemplo,

$$\forall n \in \mathbb{N},\; n! \leq n^3$$

Como provar se é verdadeira ou falsa?

- **Análise** da afirmação
- **Demonstração** caso seja verdadeira
- **Contra-exemplo** caso seja falsa

---

## Algumas Dicas Iniciais

- Um teorema da forma $p \leftrightarrow q$ é usualmente provado em duas "partes":
  - "Indo": $p \rightarrow q$
  - E "voltando": $q \rightarrow p$

- Exemplo geralmente **não** é prova. Exceção: conjectura é a existência de um elemento que respeite alguma propriedade.

- No caso de um número **finito e pequeno** de elementos, pode-se mostrar o que se quer elemento a elemento. **(Prova por exaustão)**

---

## Técnicas de Demonstração

### Prova Direta

A **prova direta** pressupõe que a hipótese $p$ é verdadeira e segue até deduzir a tese $q$ também como verdadeira. Partindo-se de $p$, chega-se a $q$.

**Exemplo:**

> *a soma de dois números pares é par*

Reescrita na forma $p \rightarrow q$:

> se $m$ e $n$ são dois números pares quaisquer, então $m + n$ é par

---

### Prova por Contraposição

Baseia-se no resultado lógico equivalente:

$$p \rightarrow q \iff \lnot q \rightarrow \lnot p$$

Verificação via tabela-verdade:

| $p$ | $q$ | $p \rightarrow q$ | $\lnot p$ | $\lnot q$ | $\lnot q \rightarrow \lnot p$ |
| :---: | :---: | :---: | :---: | :---: | :---: |
| V | V | V | F | F | V |
| V | F | F | F | V | F |
| F | V | V | V | F | V |
| F | F | V | V | V | V |

Para provar $p \rightarrow q$, faz-se a **prova direta** de $\lnot q \rightarrow \lnot p$.

**Exemplo:**

$$n! > (n+1) \rightarrow n > 2$$

---

### Redução ao Absurdo

Baseia-se no resultado lógico equivalente:

$$p \rightarrow q \iff (p \land \lnot q) \rightarrow F$$

| $p$ | $q$ | $p \rightarrow q$ |
| :---: | :---: | :---: |
| V | V | V |
| **V** | **F** | **F** |
| F | V | V |
| F | F | V |

Para provar $p \rightarrow q$, faz-se a **prova direta** de $(p \land \lnot q) \rightarrow F$:

- supõe-se a hipótese: $p$
- supõe-se a negação da tese: $\lnot q$
- chega-se a uma *contradição*, por exemplo, $s \land \lnot s$

**Exemplo:**

> *0 é o único elemento neutro da adição em $\mathbb{N}$*

Reescrevendo na forma $p \rightarrow q$:

> se 0 é elemento neutro da adição em $\mathbb{N}$,
> então 0 é o **único** elemento neutro da adição em $\mathbb{N}$

**Demonstração por redução ao absurdo:**

Suponha que:
- 0 é um elemento neutro da adição em $\mathbb{N}$
- 0 **não** é o único elemento neutro da adição em $\mathbb{N}$

Seja $e$ um *outro* elemento neutro da adição em $\mathbb{N}$ tal que $e \neq 0$.

Como $e$ é elemento neutro da adição, temos que $0 + e = 0$.
Mas como 0 é elemento neutro da adição, temos que $0 + e = e$.
Logo $e = 0$ — **contradição** com a suposição de que $e \neq 0$. $\blacksquare$
