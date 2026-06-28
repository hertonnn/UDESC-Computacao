# Inequações

## Introdução

Uma **inequação** é uma sentença matemática expressa por uma relação de desigualdade entre duas expressões algébricas.
* **Sinais de Desigualdade**:
  * $>$ (maior que)
  * $<$ (menor que)
  * $\ge$ (maior ou igual a)
  * $\le$ (menor ou igual a)
  * $\ne$ (diferente de)
* **Exemplos**:
  * $5x^3 \ge 2x + 4$
  * $\frac{5y - 2}{8} < 2 + \frac{y}{4}$
  * $(2x - 1)^2 \ne 9$

Tal como nas equações, o objetivo é encontrar o conjunto de valores da incógnita (chamado **conjunto solução**) que tornam a sentença verdadeira.

---

## Inequações Lineares com uma Variável

### Definição: Inequação linear em $x$
Uma **inequação linear em $x$** é toda desigualdade que pode ser escrita em uma das formas:
$$ax + b < 0, \qquad ax + b \le 0, \qquad ax + b > 0, \qquad ax + b \ge 0$$
onde $a$ e $b$ são números reais e $a \ne 0$.

---

## Propriedades das Inequações
Sejam $u, v, w, z$ expressões algébricas (ou números reais) e $c$ um número real.

1. **Transitiva**:
   $$\text{Se } u < v \text{ e } v < w, \text{ então } u < w.$$
2. **Adição**:
   * Se $u < v$, então $u + w < v + w$.
   * Se $u < v$ e $w < z$, então $u + w < v + z$.
3. **Multiplicação**:
   * **Por número positivo ($c > 0$)**: preserva o sentido da desigualdade.
     $$\text{Se } u < v \text{ e } c > 0, \text{ então } uc < vc.$$
   * **Por número negativo ($c < 0$)**: inverte o sentido da desigualdade.
     $$\text{Se } u < v \text{ e } c < 0, \text{ então } uc > vc.$$

> [!IMPORTANT]
> A multiplicação ou divisão de ambos os lados de uma inequação por um número **negativo** exige que se **inverta o sentido do sinal** da desigualdade.

---

### Exemplo 1: Resolução de inequação linear
Resolva a inequação:
$$3(x - 1) + 2 \le 5x + 6$$

1. **Distribuição**:
   $$3x - 3 + 2 \le 5x + 6$$
   $$3x - 1 \le 5x + 6$$
2. **Isolando os termos em $x$**:
   $$3x - 5x \le 6 + 1$$
   $$-2x \le 7$$
3. **Multiplicação por $-1$ e inversão do sinal**:
   $$2x \ge -7 \implies x \ge -\frac{7}{2}$$
* **Solução**: $S = \left\{ x \in \mathbb{R} \;\middle|\; x \ge -\frac{7}{2} \right\}$ ou $\left[ -\frac{7}{2}, +\infty \right[$.

---

### Exemplo 2: Resolução de inequação linear com frações
Resolva a inequação:
$$\frac{x}{3} + \frac{1}{2} > \frac{x}{4} + \frac{1}{3}$$

1. **MMC dos denominadores** ($3, 2, 4$): o MMC é $12$. Reduzindo todas as frações:
   $$\frac{4x}{12} + \frac{6}{12} > \frac{3x}{12} + \frac{4}{12}$$
   $$\frac{4x + 6}{12} > \frac{3x + 4}{12}$$
2. **Multiplicação por $12$ (cancelando os denominadores)**:
   $$4x + 6 > 3x + 4$$
3. **Isolando $x$**:
   $$4x - 3x > 4 - 6 \implies x > -2$$
* **Solução**: $S = \{x \in \mathbb{R} \mid x > -2\}$ ou $]-2, +\infty[$.

---

### Exemplo 3: Resolução de inequação dupla
Inequações duplas possuem a variável sob duas restrições simultâneas. Podem ser resolvidas aplicando as mesmas operações algébricas em todos os três membros ao mesmo tempo.

Resolva a inequação:
$$-3 < \frac{2x+5}{3} \le 5$$

1. **Multiplicação por $3$** (para eliminar o denominador):
   $$-9 < 2x + 5 \le 15$$
2. **Subtração de $5$** em todos os membros:
   $$-9 - 5 < 2x \le 15 - 5$$
   $$-14 < 2x \le 10$$
3. **Divisão por $2$**:
   $$-\frac{14}{2} < x \le \frac{10}{2}$$
   $$-7 < x \le 5$$
* **Solução**: $S = \{x \in \mathbb{R} \mid -7 < x \le 5\}$ ou $]-7, 5]$.

