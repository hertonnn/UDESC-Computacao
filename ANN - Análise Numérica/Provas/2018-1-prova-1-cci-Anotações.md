# Anotações - Prova 1 (Análise Numérica)

**Questão 1:** Considere o valor $\overline{x} = \frac{618}{50}$.
(a) Determine a representação binária de $\overline{x}$, contendo 8 algarismos corretos após a vírgula.
(b) Quantos algarismos binários após a vírgula são exigidos para representar $\overline{x}$ de modo que o erro relativo percentual seja menor que $5\%$?

**Resposta:**
(a) Observe que $\overline{x} = \frac{618}{50} = 12,36 = 12 + 0,36$.
A parte inteira: $12 = 8 + 4 = 1\cdot 2^3 + 1\cdot 2^2 + 0\cdot 2^1 + 0\cdot 2^0 = (1100)_2$.
Para a parte fracionária:

| $x$ | 0,36 | 0,72 | 0,44 | 0,88 | 0,76 | 0,52 | 0,04 | 0,08 |
|---|---|---|---|---|---|---|---|---|
| $2 \cdot x$ | 0,72 | 1,44 | 0,88 | 1,76 | 1,52 | 1,04 | 0,08 | 0,16 |

Logo, $\overline{x} = (12,36)_{10} \approx (1100,01011100)_2$.

(b) Ao truncar $\overline{x} = 12,36$ (na resolução original do professor considera $12,65$ como contra-exemplo, mas a raiz da conta para a tolerância é a mesma) para o inteiro $x = 12$, o erro relativo percentual é:
$$\varepsilon_{per} = \frac{|12 - 12,36|}{|12,36|} \times 100\% = \frac{|-0,36|}{|12,36|} \times 100\% \approx 2,91\%$$
Como o erro de $2,91\%$ já é menor que $5\%$, conclui-se que não são necessários dígitos após a vírgula ($0$ dígitos).

**Questão 2:** Seja a função $f(x) = \ln(x) - \frac{1}{x}$ e o ponto inicial $x_0 = 2$.
(a) Prove que $\varphi_1(x) = \frac{1}{\ln(x)}$ é uma função de iteração válida para $f(x) = 0$.
(b) Avalie se é garantida a convergência da sequência $x_k = \varphi_1(x_{k-1})$ para alguma raiz $\overline{x}$ onde $f(\overline{x}) = 0$. Se a convergência for garantida, determine o erro relativo percentual de $x_5$.
(c) Prove que $\varphi_2(x) = x - x \cdot f(x)$ é uma função de iteração válida para $f(x) = 0$.
(d) Avalie se é garantida a convergência da sequência $x_k = \varphi_2(x_{k-1})$ para alguma raiz $\overline{x}$ onde $f(\overline{x}) = 0$. Se a convergência for garantida, determine o erro relativo percentual de $x_5$.
*(Observação: nos itens (b) e (d), arredonde os valores de $\varphi_i(x)$ utilizando 4 casas decimais).*

**Resposta:**
(a) $f(x) = 0 \iff \ln(x) - \frac{1}{x} = 0 \iff \ln(x) = \frac{1}{x} \iff x = \frac{1}{\ln(x)}$.
(b) Derivando, temos $\varphi'_1(x) = -\frac{1}{x(\ln(x))^2}$. Como $|\varphi'_1(2)| = \left| -\frac{1}{2(\ln(2))^2} \right| \approx 1,0407 > 1$, não é possível garantir a convergência a partir desta aproximação inicial.
(c) $f(x) = 0 \iff x f(x) = 0 \iff x f(x) + x = x \iff x = x - x f(x) = \varphi_2(x)$.
(d) Como $\varphi'_2(x) = x + 1 - x\ln(x)$, sua derivada é $\varphi'_2(x)' = -\ln(x)$.
Assim, $|\varphi'_2(x)| < 1 \iff |- \ln(x)| < 1 \iff -1 < \ln(x) < 1 \iff 0,3679 \approx e^{-1} < x < e^1 \approx 2,7183$.
Considerando a continuidade, a sequência converge para $x \in I = (e^{-1}, e)$. As iterações resultam em:

