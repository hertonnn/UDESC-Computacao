# Relação de Ordem

## Introdução

A relação de ordem é um tipo especial e importante de relação, pois reflete a noção intuitiva de ordem natural ou hierárquica.

Exemplos de relações de ordem já estudadas:
- "Está contido" ($\subseteq$) sobre conjuntos.
- "Implicação" ($\rightarrow$) em proposições lógicas.
- "Menor ou igual" ($\leq$) em números.

---

## Definição

**Definição (Relação de Ordem Parcial):**
$R \subseteq A^2$ é uma **Relação de Ordem Parcial** se, e somente se, $R$ é uma endorrelação **reflexiva, antissimétrica e transitiva**.

Para $\langle A, R \rangle$ relação de ordem, o conjunto $A$ é dito **conjunto parcialmente ordenado**.

### Exemplos

As seguintes relações são Relações de Ordem Parcial:
- $\langle \mathbb{N}, \leq \rangle$
- $\langle 2^A, \subseteq \rangle$
- $\langle \mathbb{Q}, = \rangle$
- $\{\langle x, y \rangle \in (\mathbb{N} - \{0\})^2 \mid x \text{ divide } y\}$
- $\{\langle a, a \rangle, \langle a, b \rangle, \langle a, c \rangle, \langle b, b \rangle, \langle b, c \rangle, \langle c, c \rangle, \langle d, d \rangle, \langle d, e \rangle, \langle e, e \rangle\}$ sobre o conjunto $X = \{a, b, c, d, e\}$

---

## Diagramas de Hasse

Uma relação de ordem pode ser representada graficamente através de um **grafo dirigido**.

Nesse tipo de representação de relação de ordem, **jamais ocorrerá um ciclo**, excetuando-se os endoarcos (arcos com origem e destino em um mesmo nodo). Isso ocorre pela presença da propriedade antissimétrica e da transitividade da relação de ordem.

Para uma relação de ordem, a explicitação gráfica da transitividade e da reflexividade muitas vezes ocasiona "poluição visual". É usual omitir as arestas que podem ser deduzidas pelas propriedades da ordem.

Esse tipo de representação simplificada, sem laços de reflexividade explícitos e sem as arestas transitivas deduzíveis, é denominada **Diagrama de Hasse**.

---

## Semântica de Sistemas Concorrentes

Conjuntos ordenados são usados para fornecer semântica matemática para sistemas concorrentes.
- Geralmente usa-se a **ordem parcial estrita**: uma relação transitiva, antissimétrica e **irreflexiva** (como $<$).
- É um importante exemplo que fornece uma visão simples e clara do que é concorrência (concorrência verdadeira).

### Exemplo 1: Programa Sequencial

Considere um programa sequencial simples onde o símbolo `;` representa dependência causal:
$$c_1 ;\, c_2 ;\, c_3$$

A semântica baseada na ordem parcial é expressa por $\langle \{c_1, c_2, c_3\}, \leq_c \rangle$, onde:
$$c_1 \leq_c c_2 \quad \text{e} \quad c_2 \leq_c c_3 \implies c_1 \leq_c c_3$$

Mais precisamente:
$$\leq_c = \{\langle c_1, c_2 \rangle, \langle c_1, c_3 \rangle, \langle c_2, c_3 \rangle\}$$

### Exemplo 2: Vários Programas Concorrentes

De forma análoga, considere três processos executados concorrentemente:
1. $c_1 ;\, c_2 ;\, c_3$
2. $p_1 ;\, p_2$
3. $q_1 ;\, q_2 ;\, q_3$

As semânticas para os dois novos processos são:
- $\langle \{p_1, p_2\}, \leq_p \rangle$, onde $p_1 \leq_p p_2$
- $\langle \{q_1, q_2, q_3\}, \leq_q \rangle$, onde $q_1 \leq_q q_2$ e $q_2 \leq_q q_3$

Suponha os 3 programas concorrentes **sem qualquer sincronização**. A semântica é induzida pela união disjunta de conjuntos:
$$\langle \{c_1, c_2, c_3\} \uplus \{p_1, p_2\} \uplus \{q_1, q_2, q_3\},\, \leq_c \uplus \leq_p \uplus \leq_q \rangle$$

Todas as componentes dos três processos operam de maneira independente (concorrente), excetuando-se quando especificado o contrário (quando é definido um par extra na relação de ordem determinando uma restrição de sequencialidade/sincronização).

### Exemplo 3: Sincronização

Suponha que no exemplo anterior haja dependências adicionais entre os programas:
- A ocorrência de $p_2$ depende do término de $c_2$.
- A ocorrência de $c_3$ depende do término de $q_3$.

Para fazer a sincronização, é suficiente incluir os pares adicionais cruzados:
$$c_2 \leq p_2 \quad \text{e} \quad q_3 \leq c_3$$

A relação final passaria a ter a estrutura:
$$\langle \{c_1, c_2, c_3, p_1, p_2, q_1, q_2, q_3\},\, \leq_c \uplus \leq_p \uplus \leq_q \uplus \{\langle c_2, p_2 \rangle, \langle q_3, c_3 \rangle\} \rangle$$

**Conclusão das Operações:**
Observe que:
- **União disjunta** representa a composição paralela de sistemas independentes.
- **Inclusão de pares extras** representa as sincronizações causais entre processos.

São operações matemáticas simples e de fácil entendimento usadas para especificar e modelar formalmente sistemas concorrentes e comunicantes na Computação.
