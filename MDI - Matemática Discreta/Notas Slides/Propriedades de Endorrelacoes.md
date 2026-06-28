# Propriedades de Endorrelações

## Introdução

As propriedades de endorrelações somente fazem sentido devido ao fato de a relação ter **domínio e contradomínio no mesmo conjunto**.

As principais propriedades estudadas são:
- Reflexividade
- Irreflexividade
- Transitividade
- Simetria
- Antissimetria

### Intuições

- **Reflexividade:** Todos os elementos relacionam-se consigo próprios.
- **Irreflexividade:** Não há elemento que se relacione consigo próprio.
- **Transitividade:** Se há sequência de pares que ligam um elemento $x$ a outro $y$, então há a relação direta de $x$ para $y$.
- **Simetria:** "Tudo que vai, volta".
- **Antissimetria:** Dois elementos relacionam-se no máximo de uma forma.

---

## Reflexividade e Irreflexividade

### Reflexividade

**Definição (Relação Reflexiva):**
Uma endorrelação binária $R \subseteq A^2$ é dita reflexiva se, e somente se:
$$\forall a \in A \, (aRa)$$

> [!IMPORTANT]
> **Note bem!** Não basta olhar somente os pares da relação. Deve-se saber o conjunto sobre o qual a relação está definida.

### Irreflexividade

**Definição (Relação Irreflexiva):**
Uma endorrelação binária $R \subseteq A^2$ é dita irreflexiva se, e somente se:
$$\forall a \in A \, \neg(aRa)$$

> [!WARNING]
> **Note bem!** Esta **não** é uma propriedade complementar à reflexividade.

### Reflexividade $\times$ Irreflexividade

- Não são noções complementares.
- A negação da reflexividade é: $(\exists a \in A)(\neg(aRa))$.
- É possível definir uma relação reflexiva e irreflexiva.
- Assim como é possível definir uma relação que não seja nem reflexiva nem irreflexiva.

---

## Exemplos de Reflexividade e Irreflexividade

Seja $A = \{0, 1, 2\}$.

**Reflexivas, mas não irreflexivas:**
- $\langle \mathbb{N}, \leq \rangle$
- $\langle 2^A, \subseteq \rangle$
- $A^2 : A \to A$
- $\langle A, = \rangle$

**Irreflexivas, mas não reflexivas:**
- $\langle \mathbb{Z}, \neq \rangle$
- $\langle 2^A, \subset \rangle$
- $\emptyset : A \to A$
- $\langle A, R \rangle$ onde $R = \{\langle 0, 1 \rangle, \langle 1, 2 \rangle, \langle 2, 1 \rangle\}$

**Nem reflexiva, nem irreflexiva:**
- $\langle A, S \rangle$ onde $S = \{\langle 0, 2 \rangle, \langle 2, 0 \rangle, \langle 2, 2 \rangle\}$

---

## Identificação da Propriedade

### Representação em Matriz

- **Reflexividade:** A diagonal principal possui somente $1$.
- **Irreflexividade:** A diagonal principal possui somente $0$.

### Representação em Grafo

- **Reflexividade:** Todo nodo possui aresta com origem e destino nele próprio (auto-laço).
- **Irreflexividade:** Nenhum nodo tem aresta com origem e destino nele próprio.

---

## Transitividade

**Definição (Relação Transitiva):**
Uma endorrelação binária $R \subseteq A^2$ é dita transitiva se, e somente se:
$$\forall a, b, c \in A \, (aRb \land bRc \rightarrow aRc)$$

**Exemplo:** A relação "é maior"
- João é maior do que José.
- José é maior do que Maria.
- Portanto, João é maior do que Maria.

**Contraexemplo:** A relação "faz fronteira com" nos países da América do Sul
- O Brasil faz fronteira com a Argentina.
- A Argentina faz fronteira com o Chile.
- No entanto, o Brasil **não** faz fronteira com o Chile.

