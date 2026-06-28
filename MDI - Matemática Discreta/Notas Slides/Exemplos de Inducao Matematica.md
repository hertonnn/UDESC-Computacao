# Indução Matemática — Exercícios dos Slides

## Exercício 1: Soma dos Primeiros $n$ Naturais

**Enunciado:** Provar que

$$\sum_{i=1}^{n} i = \frac{n \cdot (n + 1)}{2}, \quad \forall n \in \mathbb{N}.$$

### Base

Para $n = 1$:

$$\sum_{i=1}^{1} i = 1 \qquad \text{e} \qquad \frac{1 \cdot (1 + 1)}{2} = \frac{2}{2} = 1$$

Como ambos os lados são iguais a $1$, a proposição vale para $n = 1$. $\checkmark$

### Passo Indutivo

**Hipótese de indução:** Suponha que a fórmula vale para $k$:

$$\sum_{i=1}^{k} i = \frac{k \cdot (k + 1)}{2}$$

**Tese:** Provar que vale para $k + 1$:

$$\sum_{i=1}^{k+1} i = \frac{(k+1) \cdot (k+2)}{2}$$

**Demonstração:**

Partindo do lado esquerdo para $k + 1$:

$$\sum_{i=1}^{k+1} i = \sum_{i=1}^{k} i + (k + 1)$$

Substituindo a hipótese de indução:

$$= \frac{k \cdot (k + 1)}{2} + (k + 1)$$

Colocando $(k + 1)$ em evidência após igualar os denominadores:

$$= \frac{k \cdot (k + 1) + 2 \cdot (k + 1)}{2} = \frac{(k + 1)(k + 2)}{2}$$

Portanto, provamos que:

$$\sum_{i=1}^{k+1} i = \frac{(k + 1) \cdot (k + 2)}{2} \quad \blacksquare$$

---

## Exercício 2: Crescimento Exponencial vs. Fatorial

**Enunciado:** Provar que $\forall n > 3,\, n \in \mathbb{N}$:

$$2^n < n!$$

### Base

Para $n = 4$:

$$2^4 = 16 \qquad \text{e} \qquad 4! = 24$$

Como $16 < 24$, a proposição vale para $n = 4$. $\checkmark$

### Passo Indutivo

**Hipótese de indução:** Suponha que para algum $k > 3$:

$$2^k < k!$$

**Tese:** Provar que $2^{k+1} < (k+1)!$

**Demonstração:**

Observe que:

$$(k + 1)! = (k + 1) \cdot k!$$

$$2^{k+1} = 2^k \cdot 2$$

Pela hipótese de indução, sabemos que $2^k < k!$. Resta analisar a relação entre $(k + 1)$ e $2$:

$$k > 3 \implies k + 1 > 4 > 2$$

Portanto, $k + 1 > 2$. Juntando as duas informações ($2^k < k!$ e $2 < k + 1$), temos:

$$2^k \cdot 2 < k! \cdot (k + 1)$$

Ou seja:

$$2^{k+1} < (k + 1)! \quad \blacksquare$$
