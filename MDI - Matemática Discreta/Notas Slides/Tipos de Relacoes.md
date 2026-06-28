# Tipos de Relações

## Introdução

Uma relação pode ser classificada em vários tipos. Esses tipos **não são mutuamente exclusivos**:
- Funcional
- Injetora
- Total
- Sobrejetora
- Bijetora (ou isomorfismo)

### O Princípio da Dualidade

A **dualidade**, se corretamente entendida e aplicada, simplifica ("divide pela metade") o estudo e o entendimento dos conceitos.

A dualidade nos tipos de relação:
- **Funcional** é o dual de **Injetora** (e vice-versa).
- **Total** é o dual de **Sobrejetora** (e vice-versa).
- **Isomorfismo** é o dual de si mesmo.

---

## Relação Funcional

A relação funcional é especialmente importante, pois permite definir o conceito de **função**.

**Definição (Relação Funcional):**
Seja $R : A \to B$ uma relação. Então $R$ é uma Relação Funcional se, e somente se:
$$\forall a \in A, \, \forall b_1, b_2 \in B \, (aRb_1 \land aRb_2 \rightarrow b_1 = b_2)$$

Portanto, para $R : A \to B$ funcional, **cada elemento de $A$ está relacionado com, no máximo, um elemento de $B$**.

### Exemplos e Contraexemplos
Sejam $A = \{a\}$, $B = \{a, b\}$ e $C = \{0, 1, 2\}$.

**Funcionais:**
- $\emptyset : A \to B$
- $\{\langle 0, a \rangle, \langle 1, b \rangle\} : C \to B$
- $= : A \to B$
- $x^2 : \mathbb{Z} \to \mathbb{Z}$ onde $x^2 = \{\langle x, y \rangle \in \mathbb{Z}^2 \mid y = x^2\}$

**Contraexemplos:**
- $A \times B : A \to B$
- $< : C \to C$

### Representação
Para uma endorrelação:
- **Matriz:** No máximo um valor verdadeiro em cada **linha**.
- **Grafo:** No máximo uma aresta partindo de cada **nodo**.

---

## Relação Injetora

A relação injetora é o conceito dual da relação funcional.

**Definição (Relação Injetora):**
Seja $R : A \to B$ uma relação. Então $R$ é uma Relação Injetora se, e somente se:
$$\forall b \in B, \, \forall a_1, a_2 \in A \, (a_1Rb \land a_2Rb \rightarrow a_1 = a_2)$$

Portanto, para $R : A \to B$ injetora, **cada elemento de $B$ está relacionado com, no máximo, um elemento de $A$**.

### Exemplos e Contraexemplos
Sejam $A = \{a\}$, $B = \{a, b\}$ e $C = \{0, 1, 2\}$.

**Injetoras:**
- $\emptyset : A \to B$
- $\{\langle 0, a \rangle, \langle 1, b \rangle\} : C \to B$
- $= : A \to B$

**Contraexemplos:**
- $A \times B : A \to B$
- $< : C \to C$
- $x^2 : \mathbb{Z} \to \mathbb{Z}$ onde $x^2 = \{\langle x, y \rangle \in \mathbb{Z}^2 \mid y = x^2\}$ *(dois elementos diferentes do domínio podem mapear para o mesmo elemento no contradomínio, ex: $2$ e $-2$ mapeiam para $4$)*.

### Representação
Para uma endorrelação:
- **Matriz:** No máximo um valor verdadeiro em cada **coluna**.
- **Grafo:** No máximo uma aresta chegando em cada **nodo**.

> [!WARNING]
> Funcional e Injetora são conceitos duais, mas **não são complementares**. É fácil encontrar relações que são simultaneamente funcional e injetora, ou que não são nenhuma das duas.

---

## Relação Total

**Definição (Relação Total):**
Seja $R : A \to B$ uma relação. Então $R$ é uma Relação Total se, e somente se:
$$\forall a \in A, \, \exists b \in B \, (aRb)$$

Portanto, para $R : A \to B$ total, **todo elemento de $A$ está relacionado com pelo menos um elemento de $B$**.

### Exemplos e Contraexemplos
Sejam $A = \{a\}$, $B = \{a, b\}$ e $C = \{0, 1, 2\}$.

**Totais:**
- $= : A \to B$
- $A \times B : A \to B$
- $x^2 : \mathbb{Z} \to \mathbb{Z}$

**Contraexemplos:**
- $\emptyset : A \to B$
- $\{\langle 0, a \rangle, \langle 1, b \rangle\} : C \to B$
- $< : C \to C$

### Representação
Para uma endorrelação:
- **Matriz:** Pelo menos um valor verdadeiro em cada **linha**.
- **Grafo:** Pelo menos uma aresta partindo de cada **nodo**.

---

## Relação Sobrejetora

A relação sobrejetora é o conceito dual da relação total.

