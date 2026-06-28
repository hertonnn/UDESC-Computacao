# Indução Matemática (2)

## Segundo Princípio da Indução Matemática

Mesma ideia do primeiro, só que diferente: no **passo** da indução, considera-se **todos** os resultados anteriores à $p(k)$ para concluir $p(k+1)$.

### Revisando o Primeiro Princípio

**Definição** (Primeiro Princípio da Indução Matemática)

Seja $p(n)$ uma proposição sobre $M = \{n \in \mathbb{N} \mid n \geq m \land m \in \mathbb{N}\}$.

Se:

- **(Base)** $p(m)$ é verdadeira
- **(Passo)** Para qualquer $k$, vale $p(k) \rightarrow p(k + 1)$

então $p(n)$ é verdadeira para todo $n \in M$.

---

### Definição do Segundo Princípio

**Definição** (Segundo Princípio da Indução Matemática)

Seja $p(n)$ uma proposição sobre $M = \{n \in \mathbb{N} \mid n \geq m \land m \in \mathbb{N}\}$.

Se:

- **(Base)** $p(m)$ é verdadeira
- **(Passo)** Para qualquer $k$, vale:

$$p(m) \land p(m+1) \land \ldots \land p(k) \rightarrow p(k+1)$$

então $p(n)$ é verdadeira para todo $n \in M$.

### Versão 2.0 do Segundo Princípio

**Definição** (Segundo Princípio — Versão 2.0)

Seja $p(n)$ uma proposição sobre $M = \{n \in \mathbb{N} \mid n \geq m \land m \in \mathbb{N}\}$ e $t \in \mathbb{N}$.

Se:

- **(Base)** $p(m), p(m+1), \ldots, p(m+t)$ são verdadeiras
- **(Passo)** Para qualquer $k$ com $k \geq m + t$, vale:

$$p(m) \land p(m+1) \land \ldots \land p(k) \rightarrow p(k+1)$$

então $p(n)$ é verdadeira para todo $n \in M$.

> [!TIP]
> Prova-se os $t$ primeiros casos em separado para verificar a base da indução.

---

## Aplicação Usual do Segundo Princípio — Indução Estruturada

O Segundo Princípio é especialmente útil para definição e prova de propriedades de:

- expressões
- fórmulas
- árvores
- ...

Também é denominado **Indução Estruturada**.

---

## Exemplo — Fórmulas com Todos os Átomos Verdadeiros

**Enunciado:**

Suponha que $A$ é uma fórmula lógica que contém exclusivamente os conectivos $\land$, $\lor$ e $\rightarrow$. Se o valor verdade de todos os átomos de $A$ é $V$, então o valor verdade de $A$ é $V$.

**Prova:** por indução no número de átomos de $A$.

**Base:** Seja $k = 1$. Então:
- $A$ é um átomo
- logo $A$ é $V$.

**Hipótese:** Suponha que, para algum $k \in \mathbb{N}$, e para qualquer $u \in \mathbb{N}$ tal que $u \leq k$:
- se o número de átomos de $A$ é $u$, então o valor verdade de $A$ é $V$.

**Passo:** Seja $A$ uma fórmula com $k + 1$ átomos.
- $A$ pode ser reescrita como (sendo $B$ e $C$ fórmulas que possuem, individualmente, no máximo $k$ átomos e conjuntamente $k + 1$ átomos):
  - $B \land C$
  - $B \lor C$
  - $B \rightarrow C$
- pela **hipótese** de indução, $B$ e $C$ são $V$
- analisando cada um dos três casos, $A$ é $V$. $\blacksquare$

---

## Exemplo — Selos de R$4,00 e R$5,00

**Enunciado:**

Qualquer valor de postagem igual ou maior do que R\$12,00 pode ser formado usando exclusivamente selos de R\$4,00 e R\$5,00.

**Prova:**

**Base:** Seja $k \in \{12, 13, 14, 15\}$:

| Valor | Composição |
| :---: | :--- |
| R\$12,00 | 3 selos de R\$4,00 |
| R\$13,00 | 2 selos de R\$4,00 e 1 selo de R\$5,00 |
| R\$14,00 | 1 selo de R\$4,00 e 2 selos de R\$5,00 |
| R\$15,00 | 3 selos de R\$5,00 |

**Hipótese:** Suponha que, para algum $k \in \mathbb{N}$ e para qualquer $u \in \mathbb{N}$ tal que $15 \leq u \leq k$:
- se o valor é $u$, então ele pode ser formado usando selos de R\$4,00 e R\$5,00.

**Passo:** Seja uma postagem cujo valor é $k + 1$ reais. Tal postagem pode ser formada usando:
- uma postagem de $k - 3$ reais
- mais um selo de R\$4,00.

Como $k - 3 \geq 12$ (pois $k \geq 15$), pela hipótese de indução, a postagem de $k - 3$ reais pode ser formada com selos de R\$4,00 e R\$5,00. Somando o selo de R\$4,00, a postagem de $k + 1$ reais também pode ser formada. $\blacksquare$

---

## Definição Indutiva

O Princípio da Indução Matemática pode ser usado em **definições**.

**Definição Indutiva** (ou Definição Recursiva) possui dois componentes:

- **Base de indução:** explicita os casos elementares (os mais simples)
- **Passo de indução/recursão:** demais casos são definidos em termos dos anteriores

### Exemplo — Fórmula da Lógica Proposicional

**Fórmula da Lógica Proposicional** é definida indutivamente:

**Base:**
- qualquer proposição atômica (incluindo $V$ e $F$) é uma fórmula

**Passo:** Se $B$ e $C$ são fórmulas, então:
- $(\lnot B)$ é fórmula
- $(B \land C)$ é fórmula
- $(B \lor C)$ é fórmula
- $(B \rightarrow C)$ é fórmula