---

## Inequações com Valor Absoluto

Seja $u$ uma expressão algébrica em $x$ e $a$ um número real com $a \ge 0$.

1. **Desigualdade do tipo "menor que"**:
   $$|u| < a \iff -a < u < a$$
   *(O conjunto solução é o intervalo aberto $]-a, a[$)*
2. **Desigualdade do tipo "maior que"**:
   $$|u| > a \iff u < -a \quad \text{ou} \quad u > a$$
   *(O conjunto solução é a união dos intervalos $]-\infty, -a[ \cup ]a, +\infty[$)*

*(As mesmas propriedades aplicam-se substituindo os sinais pelos correspondentes fracos $\le$ e $\ge$)*

---

### Exemplo 1: Inequação modular do tipo $|u| < a$
Resolva a inequação:
$$|x - 4| < 8$$

1. **Aplicação da propriedade**:
   $$-8 < x - 4 < 8$$
2. **Isolando a variável** (somando $4$ em todos os membros):
   $$-8 + 4 < x < 8 + 4$$
   $$-4 < x < 12$$
* **Solução**: $S = \{x \in \mathbb{R} \mid -4 < x < 12\}$ ou $]-4, 12[$.

---

### Exemplo 2: Inequação modular do tipo $|u| \ge a$
Resolva a inequação:
$$|3x - 2| \ge 5$$

1. **Aplicação da propriedade** (separação em dois casos):
   * **Caso 1**:
     $$3x - 2 \ge 5 \implies 3x \ge 7 \implies x \ge \frac{7}{3}$$
   * **Caso 2**:
     $$3x - 2 \le -5 \implies 3x \le -3 \implies x \le -1$$
2. **União dos casos**:
   $$x \le -1 \quad \text{ou} \quad x \ge \frac{7}{3}$$
* **Solução**: $S = \left\{x \in \mathbb{R} \;\middle|\; x \le -1 \text{ ou } x \ge \frac{7}{3}\right\}$ ou $]-\infty, -1] \cup \left[\frac{7}{3}, +\infty\right[$.

---

## Inequações Quadráticas

Uma inequação quadrática é resolvida determinando-se as raízes da equação quadrática correspondente e realizando-se o **estudo do sinal** da função parabólica.

---

### Exemplo 1: Duas raízes reais e concavidade para cima ($a > 0$)
Resolva a inequação:
$$x^2 - x - 12 > 0$$

1. **Raízes da equação associada** ($x^2 - x - 12 = 0$):
   $$\Delta = (-1)^2 - 4(1)(-12) = 1 + 48 = 49$$
   $$x = \frac{-(-1) \pm \sqrt{49}}{2(1)} = \frac{1 \pm 7}{2} \implies x' = 4, \quad x'' = -3$$
2. **Estudo de Sinal**:
   Como $a = 1 > 0$, a parábola está voltada para cima:
   * Positiva ($> 0$) para valores externos às raízes: $x < -3$ ou $x > 4$.
   * Negativa ($< 0$) para valores internos às raízes: $-3 < x < 4$.
   Como queremos a região onde a expressão é estritamente positiva:
* **Solução**: $S = \{x \in \mathbb{R} \mid x < -3 \text{ ou } x > 4\}$ ou $]-\infty, -3[ \cup ]4, +\infty[$.

---

### Exemplo 2: Desigualdade não estrita
Resolva a inequação:
$$2x^2 + 3x \le 20$$

1. **Forma geral**:
   $$2x^2 + 3x - 20 \le 0$$
2. **Raízes da equação associada**:
   $$\Delta = 3^2 - 4(2)(-20) = 9 + 160 = 169$$
   $$x = \frac{-3 \pm \sqrt{169}}{2(2)} = \frac{-3 \pm 13}{4} \implies x' = \frac{5}{2} = 2,5, \quad x'' = -4$$
3. **Estudo de Sinal**:
   Como $a = 2 > 0$, a concavidade é voltada para cima. Queremos a região menor ou igual a zero ($\le 0$), que corresponde ao intervalo fechado entre as duas raízes:
* **Solução**: $S = \left\{x \in \mathbb{R} \;\middle|\; -4 \le x \le \frac{5}{2}\right\}$ ou $\left[-4, \frac{5}{2}\right]$.

---

### Exemplo 3: Discriminante negativo ($\Delta < 0$)
Resolva a inequação:
$$x^2 + 2x + 2 < 0$$

1. **Discriminante da equação associada**:
   $$\Delta = 2^2 - 4(1)(2) = 4 - 8 = -4 < 0$$
   A equação não possui raízes reais.
2. **Estudo de Sinal**:
   Como $a = 1 > 0$ e não existem interseções com o eixo $x$, a parábola está inteiramente localizada acima do eixo $x$.
   Portanto, a expressão $x^2 + 2x + 2$ é positiva ($> 0$) para qualquer valor real de $x$.
   Como a inequação busca os valores menores que zero ($< 0$):
* **Solução**: $S = \emptyset$ (Não existem soluções reais).

---

## Inequações Produto e Quociente

Inequações produto ou quociente são expressões da forma $f(x) \cdot g(x) \gtrless 0$ ou $\frac{f(x)}{g(x)} \gtrless 0$. Devem ser resolvidas estudando-se o sinal de cada fator individualmente e construindo-se um **quadro de sinais** (ou varal de sinais) para aplicar as regras de sinais da multiplicação/divisão.

---

### Exemplo 1: Inequação Produto com 2 fatores lineares
Resolva a inequação:
$$(x - 1)(x + 2) > 0$$

1. **Estudo de sinal dos fatores**:
   * Fator 1: $f(x) = x - 1 \implies$ raiz $x = 1$. Função crescente: negativa para $x < 1$ e positiva para $x > 1$.
   * Fator 2: $g(x) = x + 2 \implies$ raiz $x = -2$. Função crescente: negativa para $x < -2$ e positiva para $x > -2$.
2. **Quadro de Sinais**:

   | Fator | $x < -2$ | $-2 < x < 1$ | $x > 1$ |
   | :--- | :---: | :---: | :---: |
   | $f(x) = x - 1$ | $-$ | $-$ | $+$ |
   | $g(x) = x + 2$ | $-$ | $+$ | $+$ |
   | **Produto** | $+$ | $-$ | $+$ |

   *(Bolinhas abertas em $-2$ e $1$ devido à desigualdade estrita $>$)*
* **Solução**: $S = \{x \in \mathbb{R} \mid x < -2 \text{ ou } x > 1\}$ ou $]-\infty, -2[ \cup ]1, +\infty[$.

---

### Exemplo 2: Inequação Produto com 3 fatores (um com coeficiente negativo)
Resolva a inequação:
$$x(x - 3)(-x + 1) \le 0$$

1. **Estudo de sinal dos fatores**:
   * $f(x) = x \implies$ raiz $x = 0$ (crescente).
   * $g(x) = x - 3 \implies$ raiz $x = 3$ (crescente).
   * $h(x) = -x + 1 \implies$ raiz $x = 1$ (decrescente: positiva para $x < 1$ e negativa para $x > 1$).
2. **Quadro de Sinais**:

   | Fator | $x < 0$ | $0 < x < 1$ | $1 < x < 3$ | $x > 3$ |
   | :--- | :---: | :---: | :---: | :---: |
   | $f(x) = x$ | $-$ | $+$ | $+$ | $+$ |
   | $g(x) = x - 3$ | $-$ | $-$ | $-$ | $+$ |
   | $h(x) = -x + 1$ | $+$ | $+$ | $-$ | $-$ |
   | **Produto** | $+$ | $-$ | $+$ | $-$ |

   *(Bolinhas fechadas em $0, 1$ e $3$ devido à desigualdade fraca $\le$)*
* **Solução**: $S = \{x \in \mathbb{R} \mid 0 \le x \le 1 \text{ ou } x \ge 3\}$ ou $[0, 1] \cup [3, +\infty[$.

---

### Exemplo 3: Inequação Quociente
Resolva a inequação:
$$\frac{x + 5}{x - 3} \le 0$$

1. **Estudo de sinal**:
   * Numerador: $f(x) = x + 5 \implies$ raiz $x = -5$.
   * Denominador: $g(x) = x - 3 \implies$ raiz $x = 3$.
2. **Restrição de Domínio**: $x - 3 \ne 0 \implies x \ne 3$.
3. **Quadro de Sinais**:

   | Fator | $x < -5$ | $-5 < x < 3$ | $x > 3$ |
   | :--- | :---: | :---: | :---: |
   | $f(x) = x + 5$ | $-$ | $+$ | $+$ |
   | $g(x) = x - 3$ | $-$ | $-$ | $+$ |
   | **Quociente** | $+$ | $-$ | $+$ |

   *(Bolinha fechada em $-5$ e bolinha aberta em $3$ devido à restrição do denominador)*
* **Solução**: $S = \{x \in \mathbb{R} \mid -5 \le x < 3\}$ ou $[-5, 3[$.

---

### Exemplo 4: Inequação mista
Resolva a inequação:
$$\frac{x - 1}{(x - 3)(2x + 8)} \le 0$$

1. **Estudo de sinal**:
   * $f(x) = x - 1 \implies$ raiz $x = 1$.
   * $g(x) = x - 3 \implies$ raiz $x = 3$.
   * $h(x) = 2x + 8 \implies$ raiz $x = -4$.
2. **Restrições**: $x \ne 3$ e $x \ne -4$.
3. **Quadro de Sinais**:

   | Fator | $x < -4$ | $-4 < x < 1$ | $1 < x < 3$ | $x > 3$ |
   | :--- | :---: | :---: | :---: | :---: |
   | $f(x) = x - 1$ | $-$ | $-$ | $+$ | $+$ |
   | $g(x) = x - 3$ | $-$ | $-$ | $-$ | $+$ |
   | $h(x) = 2x + 8$ | $-$ | $+$ | $+$ | $+$ |
   | **Resultado** | $-$ | $+$ | $-$ | $+$ |

   *(Bolinha fechada em $1$; bolinhas abertas em $-4$ e $3$)*
* **Solução**: $S = \{x \in \mathbb{R} \mid x < -4 \text{ ou } 1 \le x < 3\}$ ou $]-\infty, -4[ \cup [1, 3[$.

---

### Exemplo 5: Inequação mista 2
Resolva a inequação:
$$\frac{(x + 1)(x + 4)}{x - 2} > 0$$

1. **Estudo de sinal**:
   * $f(x) = x + 1 \implies$ raiz $x = -1$.
   * $g(x) = x + 4 \implies$ raiz $x = -4$.
   * $h(x) = x - 2 \implies$ raiz $x = 2$.
2. **Restrições**: $x \ne 2$.
3. **Quadro de Sinais**:

   | Fator | $x < -4$ | $-4 < x < -1$ | $-1 < x < 2$ | $x > 2$ |
   | :--- | :---: | :---: | :---: | :---: |
   | $f(x) = x + 1$ | $-$ | $-$ | $+$ | $+$ |
   | $g(x) = x + 4$ | $-$ | $+$ | $+$ | $+$ |
   | $h(x) = x - 2$ | $-$ | $-$ | $-$ | $+$ |
   | **Resultado** | $-$ | $+$ | $-$ | $+$ |

   *(Bolinhas abertas em $-4, -1$ e $2$ devido à desigualdade estrita $>$)*
* **Solução**: $S = \{x \in \mathbb{R} \mid -4 < x < -1 \text{ ou } x > 2\}$ ou $]-4, -1[ \cup ]2, +\infty[$.

---

### Exemplo 6: Produto de fatores quadráticos
Resolva a inequação:
$$(x^2 - 8x + 12)(x^2 - 5x) < 0$$

1. **Estudo de sinal dos fatores quadráticos**:
   * **Fator 1: $f(x) = x^2 - 8x + 12$**
     Raízes: $x' = 6, \ x'' = 2$ (Bhaskara). Como $a = 1 > 0$, a expressão é negativa no intervalo aberto entre as raízes $]2, 6[$ e positiva fora.
   * **Fator 2: $g(x) = x^2 - 5x = x(x - 5)$**
     Raízes: $x' = 0, \ x'' = 5$. Como $a = 1 > 0$, a expressão é negativa no intervalo aberto $]0, 5[$ e positiva fora.
2. **Quadro de Sinais**:

   | Fator | $x < 0$ | $0 < x < 2$ | $2 < x < 5$ | $5 < x < 6$ | $x > 6$ |
   | :--- | :---: | :---: | :---: | :---: | :---: |
   | $f(x) = x^2 - 8x + 12$ | $+$ | $+$ | $-$ | $-$ | $+$ |
   | $g(x) = x^2 - 5x$ | $+$ | $-$ | $-$ | $+$ | $+$ |
   | **Produto** | $+$ | $-$ | $+$ | $-$ | $+$ |

   *(Bolinhas abertas em $0, 2, 5$ e $6$)*
* **Solução**: $S = \{x \in \mathbb{R} \mid 0 < x < 2 \text{ ou } 5 < x < 6\}$ ou $]0, 2[ \cup ]5, 6[$.