**Definição (Relação Sobrejetora):**
Seja $R : A \to B$ uma relação. Então $R$ é uma Relação Sobrejetora se, e somente se:
$$\forall b \in B, \, \exists a \in A \, (aRb)$$

Portanto, para $R : A \to B$ sobrejetora, **todo elemento de $B$ se relaciona com pelo menos um elemento de $A$**.

### Exemplos e Contraexemplos
Sejam $A = \{a\}$, $B = \{a, b\}$ e $C = \{0, 1, 2\}$.

**Sobrejetoras:**
- $= : A \to A$
- $\{\langle 0, a \rangle, \langle 1, b \rangle\} : C \to B$
- $A \times B : A \to B$

**Contraexemplos:**
- $= : A \to B$
- $\emptyset : A \to B$
- $< : C \to C$
- $x^2 : \mathbb{Z} \to \mathbb{Z}$ *(pois existem elementos em $\mathbb{Z}$, como os números negativos, que não são o quadrado de nenhum inteiro)*.

### Representação
Para uma endorrelação:
- **Matriz:** Pelo menos um valor verdadeiro em cada **coluna**.
- **Grafo:** Pelo menos uma aresta chegando em cada **nodo**.

> [!WARNING]
> Total e Sobrejetora são conceitos duais, mas **não são complementares**.

---

## Isomorfismo (Bijeção)

Um Isomorfismo traz a **noção de igualdade semântica**. É uma relação tal que, quando composta com a sua inversa, resulta em uma relação de identidade.

Intuitivamente, significa "ir" (via relação) e "voltar" (via sua inversa) sem alterar o elemento original.

**Definição (Isomorfismo / Isorrelação / Relação Bijetora):**
Seja $R : A \to B$ uma relação. Então $R$ é um Isomorfismo se, e somente se:
$$R^{-1} \circ R = \text{id}_A$$
$$R \circ R^{-1} = \text{id}_B$$

### Notação e Nomenclatura
Notação para enfatizar que $R : A \to B$ é uma isorrelação:
$$R : A \leftrightarrow B$$

Dois conjuntos são ditos **conjuntos isomorfos** se existir uma isorrelação entre eles.

> Na escola, costuma-se aprender que "Bijetora = Injetora e Sobrejetora". Porém, em se tratando de relações em geral, **uma relação injetora e sobrejetora pode não ser um isomorfismo!**

### Exemplo de Isomorfismo
Sejam $A = \{a, b, c\}$, $C = \{1, 2, 3\}$ e $R : A \to C$ com:
$$R = \{\langle a, 1 \rangle, \langle b, 2 \rangle, \langle c, 3 \rangle\}$$

A sua relação inversa $R^{-1} : C \to A$ é:
$$R^{-1} = \{\langle 1, a \rangle, \langle 2, b \rangle, \langle 3, c \rangle\}$$

Compondo as relações:
$$R^{-1} \circ R = \{\langle a, a \rangle, \langle b, b \rangle, \langle c, c \rangle\} = \text{id}_A$$
$$R \circ R^{-1} = \{\langle 1, 1 \rangle, \langle 2, 2 \rangle, \langle 3, 3 \rangle\} = \text{id}_C$$

Portanto, $R$ é um isomorfismo, e os conjuntos $A$ e $C$ são isomorfos.

### Outros Exemplos
**Isomorfismos:**
- $\text{id}_B : B \to B$
- $\text{id}_X : X \to X$
- $\{\langle 0, 1 \rangle, \langle 1, 2 \rangle, \langle 2, 0 \rangle\} : C \to C$

**Contraexemplos:**
- $\emptyset : A \to B$
- $A \times B : A \to B$
- $< : C \to C$
- $x^2 : \mathbb{Z} \to \mathbb{Z}$

### Demonstração de Isomorfismo
**Prova de que é um isomorfismo:** Mostrar que a composição com a relação inversa $R^{-1}$ resulta nas identidades $\text{id}_A$ e $\text{id}_B$.
**Prova de que não é um isomorfismo:** Freqüentemente feita por absurdo.

**Exemplo:** $A = \{0, 1, 2\}$, $B = \{a, b\}$ e $R = \{\langle 0, a \rangle, \langle 1, b \rangle\}$.
Suponha por absurdo que $R$ seja um isomorfismo. Então:
$$R^{-1} \circ R = \text{id}_A$$
$$\langle 2, 2 \rangle \in R^{-1} \circ R \implies \exists x \in B \, (\langle 2, x \rangle \in R \land \langle x, 2 \rangle \in R^{-1})$$
Isso é um absurdo, pois não existe par começando em $2$ no conjunto $R$. Logo, $R$ não é isomorfismo. $\blacksquare$

### Bijeção e Cardinalidade
Em um isomorfismo (bijeção), os conjuntos origem e destino **possuem o mesmo número de elementos** (mesma cardinalidade).
