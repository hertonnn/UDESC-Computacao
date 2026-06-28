# Fecho de Endorrelações

## Introdução

O **fecho** de uma endorrelação consiste em estender uma relação original para garantir que ela satisfaça a um determinado conjunto de propriedades.

**Exemplo:** Garantir que uma relação $R$ seja reflexiva.
- E se $R$ não é reflexiva?
- Devemos adicionar os pares mínimos necessários que garantem a reflexividade.

---

## Definição de Fecho

**Definição (Fecho de Endorrelação):**
Seja $\langle A, R \rangle$ uma endorrelação e $P$ um conjunto de propriedades. Então o fecho de $R$ em relação a $P$, denotado por $\text{FECHO}_P(R)$, é a **menor endorrelação em $A$** que contém $R$ e que satisfaz às propriedades de $P$.

Portanto, para qualquer conjunto de propriedades $P$:
$$R \subseteq \text{FECHO}_P(R)$$

**Pergunta:** Quando $R = \text{FECHO}_P(R)$?
*Resposta:* Quando a relação original $R$ já satisfaz perfeitamente as propriedades exigidas por $P$.

---

## Tipos de Fecho

### Fecho Reflexivo

**Definição (Fecho Reflexivo):**
Seja $\langle A, R \rangle$ uma endorrelação. O fecho reflexivo de $R$ é a endorrelação sobre $A$ tal que:
$$\text{FECHO}_{\text{Refl}}(R) = R \cup \{\langle a, a \rangle \mid a \in A\}$$

### Fecho Simétrico

**Definição (Fecho Simétrico):**
Seja $\langle A, R \rangle$ uma endorrelação. O fecho simétrico de $R$ é a endorrelação sobre $A$ tal que:
$$\text{FECHO}_{\text{Sim}}(R) = R \cup \{\langle b, a \rangle \mid \langle a, b \rangle \in R\}$$

### Fecho Transitivo

**Definição (Fecho Transitivo):**
Seja $\langle A, R \rangle$ uma endorrelação. O fecho transitivo de $R$ é a endorrelação $\text{FECHO}_{\text{Tran}}$ sobre $A$ definida indutivamente como a seguir:
- Se $\langle a, b \rangle \in R$, então $\langle a, b \rangle \in \text{FECHO}_{\text{Tran}}(R)$.
- Se $\langle a, b \rangle, \langle b, c \rangle \in \text{FECHO}_{\text{Tran}}(R)$, então $\langle a, c \rangle \in \text{FECHO}_{\text{Tran}}(R)$.
- Nada mais pertence à $\text{FECHO}_{\text{Tran}}(R)$.

---

## Exemplo Prático

Seja $A = \{1, 2, 3, 4, 5\}$ e $R : A \to A$ a endorrelação:
$$R = \{\langle 1, 2 \rangle, \langle 1, 5 \rangle, \langle 2, 3 \rangle, \langle 3, 4 \rangle\}$$

### 1. Fecho Reflexivo
Adicionamos todos os pares $\langle x, x \rangle$ para todo $x \in A$:
$$\text{FECHO}_{\text{Refl}}(R) = \{\langle 1, 1 \rangle, \langle 1, 2 \rangle, \langle 1, 5 \rangle, \langle 2, 2 \rangle, \langle 2, 3 \rangle, \langle 3, 3 \rangle, \langle 3, 4 \rangle, \langle 4, 4 \rangle, \langle 5, 5 \rangle\}$$

### 2. Fecho Simétrico
Adicionamos o inverso de cada par já existente em $R$:
$$\text{FECHO}_{\text{Sim}}(R) = \{\langle 1, 2 \rangle, \langle 1, 5 \rangle, \langle 2, 1 \rangle, \langle 2, 3 \rangle, \langle 3, 2 \rangle, \langle 3, 4 \rangle, \langle 4, 3 \rangle, \langle 5, 1 \rangle\}$$

### 3. Fecho Transitivo
Garantimos a existência de pontes transitivas diretas:
$$\text{FECHO}_{\text{Tran}}(R) = \{\langle 1, 2 \rangle, \langle 1, 3 \rangle, \langle 1, 4 \rangle, \langle 1, 5 \rangle, \langle 2, 3 \rangle, \langle 2, 4 \rangle, \langle 3, 4 \rangle\}$$

*(Nota: O par $\langle 1, 3 \rangle$ é adicionado pois temos $\langle 1, 2 \rangle$ e $\langle 2, 3 \rangle$. Como agora temos $\langle 1, 3 \rangle$ e $\langle 3, 4 \rangle$, o par $\langle 1, 4 \rangle$ também é adicionado. O par $\langle 2, 4 \rangle$ é adicionado a partir de $\langle 2, 3 \rangle$ e $\langle 3, 4 \rangle$.)*
