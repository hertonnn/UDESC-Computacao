# 1ª Lista de Exercícios: Conjuntos e Intervalos

> [!NOTE]
> **Informações Acadêmicas:**
> - **Curso Superior:** Bacharelado em Ciência da Computação (UDESC)
> - **Disciplina:** Introdução ao Cálculo Diferencial e Integral (ICD)
> - **Professor:** Dani Prestini

---

## 1. Operações com Conjuntos

### Questão 1
Dados os conjuntos $A = \{0, 1, 2, 4, 5\}$, $B = \{0, 2, 4, 6\}$, $C = \{1, 3, 5, 11\}$ e $D = \{2, 4\}$, determine:

*   **a)** $A \cup B$
*   **b)** $A \cap B$
*   **c)** $A \cap C$
*   **d)** $A - B$
*   **e)** $A \cup B \cup C$
*   **f)** $A \cap B \cap C$
*   **g)** $(B \cap C) \cup A$
*   **h)** $(A \cap C) \cap \varnothing$
*   **i)** $\varnothing \cup (A \cup B)$
*   **j)** $(B \cup C) \cap A$
*   **l)** $B - C$
*   **m)** $B - (D - A)$

#### Respostas da Seção 1
*   **1a)** $\{0, 1, 2, 4, 5, 6\}$
*   **1b)** $\{0, 2, 4\}$
*   **1c)** $\{1, 5\}$
*   **1d)** $\{1, 5\}$
*   **1e)** $\{0, 1, 2, 3, 4, 5, 6, 11\}$
*   **1f)** $\varnothing$
*   **1g)** $A = \{0, 1, 2, 4, 5\}$
*   **1h)** $\varnothing$
*   **1i)** $\{0, 1, 2, 4, 5, 6\}$
*   **1j)** $\{0, 1, 2, 4, 5\} = A$
*   **1l)** $B = \{0, 2, 4, 6\}$
*   **1m)** $B = \{0, 2, 4, 6\}$

---

## 2. Problemas que Envolvem Conjuntos

### Questão 1 (GIONVANNI)
Numa pesquisa, verificou-se que, das pessoas consultadas, $100$ liam o jornal $A$, $150$ liam o jornal $B$, $20$ liam os dois jornais ($A$ e $B$) e $110$ não liam nenhum deles. Quantas pessoas foram consultadas?
*   **Resposta:** $340$ pessoas.

### Questão 2 (UnB - DF)
De $200$ pessoas que foram pesquisadas sobre suas preferências em assistir aos campeonatos de corrida pela televisão, foram colhidos os seguintes dados: $55$ dos entrevistados não assistem; $101$ assistem às corridas de Fórmula 1 e $27$ assistem às corridas de Fórmula 1 e Motovelocidade. Quantas das pessoas entrevistadas assistem, exclusivamente, às corridas de Motovelocidade?
*   **Resposta:** $44$ pessoas.

### Questão 3 (GIONVANNI / Adaptada)
Uma editora estuda a possibilidade de relançar as obras: *"Helena"*, *"Iracema"* e *"A Moreninha"*. Para isso efetuou uma pesquisa de mercado e concluiu que, em cada $1000$ pessoas consultadas,
*   $600$ leram *A Moreninha*;
*   $400$ leram *Helena*;
*   $300$ leram *Iracema*;
*   $20$ leram as três obras;
*   $200$ leram *A Moreninha* e *Helena*;
*   $150$ leram *A Moreninha* e *Iracema*;
*   $100$ leram *Iracema* e *Helena*.

Determine:
*   **a)** O número de pessoas que leu apenas uma das três obras.
    *   *Resposta:* $460$
*   **b)** O número de pessoas que não leu nenhuma das três obras.
    *   *Resposta:* $130$
*   **c)** O número de pessoas que leu duas ou mais obras.
    *   *Resposta:* $410$
*   **d)** O número de pessoas que leu *Helena* ou *Iracema*.
    *   *Resposta:* $600$

### Questão 4 (Fafi - BH)
Durante a Segunda Guerra Mundial, os aliados tomaram um campo de concentração nazista e de lá resgataram $979$ prisioneiros. Desses, $527$ estavam com sarampo, $251$ com tuberculose e $321$ não tinham nenhuma destas duas doenças. Qual o número de prisioneiros com as duas doenças?
*   **Resposta:** $120$ prisioneiros.

### Questão 5 (UFLA - MG)
Numa comunidade são consumidos os tipos de leite $A$, $B$ e $C$. Feita uma pesquisa de mercado sobre o consumo desses produtos, foram colhidos os resultados:

| Tipo de Leite | $A$ | $B$ | $C$ | $A$ e $B$ | $B$ e $C$ | $A$ e $C$ | $A$, $B$ e $C$ | Nenhum |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Consumidores** | $100$ | $150$ | $200$ | $20$ | $40$ | $30$ | $10$ | $160$ |

Determine quantas pessoas:
*   **a)** Foram consultadas.
    *   *Resposta:* $530$
*   **b)** Consomem apenas dois tipos de leite.
    *   *Resposta:* $60$
*   **c)** Não consomem o leite tipo $B$.
    *   *Resposta:* $380$
*   **d)** Não consomem o leite tipo $A$ ou não consomem o leite tipo $B$.
    *   *Resposta:* $510$

---

## 3. Operações com Intervalos

> [!TIP]
> A notação de colchetes invertidos foi mantida para representar intervalos abertos, conforme o material original (ex: $\left] a, b \right[$).

