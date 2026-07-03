**Questão 1**

Uma linguagem pertencente à classe NP é classificada como NP-Completa se:

* possui uma redução em tempo polinomial para o problema SAT.
* o problema SAT pode ser reduzido a ela em tempo polinomial.
* possui uma redução em tempo polinomial para qualquer outro problema dentro de NP.
* existe alguma linguagem na classe NP que possui redução em tempo polinomial para ela.

**Resposta Corrigida: o problema SAT pode ser reduzido a ela em tempo polinomial.**

---

**Questão 2**

Assuma que uma linguagem $X$ pertence à classe NP e uma linguagem $Y$ é NP-Completa, sendo válido que $X \le_P Y$. Assinale a afirmação correta:

* A linguagem $X$ faz parte da classe P.
* A linguagem $X$ é da classe NP-Completa.
* Todas as alternativas anteriores.
* Nenhuma das alternativas anteriores.

**Resposta Corrigida: Nenhuma das alternativas anteriores.**

---

**Questão 3**

Se ocorrer a situação onde $X \le_P Y$ e $Y \le_P X$, o que se pode concluir?

* Ambas as linguagens fazem parte da classe P.
* As linguagens são idênticas ($X = Y$).
* É impossível existir tal configuração para duas linguagens $X$ e $Y$ distintas.
* Todas as alternativas anteriores.
* Nenhuma das alternativas anteriores.

**Resposta Corrigida: Nenhuma das alternativas anteriores.**

---

**Questão 4**

Imagine que a linguagem $X$ seja NP-Completa, a linguagem $Y$ pertença à classe P, e que $X \le_P Y$. Selecione a alternativa verdadeira:

* A linguagem $X$ faz parte da classe P.
* A linguagem $Y$ pertence à classe NP-Completa.
* $P = NP$.
* Todas as alternativas anteriores.
* Nenhuma das alternativas anteriores.

**Resposta Corrigida: Todas as alternativas anteriores.**

---

**Questão 5**

Considerando as reduções $X \le_P Y$ e $Y \le_P Z$, assinale a opção correta:

* $Y \le_P X$
* $Z \le_P Y$
* $X \le_P Z$
* Todas as alternativas anteriores.
* Nenhuma das alternativas anteriores.

**Resposta Corrigida: $X \le_P Z$**

---

**Questão 6**

A classe NP é formada por todos os problemas de decisão para os quais:

* é possível obter uma solução em tempo polinomial utilizando uma máquina de Turing determinística.
* não é possível encontrar solução em tempo polinomial através de uma máquina de Turing determinística.
* existe um algoritmo de tempo polinomial capaz de verificar as potenciais soluções.
* Todas as alternativas anteriores.
* Nenhuma das alternativas anteriores.

**Resposta Corrigida: existe um algoritmo de tempo polinomial capaz de verificar as potenciais soluções.**

---

**Questão 7**

Demonstre que a classe P possui fechamento em relação à operação de união de linguagens. Ou seja, prove que se $A, B \in P$, então consequentemente $A \cup B \in P$.

Resposta: É fechada.
---

**Questão 8**

Dadas duas linguagens decidíveis quaisquer, $A$ e $B$, a relação $A \le_m A \cup B$ será sempre verdadeira? Justifique o seu raciocínio.

Resposta: Não é sempre válido.

---

**Questão 9**

Apresente duas linguagens concretas, $L$ e $L'$, que funcionem como contraexemplo para a seguinte proposição: "se $L' \subseteq L$ e $L \in NP$, então $L'$ é necessariamente decidível."

Resposta: A afirmação é falsa.