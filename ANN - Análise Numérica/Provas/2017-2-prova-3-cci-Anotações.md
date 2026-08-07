# Anotações - Prova 3 (Análise Numérica)

**Questão 1:** Interprete geometricamente o método de Euler explícito e relacione essa interpretação com a fórmula recursiva utilizada pelo método.

**Resposta:** *(A solução do gabarito indica apenas a recomendação teórica: "Rever referências básicas de análise numérica e cálculo numérico".)*

**Questão 2:** Obtenha a reta que melhor se ajusta (por mínimos quadrados) aos seguintes pontos:
$A = (-1, 1)$, $B = (1, 3)$, $C = (2, 2)$, $D = (3, 4)$, $E = (5, 2)$.

**Resposta:** Sejam $A=(x_1,y_1), B=(x_2,y_2), C=(x_3,y_3), D=(x_4,y_4)$ e $E=(x_5,y_5)$ e denote $g_0(x) = 1, g_1(x) = x$. Para encontrar uma função da forma $f(x) = a_0 g_0(x) + a_1 g_1(x)$ que melhor se ajusta aos pontos $(x_i, y_i)$, basta resolver o sistema $A^T A X = A^T B$, em que:

$$
A^T A = \begin{bmatrix} 5 & \sum_{i=1}^5 x_i\\
\sum_{i=1}^5 x_i & \sum_{i=1}^5 x_i^2 \end{bmatrix} = \begin{bmatrix} 1 & 1 & 1 & 1 & 1\\
-1 & 1 & 2 & 3 & 5 \end{bmatrix} \cdot \begin{bmatrix} 1 & -1\\
1 & 1\\
1 & 2\\
1 & 3\\
1 & 5 \end{bmatrix} = \begin{bmatrix} 5 & 10\\
10 & 40 \end{bmatrix}
$$

$$
A^T B = \begin{bmatrix} \sum_{i=1}^5 y_i\\
\sum_{i=1}^5 x_i y_i \end{bmatrix} = \begin{bmatrix} 1 & 1 & 1 & 1 & 1\\
-1 & 1 & 2 & 3 & 5 \end{bmatrix} \cdot \begin{bmatrix} 1\\
3\\
2\\
4\\
2 \end{bmatrix} = \begin{bmatrix} 12\\
28 \end{bmatrix}
$$

Então, $A^T A X = A^T B \iff \begin{bmatrix} 5 & 10 \\ 10 & 40 \end{bmatrix} \cdot \begin{bmatrix} a_0 \\ a_1 \end{bmatrix} = \begin{bmatrix} 12 \\ 28 \end{bmatrix} \iff \begin{bmatrix} a_0 \\ a_1 \end{bmatrix} = \begin{bmatrix} 2 \\ 1/5 \end{bmatrix}$.

Portanto, a solução é $f(x) = 2 + \frac{x}{5} = 2 + 0.2x$.

**Questão 3:** Identifique qual é o melhor e o pior método para estimar $I = \int_{-3}^{3} \cos(x) dx$ (em termos do erro relativo), dado que o valor exato é $2\sin(3) \approx 0.2822400161$:
*(Configure sua calculadora para radianos)*
(a) Trapézios repetido em $3$ subintervalos.
(b) 3/8 de Simpson em um único intervalo.
(c) Gauss-Legendre com $4$ pontos.

**Resposta:**
**(a) Trapézios repetido (3 subintervalos):**

$$
I \approx \frac{2}{2} (\cos(-3) + 2\cos(-1) + 2\cos(1) + \cos(3)) \approx \mathbf{0.18122}
$$

$$
\varepsilon_{rel} = \frac{|0.18122 - 0.28224|}{|0.28224|} \approx \mathbf{0.3579}
$$

**(b) 3/8 de Simpson (1 único intervalo):**

$$
I \approx \frac{3}{8} \cdot 2 \cdot (\cos(-3) + 3\cos(-1) + 3\cos(1) + \cos(3)) \approx \mathbf{0.94637}
$$

$$
\varepsilon_{rel} = \frac{|0.94637 - 0.28224|}{|0.28224|} \approx \mathbf{2.3531}
$$

**(c) Gauss-Legendre (4 pontos):**
Fazendo a mudança de variáveis $x = 3t$ obtém-se: $\int_{-3}^3 \cos(x) dx = 3 \int_{-1}^1 \cos(3t) dt$. Então:

$$
I \approx 3 \cdot [0.347855 \cdot \cos(3 \cdot (-0.861136)) + 0.652145 \cdot \cos(3 \cdot (-0.339981))\\
+ 0.652145 \cdot \cos(3 \cdot 0.339981) + 0.347855 \cdot \cos(3 \cdot 0.861136)] \approx \mathbf{0.27771}
$$