### Exemplos e Contraexemplos de Transitividade

Seja $X$ um conjunto qualquer. As seguintes relações são **Transitivas**:
- $X^2 : X \to X$
- $\emptyset : X \to X$
- $\langle X, = \rangle$
- $\langle \mathbb{N}, \leq \rangle$
- $\langle 2^X, \subseteq \rangle$
- $\langle \mathbb{Z}, < \rangle$
- $\langle 2^X, \subset \rangle$

**Contraexemplos (Não Transitivas):**
Seja $A = \{0, 1, 2\}$.
- $\langle \mathbb{Z}, \neq \rangle$
- $\langle A, R \rangle$ onde $R = \{\langle 0, 1 \rangle, \langle 1, 2 \rangle, \langle 2, 1 \rangle\}$
- $\langle A, S \rangle$ onde $S = \{\langle 0, 2 \rangle, \langle 2, 0 \rangle, \langle 2, 2 \rangle\}$

### Identificação da Transitividade

- **Representação como Matriz:** Não é especialmente vantajosa.
- **Representação como Grafo:** O grafo explicita todos os caminhos possíveis entre dois nodos.

---

## Simetria

**Definição (Relação Simétrica):**
Uma endorrelação binária $R \subseteq A^2$ é dita simétrica se, e somente se:
$$\forall a, b \in A \, (aRb \rightarrow bRa)$$

Sempre que um elemento $a$ estiver relacionado com outro $b$, o inverso também ocorre ($b$ se relaciona com $a$).

**Exemplo:** A relação de parentesco.
- Se João é parente de José.
- Então José é parente de João.

---

## Antissimetria

**Definição (Relação Antissimétrica):**
Uma endorrelação binária $R \subseteq A^2$ é dita antissimétrica se, e somente se:
$$\forall a, b \in A \, (aRb \land bRa \rightarrow a = b)$$

> [!WARNING]
> **Note bem!** Esta **não** é uma propriedade complementar à simetria!

Uma forma, talvez mais simples, de ver a definição é pela contrapositiva:
$$\forall a, b \in A \, (a \neq b \rightarrow \neg(aRb) \lor \neg(bRa))$$
Ou seja, entre dois elementos distintos de $A$, existe no máximo um relacionamento.

### Simetria $\times$ Antissimetria

- Não são noções complementares.
- É possível definir relações simétricas e antissimétricas simultaneamente.
- Assim como relações que não são nem simétricas nem antissimétricas.

---

## Exemplos de Simetria e Antissimetria

Sejam $A = \{0, 1, 2\}$ e $X$ um conjunto qualquer.

**Simétricas:**
- $X^2 : X \to X$, $\emptyset : X \to X$
- $\langle X, = \rangle$, $\langle X, \neq \rangle$
- $\langle 2^X, = \rangle$

**Antissimétricas:**
- $\langle X, = \rangle$
- $\langle 2^X, = \rangle$
- $\emptyset : X \to X$
- $\langle \mathbb{N}, R \rangle$, onde $R = \{\langle x, y \rangle \in \mathbb{N}^2 \mid y = x^2\}$

**Nem simétrica, nem antissimétrica:**
- $\langle A, S \rangle$ onde $S = \{\langle 0, 1 \rangle, \langle 1, 0 \rangle, \langle 1, 2 \rangle\}$

---

## Identificação da Propriedade (Simetria e Antissimetria)

### Representação em Matriz

- **Simetria:** Matriz simétrica (a matriz é igual à sua transposta).
- **Antissimetria:** Dados $i \neq j$, se a posição $(i, j)$ possui valor $1$, então a posição $(j, i)$ tem obrigatoriamente valor $0$.

### Representação em Grafo

- **Simetria:** Entre dois nodos distintos: ou não há seta, ou há duas (uma em cada sentido).
- **Antissimetria:** Existe no máximo uma seta entre dois nodos distintos quaisquer.
