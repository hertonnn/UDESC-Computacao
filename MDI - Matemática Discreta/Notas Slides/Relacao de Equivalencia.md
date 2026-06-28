# Relação de Equivalência
## Introdução

Uma relação de equivalência reflete uma noção de **igualdade semântica**. Entidades com formas diferentes (sintaticamente diferentes) podem ser consideradas equivalentes ("igualadas"). 

Um exemplo prático é o conectivo de bi-implicação ($\leftrightarrow$) na Lógica Proposicional, onde proposições diferentes podem ter o mesmo valor semântico.

---

## Definição

Considerando a noção semântica de igualdade, as seguintes propriedades caracterizam uma relação de equivalência:
- **Reflexividade:** Qualquer elemento é sempre "igual" a si mesmo.
- **Transitividade:** Uma propriedade intuitiva em qualquer noção de "igualdade".
- **Simetria:** É a propriedade que mais caracteriza a "igualdade" (e a diferencia, por exemplo, de uma relação de ordem que é antissimétrica).

**Definição (Relação de Equivalência):**
$R \subseteq A^2$ é uma **Relação de Equivalência** se, e somente se, $R$ é uma endorrelação reflexiva, simétrica e transitiva.

---

## Partição e Classes de Equivalência

Um importante resultado de uma relação de equivalência $R : A \to A$ é que ela induz uma única **partição** do conjunto $A$. 
- A partição é formada por subconjuntos disjuntos e não vazios, denominados **classes de equivalência**.
- A união de todas as classes de equivalência resulta no conjunto original $A$.

> E vice-versa: toda partição induz uma relação de equivalência.

### Notação para Classe de Equivalência

Tome-se $\{A_1, A_2, \ldots, A_n\}$ uma partição de $A$.
- Cada $A_i$ (com $i = 1, \ldots, n$) é um subconjunto de $A$.
- É usual denotar cada classe da partição por um elemento representativo da própria classe.
- Para $a_1 \in A_1, \ldots, a_n \in A_n$, teremos $[a_1] = A_1, \ldots, [a_n] = A_n$.

Onde $[x]$ denota a classe de equivalência do elemento $x$.

---

## Exemplos de Relações de Equivalência

- $\langle A, = \rangle$
- $\langle 2^A, = \rangle$
- $A^2 : A \to A$
- $\langle \mathbb{N}, R_{\text{mod} 2} \rangle$, onde $R_{\text{mod} 2} = \{\langle a, b \rangle \mid a\%2 = b\%2\}$
  *(Nota: $x\%y$ é o resto da divisão inteira de $x$ por $y$)*

No último exemplo, $R_{\text{mod} 2}$ induz uma partição de $\mathbb{N}$ em duas classes de equivalência:
- $[0]$: A classe de equivalência dos números pares (resto zero).
- $[1]$: A classe de equivalência dos números ímpares (resto um).

---

## Conjunto Quociente

**Definição (Conjunto Quociente):**
Dada a relação de equivalência $R : A \to A$, o conjunto quociente é o conjunto formado por todas as classes de equivalência induzidas por $R$:
$$A/R = \{[a]_R \mid a \in A\}$$

Onde para qualquer $a \in A$, temos que a classe de equivalência de $a$ é definida como:
$$[a]_R = \{b \in A \mid aRb\}$$

O conjunto quociente é a partição de $A$ induzida pela relação de equivalência $R$.

### Exemplo: Conjunto dos Números Racionais ($\mathbb{Q}$)

Sejam os conjuntos $\mathbb{N}^+ = \mathbb{N} - \{0\}$ (naturais não nulos) e $F = \mathbb{Z} \times \mathbb{N}^+$ (frações).

Seja a relação de equivalência:
$$R = \left\{ \langle \langle a, b \rangle, \langle c, d \rangle \rangle \in F^2 \;\middle|\; \frac{a}{b} = \frac{c}{d} \right\}$$

Portanto, o conjunto dos números racionais $\mathbb{Q}$ é, na verdade, o conjunto quociente $F/R$:
$$\mathbb{Q} = F/R$$

Isso significa que **cada número racional é uma classe de equivalência de frações**. 
Alguns exemplos de classes:
- $[0]_R = \left\{ \frac{0}{1}, \frac{0}{2}, \frac{0}{3}, \ldots \right\}$
- $\left[\frac{1}{2}\right]_R = \left\{ \frac{1}{2}, \frac{2}{4}, \frac{3}{6}, \ldots \right\}$
- $\left[-\frac{5}{4}\right]_R = \left\{ -\frac{5}{4}, -\frac{10}{8}, -\frac{15}{12}, \ldots \right\}$