$$
\varepsilon_{rel} = \frac{|0.27771 - 0.28224|}{|0.28224|} \approx \mathbf{0.0161}
$$

Portanto, a pior estimativa é a do método 3/8 de Simpson e a melhor é a do método de Gauss-Legendre.

**Questão 4:** Aplique o método de Romberg para obter uma estimativa $R_{4,4} \approx \int_{1}^{9} \ln(x) dx$, e o respectivo erro relativo percentual, considerando que o valor exato da integral é $9\ln(9) - 8$.

**Resposta:**
Calculando os termos $R_{k,j}$, obtêm-se:

- $R_{1,1} = \frac{8}{2} (\ln(1) + \ln(9)) = 8.788898$
- $R_{2,1} = \frac{4}{2} (\ln(1) + 2\ln(5) + \ln(9)) = 10.832201$
- $R_{2,2} = 10.832201 + \frac{10.832201 - 8.788898}{3} = 11.513302$
- $R_{3,1} = \frac{2}{2} (\ln(1) + 2[\ln(3) + \ln(5) + \ln(7)] + \ln(9)) = 11.505145$
- $R_{3,2} = 11.505145 + \frac{11.505145 - 10.832201}{3} = 11.729460$
- $R_{3,3} = 11.729460 + \frac{11.729460 - 11.513302}{15} = 11.743871$
- $R_{4,1} = \frac{1}{2} (\ln(1) + 2[\ln(2) + \ln(3) + \ln(4) + \ln(5) + \ln(6) + \ln(7) + \ln(8)] + \ln(9)) = 11.703215$
- $R_{4,2} = 11.703215 + \frac{11.703215 - 11.505145}{3} = 11.769238$
- $R_{4,3} = 11.769238 + \frac{11.769238 - 11.729460}{15} = 11.771890$
- $R_{4,4} = 11.771890 + \frac{11.771890 - 11.743871}{63} = 11.772335$

Os resultados anteriores são resumidos na tabela a seguir:

| $k$ | $R_{k,1}$ | $R_{k,2}$ | $R_{k,3}$ | $R_{k,4}$ |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **8.788898** | | | |
| 2 | 10.832201 | **11.513302** | | |
| 3 | 11.505145 | 11.729460 | **11.743871** | |
| 4 | 11.703215 | 11.769238 | 11.771890 | **11.772335** |

Portanto, a aproximação $R_{4,4} = 11.772335$ tem um erro relativo percentual de $-0.0228\%$.

**Questão 5:** Considere a equação diferencial $y'(t) = t/y(t)$. Use os métodos de Runge-Kutta de ordem 2 e 4 para estimar $y(t)$ conforme $t$ percorre o intervalo $[0, 1.5]$ com passos de tamanho $h = 0.5$, dada a condição inicial $y(0) = 0.1$. Identifique o(s) ponto(s) onde ocorre o maior erro absoluto, levando em conta que a solução exata é $y(t) = \sqrt{t^2 + 0.01}$.

**Resposta:**
Pelo método de Runge-Kutta de ordem 2, obtêm-se:

| $i$ | $t_i$ | $k_1$ | $k_2$ | $y_i$ | $y_{exato}(t_i)$ | $\varepsilon_i = \|y_i - y_{exato}(t_i)\|$ |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 0 | 0.00 | - | - | 0.100000 | 0.100000 | 0.000000 |
| 1 | 0.5 | 0.000000 | 5.000000 | 1.350000 | 0.509902 | 0.840098 |
| 2 | 1.0 | 0.370370 | 0.651387 | 1.605439 | 1.004988 | 0.600451 |
| 3 | 1.5 | 0.622883 | 0.782521 | 1.956790 | 1.503330 | 0.453460 |

Já pelo método de Runge-Kutta de ordem 4, obtêm-se:

| $i$ | $t_i$ | $k_1$ | $k_2$ | $k_3$ | $k_4$ | $y_i$ | $y_{exato}(t_i)$ | $\varepsilon_i = \|y_i - y_{exato}(t_i)\|$ |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 0 | 0.0 | - | - | - | - | 0.100000 | 0.100000 | 0.000000 |
| 1 | 0.5 | 0.000000 | 2.500000 | 0.344828 | 1.835442 | 0.727092 | 0.509902 | 0.217190 |
| 2 | 1.0 | 0.687671 | 0.834251 | 0.801578 | 0.886618 | 1.130921 | 1.004988 | 0.125933 |
| 3 | 1.5 | 0.884235 | 0.924570 | 0.917725 | 0.943525 | 1.590284 | 1.503330 | 0.086954 |

Em ambos os casos pode-se observar que o erro absoluto diminui conforme $t_i$ se afasta de $t_0$. Portanto, o maior erro ocorre em $t_1 = 0.5$.