| $k$ | 0 | 1 | 2 | 3 | 4 | 5 |
|---|---|---|---|---|---|---|
| $x_k = \varphi_2(x_{k-1})$ | 2,0000 | 1,6137 | 1,8415 | 1,7171 | 1,7888 | 1,7486 |

O erro relativo percentual em $x_5$ é $\varepsilon_{per} \approx \frac{|1,7486 - 1,7888|}{|1,7486|} \times 100 \approx 2,2990\%$.

**Questão 3:** Encontre a raiz real única do polinômio $p(x) = x^5 - x^3 + x + 2$ garantindo um erro absoluto estimado inferior a $10^{-3}$. Utilize o método de Newton (em sua versão para polinômios) e arredonde os resultados para 4 casas decimais.

**Resposta:** As sucessivas aplicações do algoritmo de Briot-Ruffini para o polinômio e sua derivada produzem as seguintes aproximações:
- $x_0 = -1$ gera $p(x_0) = 1$ e $p'(x_0) = 3$. Então $x_1 = -1 - \frac{1}{3} \approx -1,3333$.
- $x_1 = -1,3333$ gera $p(x_1) = -1,1766$ e $p'(x_1) = 11,4679$. Então $x_2 = -1,3333 + \frac{1,1766}{11,4679} \approx -1,2307$.
- $x_2 = -1,2307$ gera $p(x_2) = -0,1899$ e $p'(x_2) = 7,9264$. Então $x_3 \approx -1,2067$.
- A iteração $x_3$ gera $p(x_3) = -0,0082$ e $p'(x_3) = 7,2330$. Então $x_4 \approx -1,2067$.
Como o erro estimado é $|x_4 - x_3| = 0 < 10^{-3}$, $x_4 = -1,2067$ é a aproximação procurada.

**Questão 4:** Determine um intervalo que contenha um zero $\overline{x} > 1/2$ para a função $f(x) = \cos(\ln(x))$. Em seguida, empregue o método da posição falsa para encontrar uma aproximação $x_k \approx \overline{x}$ de tal forma que $|f(x_k)| < 0,0001$.

**Resposta:**
Valores de teste para o Bolzano:
| $x$ | 2 | 3 | 4 | 5 |
|---|---|---|---|---|
| $f(x)$ | 0,76924 | 0,45483 | 0,18346 | -0,03863 |

Portanto, uma raiz está no intervalo $[4, 5]$. Pelo método da posição falsa iterando:

| $k$ | $a_k$ | $x_k$ | $b_k$ | $f(a_k)$ | $f(x_k)$ | $f(b_k)$ |
|---|---|---|---|---|---|---|
| 0 | 4 | 4,82606 | 5 | 0,18346 | -0,00323 | -0,03863 |
| 1 | 4 | 4,81177 | 4,82606 | 0,18346 | -0,00027 | -0,00323 |
| 2 | 4 | 4,81058 | 4,81177 | 0,18346 | -0,00002 | -0,00027 |

Nesta etapa, $|f(x_2)| \approx 0,00002 < 0,0001$. Logo, a aproximação é $x_2 = 4,81058$.

**Questão 5:** Aplique o método da bisseção para localizar uma raiz da função $f(x) = \cos(x)$ no intervalo $[a_0, b_0] = [0, 3]$, exigindo que o erro relativo percentual estimado seja inferior a $0,1\%$.

**Resposta:**
Iterações pelo método da bisseção:

| $k$ | $a_k$ | $x_k$ | $b_k$ | $f(x_k)$ | $\varepsilon_{per}$ |
|---|---|---|---|---|---|
| 0 | 0 | 1,5 | 3 | 0,07074 | - |
| 1 | 1,5 | 2,25 | 3 | -0,62817 | 33,33333% |
| 2 | 1,5 | 1,875 | 2,25 | -0,29953 | 20,00000% |
| ... | ... | ... | ... | ... | ... |
| 9 | 1,57032 | 1,57325 | 1,57618 | -0,00245 | 0,18624% |
| 10 | 1,57032 | 1,57179 | 1,57325 | -0,00099 | 0,09289% |

A iteração é parada em $k=10$ pois o erro relativo estimado $|x_{10} - x_9|/|x_{10}| \approx 0,09289\% < 0,1\%$. A aproximação obtida é $x_{10} = 1,57179$.
