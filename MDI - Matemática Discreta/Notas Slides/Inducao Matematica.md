# Indução Matemática

## Introdução — O Efeito Dominó

O que acontece quando empurramos o primeiro de uma sequência de dominós enfileirados?

Ao derrubar a primeira peça, todas as demais serão derrubadas em cadeia. Para que isso efetivamente ocorra, são necessárias duas condições:

1. A primeira peça deve ser derrubada em direção às demais.
2. Se qualquer peça está suficientemente próxima da seguinte, então, ao ser derrubada, ela fará com que a seguinte também seja derrubada.

O raciocínio se desdobra assim:

- Por **①** a primeira peça é derrubada.
- Por **②** a segunda peça é derrubada.
- Por **②** a terceira peça é derrubada.
- Por **②** a quarta peça é derrubada.
- E assim sucessivamente...

Sem **①** não começaríamos. Sem **②** o processo não continuaria.

---

## Indução Matemática

### Utilidade

**Utilidade n° 1:** Provar propriedades dos números naturais.

Na realidade, a indução matemática pode provar uma propriedade para qualquer estrutura que mantenha uma "boa ordem" — isto é, todo subconjunto não vazio da estrutura possui um elemento mínimo segundo essa tal ordem.

---

## Definição — Primeiro Princípio da Indução Matemática

**Definição** (Primeiro Princípio da Indução Matemática)

Seja $p(n)$ uma proposição sobre $M = \{n \in \mathbb{N} \mid n \geq m \land m \in \mathbb{N}\}$.

Se:

- **(Base)** $p(m)$ é verdadeira
- **(Passo)** Para qualquer $k$, vale $p(k) \rightarrow p(k + 1)$

então $p(n)$ é verdadeira para todo $n \in M$.

### Técnica de Demonstração por Indução

1. Demonstrar a **base** da indução: $p(m)$
2. A partir de um $k$ qualquer:
   - supor verdadeira a **hipótese** de indução $p(k)$
   - provar o **passo** de indução, demonstrando $p(k + 1)$

---

## Exemplo — Soma dos Primeiros $n$ Naturais

Provar que:

$$\sum_{i=1}^{n} i = \frac{n(n+1)}{2}$$

para qualquer $n \in \mathbb{N}$.

---

## Exemplo — Desigualdade Exponencial

Provar que, para qualquer $n \in \mathbb{N}$:

se $n > 3$, então $2^n < n!$