### Questão 1
Sendo $A = \left] -3, 4 \right[$ e $B = \left[ -1, 6 \right[$, calcule $A \cup B$, $A \cap B$ e $A - B$, dando a resposta em notação de conjunto.
*   **Resposta:** 
    *   $A \cup B = \{x \in \mathbb{R} \mid -3 < x < 6\}$
    *   $A \cap B = \{x \in \mathbb{R} \mid -1 \leq x < 4\}$
    *   $A - B = \{x \in \mathbb{R} \mid -3 < x < -1\}$

### Questão 2
Dados $A = \left] -4, 3 \right]$, $B = \left[ -3, 3 \right[$ e $C = \left[ -7, 0 \right]$, calcule o conjunto:
$$ (A \cup B) \cap (B \cup C) $$
*   **Resposta:** $\{x \in \mathbb{R} \mid -4 < x < 3\}$

### Questão 3
Considerando $A = \left] -\infty, 3 \right]$, $B = \left[ -2, 0 \right]$ e $C = \{x \in \mathbb{R} \mid x \geq 0\}$, determine:
$$ (A \cup B) \cap (B \cap C) $$
*   **Resposta:** $\{0\}$

### Questão 4
Dados $A = \left[ 1, 3 \right]$, $B = \left] 2, 5 \right[$ e $C = \left] 0, 4 \right]$, calcule, escrevendo a resposta em notação de conjunto:
*   **a)** $C \cap (A \cup B)$
    *   *Resposta:* $\{x \in \mathbb{R} \mid 1 \leq x \leq 4\}$
*   **b)** $A \cap B \cap C$
    *   *Resposta:* $\{x \in \mathbb{R} \mid 2 < x \leq 3\}$
*   **c)** $A \cup B \cup C$
    *   *Resposta:* $\{x \in \mathbb{R} \mid 0 < x < 5\}$
*   **d)** $(A \cap B) - C$
    *   *Resposta:* $\varnothing$ ou $\{\}$

### Questão 5
Sendo $A = \left[ 2, +\infty \right[$, $B = \left] -\infty, 5 \right[$ e $M = \left[ 2, 5 \right]$, efetue:
*   **a)** $A \cup B$
    *   *Resposta:* $\mathbb{R}$
*   **b)** $A \cap B$
    *   *Resposta:* $\{x \in \mathbb{R} \mid 2 \leq x < 5\}$
*   **c)** $B \cup M$
    *   *Resposta:* $\{x \in \mathbb{R} \mid x \leq 5\}$
*   **d)** $B - M$
    *   *Resposta:* $\{x \in \mathbb{R} \mid x < 2\}$

### Questão 6
Obtenha $M \cap N$ e $M \cup N$ sendo:
$$ M = \{x \in \mathbb{R} \mid x \leq -2 \text{ ou } x \geq 1\} $$
$$ N = \{x \in \mathbb{R} \mid -4 < x \leq 3\} $$
*   **Resposta:**
    *   $M \cap N = \{x \in \mathbb{R} \mid -4 < x \leq -2 \text{ ou } 1 \leq x \leq 3\}$
    *   $M \cup N = \mathbb{R}$

### Questão 7
Obtenha $G \cap H$ e $G \cup H$ nos casos:
$$ G = \{x \in \mathbb{R} \mid -\sqrt{5} < x \leq \sqrt{10}\} $$
$$ H = \{x \in \mathbb{R} \mid x < -3 \text{ ou } x \geq \sqrt{10}\} $$
*   **Resposta:**
    *   $G \cap H = \{\sqrt{10}\}$
    *   $G \cup H = \{x \in \mathbb{R} \mid x < -3 \text{ ou } x > -\sqrt{5}\}$

### Questão 8
Considere os intervalos $A = \left[ -1, +\infty \right[$ e $B = \left] 0, 7 \right[$. Obtenha:
*   **a)** $A - B$
    *   *Resposta:* $\{x \in \mathbb{R} \mid -1 \leq x \leq 0 \text{ ou } x \geq 7\}$
*   **b)** $A \cup B$
    *   *Resposta:* $\{x \in \mathbb{R} \mid x \geq -1\} = A$
*   **c)** $A \cap B$
    *   *Resposta:* $\{x \in \mathbb{R} \mid 0 < x < 7\} = B$
*   **d)** $B - (A - B)$
    *   *Resposta:* $B$

### Questão 9
Sendo $M = \left[ -3, 3 \right]$, $A = \left] 0, 5 \right]$ e $T = \left[ 6, 8 \right]$, determine o conjunto:
$$ S = (M \cap A \cap T) - M $$
*   **Resposta:** $S = \varnothing$

### Questão 10
Dados $A = \left] 1, 4 \right]$, $B = \left] 2, 8 \right[$ e $C = \left[ 4, 10 \right]$, determine:
*   **a)** $A \cup B \cup C$
    *   *Resposta:* $\{x \in \mathbb{R} \mid 1 < x \leq 10\}$
*   **b)** $A \cap B \cap C$
    *   *Resposta:* $\{4\}$
*   **c)** $(A \cap B) - C$
    *   *Resposta:* $\{x \in \mathbb{R} \mid 2 < x < 4\}$

### Questão 11
Se $A = \{x \in \mathbb{N} \mid x \text{ é múltiplo de } 11\}$ e $B = \{x \in \mathbb{R} \mid 15 \leq x < 187\}$, determine o número de elementos de $(B \cap A)$.
*   **Resposta:** $n(B \cap A) = 15$
