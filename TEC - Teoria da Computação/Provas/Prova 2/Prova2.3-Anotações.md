# Anotações - Prova 2 (Teoria da Computação)

## Prova II (21/07/2022)

**Questão 1:** Demonstre que a linguagem abaixo é indecidível:
$T = \{\langle M \rangle \mid \exists w \in \Sigma^* (|w| = 3 \land w \in L(M)) \}$

**Questão 2:** Prove que uma linguagem $A$ é Turing-reconhecível se, e somente se, ela pode ser reduzida por mapeamento à linguagem $A_{MT}$ ($A \leq_m A_{MT}$).

**Questão 3:** Demonstre que a classe de complexidade P é fechada sob a operação de diferença de conjuntos.

**Questão 4:** Considerando que NP é a classe de linguagens que possuem verificadores em tempo polinomial (onde um verificador para a linguagem $A$ é um algoritmo $V$ tal que $A = \{w \mid V \text{ aceita } \langle w, c \rangle \text{ para algum } c \}$, sendo $c$ o certificado). Dada a linguagem pertencente a NP:
$SOMASUBC = \{ \langle S, t \rangle \mid S = \{x_1, \ldots, x_k\} \subseteq \mathbb{Z} \text{ e existe um subconjunto } \{y_1, \ldots, y_n\} \subseteq S \text{ tal que } \sum_{i=1}^n y_i = t \}$
Responda:
a) Qual seria o papel ou o significado do certificado $c$ para um verificador do problema $SOMASUBC$?
b) Descreva um algoritmo de tempo polinomial que atue como verificador para a linguagem $SOMASUBC$.
