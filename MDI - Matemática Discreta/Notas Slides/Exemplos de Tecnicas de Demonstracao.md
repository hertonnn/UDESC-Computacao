# Exemplos de Técnicas de Demonstração

## Exemplo de Prova Direta

### m e n são pares $\rightarrow$ m + n é par

Se $m$ e $n$ são pares, então $m = 2k,\; k \in \mathbb{Z}$ e $n = 2r,\; r \in \mathbb{Z}$.

Então:

$$m + n = 2k + 2r = 2 \cdot (k + r)$$

Consideramos que $k + r = t \in \mathbb{Z}$.

Então, provamos que $m + n = 2t,\; t \in \mathbb{Z}$, ou seja, $m + n$ é par. $\blacksquare$

---

## Exemplo de Prova por Contraposição

### $n! > (n+1) \rightarrow n > 2$

Pela contraposição, provamos o equivalente:

$$\lnot(n > 2) \rightarrow \lnot(n! > (n+1))$$
$$n \leq 2 \rightarrow n! \leq (n+1)$$

Se $n \in \mathbb{N}$ e $n \leq 2$, então $n = 2$, $n = 1$ ou $n = 0$.

**caso 1:** $n = 2$

Se $n = 2$, então:

$$n! \leq n + 1 \implies 2! \leq 2 + 1 \implies 2 \leq 3 \checkmark$$

A proposição está certa para $n = 2$.

**caso 2:** $n = 1$

Se $n = 1$, então:

$$n! \leq n + 1 \implies 1! \leq 1 + 1 \implies 1 \leq 2 \checkmark$$

A proposição está certa para $n = 1$.

**caso 3:** $n = 0$

Se $n = 0$, então:

$$n! \leq n + 1 \implies 0! \leq 0 + 1 \implies 1 \leq 1 \checkmark$$

A proposição está certa para $n = 0$.

Como a proposição está certa nos três casos, ela é verdadeira. $\blacksquare$

---

## Exemplo de Prova por Absurdo

### 0 é elemento neutro da adição em $\mathbb{N}$ $\rightarrow$ 0 é o único elemento neutro da adição em $\mathbb{N}$

Supondo que 0 não seja o único elemento neutro da adição em $\mathbb{N}$:

$$\exists\, e \neq 0 \text{ tal que } e = \text{elemento neutro da adição em } \mathbb{N}$$

Então, $\forall x \in \mathbb{N}$:

- A) $0 + x = x$
- B) $x + 0 = x$
- C) $e + x = x$
- D) $x + e = x$

Então, $0 + e = \;?$

- Por A) $\quad 0 + e = e$
- Por D) $\quad 0 + e = 0$

Logo, $0 = e$. Mas já temos que $0 \neq e$. Assim, chegamos em um **absurdo**.

Portanto, o 0 é o único elemento neutro da adição em $\mathbb{N}$. $\blacksquare$
