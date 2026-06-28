# Anotações - Prova 2 (Análise Numérica)

**Questão 1:** Dê evidências teóricas de que o método de Gauss-Seidel convergirá, se for aplicado a:
$$
\begin{cases}
8x_1 - x_2 = 2 \\
x_1 - 8x_2 + 2x_3 = 2 \\
x_2 - 8x_3 = 2.
\end{cases}
$$
Obtenha uma solução aproximada, com erro percentual relativo de no máximo $1\%$, considerando $X^{(0)} = (-1.0000, 0.0000, 1.0000)$ e arredondando cada resultado com 4 dígitos após a vírgula.

**Resposta:**
Considerando que $|8| > |-1| + |0|$, $|-8| > |1| + |2|$ e $|-8| > |0| + |1|$, a matriz de coeficientes do sistema é estritamente diagonalmente dominante, e portanto o método convergirá, qualquer que seja a aproximação inicial escolhida. As equações utilizadas no método de Gauss-Seidel são as seguintes:
$$
\begin{cases}
x_1^{(k)} = (2 + x_2^{(k-1)})/8 \\
x_2^{(k)} = (-2 + x_1^{(k)} + 2x_3^{(k-1)})/8 \\
x_3^{(k)} = (-2 + x_2^{(k)})/8
\end{cases}
$$
Os valores obtidos a cada iteração são os seguintes:

| $k$ | 0 | 1 | 2 | 3 | 4 |
|---|---|---|---|---|---|
| $x_1^{(k)}$ | -1,0000 | 0,2500 | 0,2539 | 0,2150 | 0,2132 |
| $x_2^{(k)}$ | 0,0000 | 0,0313 | -0,2798 | -0,2944 | -0,2951 |
| $x_3^{(k)}$ | 1,0000 | -0,2461 | -0,2850 | -0,2868 | -0,2869 |
| $\varepsilon_{abs}$ | - | 1,2500 | 0,3111 | 0,0389 | 0,0018 |
| $\varepsilon_{per}$ | - | 500,00% | 109,16% | 13,21% | 0,61% |

**Questão 2:** Considere o seguinte sistema não linear:
$$
\begin{cases}
10x_1 - x_1^2 - x_2^2 = 1 \\
4x_1 - 3x_2^2 - 12x_2 = 0
\end{cases}
$$
(a) Reescreva o sistema na forma de um problema de ponto fixo, $X = \varphi(X)$. (obs.: $X = (x_1, x_2) \in \mathbb{R}^2$ e $\varphi(X) = (\varphi_1(X), \varphi_2(X)) \in \mathbb{R}^2$).
(b) Seja $Q = \{(x_1, x_2) \in \mathbb{R}^2 \mid 0 \le x_i \le 1\}$. Verifique se $\varphi(X) \in Q$ sempre que $X \in Q$. O que isso diz sobre a existência de um ponto fixo de $\varphi$ em $Q$?
(c) Obtenha uma solução aproximada $X^{(3)}$ do sistema, pelo método de iteração de ponto fixo, partindo da aproximação inicial $X^{(0)} = (x_1^{(0)}, x_2^{(0)}) = (0.0000, 0.0000)$. (arredonde cada iteração com 4 dígitos após a vírgula).

**Resposta:**
**(a)** O sistema é equivalente a:
$$
\begin{cases}
x_1 = (x_1^2 + x_2^2 + 1)/10 \\
x_2 = \frac{4x_1}{3x_2 + 12}
\end{cases}
$$
Assim, pode-se considerar $\varphi(x_1, x_2) = (\varphi_1(x_1, x_2), \varphi_2(x_1, x_2)) = \left( \frac{x_1^2 + x_2^2 + 1}{10}, \frac{4x_1}{3x_2 + 12} \right)$.
Alternativamente, a função $\varphi_2$ poderia ser definida por:
$\varphi_2(x_1, x_2) = \frac{4x_1 - 3x_2^2}{12}$ ou $\varphi_2(x_1, x_2) = \frac{4x_1 - 12x_2}{3x_2}$ ou $\varphi_2(x_1, x_2) = \sqrt{\frac{4x_1 - 12x_2}{3}}$
**(b)** Para quaisquer $x_1$ e $x_2$ tais que $0 \le x_1 \le 1$ e $0 \le x_2 \le 1$, tem-se:
$\bullet$ $\varphi_1(x_1, x_2) \in [0, 1]$, pois $\frac{1}{10} \le \frac{x_1^2 + x_2^2 + 1}{10} \le \frac{3}{10}$.
$\bullet$ $\varphi_2(x_1, x_2) \in [0, 1]$, pois $0 \le \frac{4x_1}{3x_2 + 12} \le \frac{1}{3}$.
Assim, $\varphi(x_1, x_2) \in Q$ sempre que $(x_1, x_2) \in Q$.
*(Observação: se $\varphi_2$ fosse uma das outras escolhas mencionadas no item anterior, não seria verdade que $\varphi(x_1, x_2) \in Q$ sempre que $(x_1, x_2) \in Q$, logo não haveria a garantia de que há um ponto fixo).*
**(c)** Estas são as aproximações obtidas nas primeiras iterações do método do ponto fixo:

| $k$ | 0 | 1 | 2 | 3 |
|---|---|---|---|---|
| $x_1^{(k)}$ | 0,0000 | 0,1000 | 0,1010 | 0,1011 |
| $x_2^{(k)}$ | 0,0000 | 0,0000 | 0,0333 | 0,0334 |

**Questão 3:** Ao baixar algumas ferramentas de desenvolvimento a partir da internet, um programador percebeu que a velocidade de download estava diminuindo com o passar do tempo. Uma hora após o início do download, só tinham sido baixados 450 MB. Depois de mais uma hora, o total baixado ainda era de 800 MB, e nas duas horas seguintes, finalmente chegou a 1050 MB e 1200 MB, respectivamente. Sabendo que a transferência de dados durou 5 horas, e considerando o quanto havia sido baixado após 0, 1, 2, 3 e 4 horas, estime o tamanho das ferramentas baixadas:
(a) Usando o polinômio interpolador obtido por diferenças divididas (forma de Newton).
(b) Utilizando a reta que melhor se ajusta, por mínimos quadrados.

**Resposta:**
**(a)** A partir dos pontos dados, obtém-se:

| $x_i$ | $y_i = f[x_i]$ | $f[x_i, x_{i+1}]$ | $f[x_i, x_{i+1}, x_{i+2}]$ | $f[x_i, \dots, x_{i+3}]$ | $f[x_i, \dots, x_{i+4}]$ |
|---|---|---|---|---|---|
| 0 | 0 | | | | |
| | | 450 | | | |
| 1 | 450 | | -50 | | |
| | | 350 | | 0 | |
| 2 | 800 | | -50 | | 0 |
| | | 250 | | 0 | |
| 3 | 1050 | | -50 | | |
| | | 150 | | | |
| 4 | 1200 | | | | |

Então:
$$p(x) = 0 + 450x - 50x(x - 1) + 0x(x - 1)(x - 1) + 0x(x - 1)(x - 1)(x - 3) = -50x^2 + 500x$$
Usando este polinômio para estimar o valor pedido ($x=5$), resulta que:
$$p(5) = -50 \cdot 5^2 + 500 \cdot 5 = -50 \cdot 25 + 2500 = 1250$$

**(b)** Sejam $P_0 = (0,0), P_1 = (1,450), P_2 = (2,800), P_3 = (3,1050)$ e $P_4 = (4,1200)$ e denote $g_0(x) = 1, g_1(x) = x$. Para encontrar uma função da forma $r(x) = a_0 g_0(x) + a_1 g_1(x)$ que melhor se ajusta aos pontos $P_i = (x_i, y_i)$, basta resolver o sistema $A^T A X = A^T B$, em que:

$$A^T A = \begin{bmatrix} 5 & \sum_{i=1}^5 x_i \\ \sum_{i=1}^5 x_i & \sum_{i=1}^5 x_i^2 \end{bmatrix} = \begin{bmatrix} 1 & 1 & 1 & 1 & 1 \\ 0 & 1 & 2 & 3 & 4 \end{bmatrix} \cdot \begin{bmatrix} 1 & 0 \\ 1 & 1 \\ 1 & 2 \\ 1 & 3 \\ 1 & 4 \end{bmatrix} = \begin{bmatrix} 5 & 10 \\ 10 & 30 \end{bmatrix}$$

$$A^T B = \begin{bmatrix} \sum_{i=1}^5 y_i \\ \sum_{i=1}^5 x_i y_i \end{bmatrix} = \begin{bmatrix} 1 & 1 & 1 & 1 & 1 \\ 0 & 1 & 2 & 3 & 4 \end{bmatrix} \cdot \begin{bmatrix} 0 \\ 450 \\ 800 \\ 1050 \\ 1200 \end{bmatrix} = \begin{bmatrix} 3500 \\ 10000 \end{bmatrix}$$

Então, $A^T A X = A^T B \iff \begin{bmatrix} 5 & 10 \\ 10 & 30 \end{bmatrix} \cdot \begin{bmatrix} a_0 \\ a_1 \end{bmatrix} = \begin{bmatrix} 3500 \\ 10000 \end{bmatrix} \iff \begin{bmatrix} a_0 \\ a_1 \end{bmatrix} = \begin{bmatrix} 100 \\ 300 \end{bmatrix}$.

Portanto, a reta é $r(x) = 100 + 300x$ e $r(5) = 100 + 300 \cdot 5 = 1600$.

**Questão 4:** Obtenha, pelo método de Lagrange, o polinômio $p(x)$ que interpola $f(x) = x^4 + 2x - 1$ em $x_0 = -1, x_1 = 0$ e $x_2 = 1$. Estime o erro absoluto máximo ao aproximar $f(x)$ por $p(x)$ no intervalo $[-1, 1]$.

**Resposta:**
Considerando que $f(-1) = -2$, $f(0) = -1$ e $f(1) = 2$, o método de Lagrange permite que o polinômio que interpola $f$ nestes pontos seja descrito da seguinte forma:
$$p(x) = -2 L_0(x) - 1 L_1(x) + 2 L_2(x)$$
$$p(x) = -2 \frac{(x - 0)(x - 1)}{(-1 - 0)(-1 - 1)} - 1 \frac{(x + 1)(x - 1)}{(0 + 1)(0 - 1)} + 2 \frac{(x + 1)(x - 0)}{(1 + 1)(1 - 0)}$$
$$p(x) = -2 \left( \frac{x^2 - x}{2} \right) - 1 (1 - x^2) + 2 \left( \frac{x^2 + x}{2} \right)$$
$$p(x) = x^2 + 2x - 1$$

Logo, o erro de aproximação se dá por:
$$f(x) = (x^2 + 2x - 1) + \frac{f^{(3)}(\xi(x))}{3!} (x + 1)x(x - 1)$$

Como $f'(x) = 4x^3 + 2$, $f''(x) = 12x^2$ e $f^{(3)}(x) = 24x$, tem-se em particular que:
$$\varepsilon_{abs}(x) = |f(x) - (x^2 + 2x - 1)| \le \frac{M}{3!} |(x + 1)x(x - 1)|$$
em que $M = \max_{x \in [-1, 1]} |f^{(3)}(x)| = \max_{x \in [-1, 1]} |24x| = 24$.

Além disso, se $q(x) = (x + 1)x(x - 1) = x^3 - x$, então $q'(x) = 3x^2 - 1 = 0$ se, e somente se, $x = \pm \frac{\sqrt{3}}{3}$, o que significa que os valores máximo e mínimo de $q(x)$ em $[-1, 1]$ ocorrem em um dos pontos $\{\pm 1, \pm \frac{\sqrt{3}}{3}\}$.
Como $q(\pm 1) = 0$ e $q\left(\pm \frac{\sqrt{3}}{3}\right) \approx \mp 0.3849$, e $q''\left(\pm \frac{\sqrt{3}}{3}\right) = \pm 2\sqrt{3}$, conclui-se que $-\frac{\sqrt{3}}{3}$ é um ponto de máximo, $\frac{\sqrt{3}}{3}$ é um ponto de mínimo, e o valor máximo de $|q(x)|$ é $0.3849$. Portanto,

$$\varepsilon_{abs}(x) \le \frac{24}{6} |x^3 - x| \le 4 \cdot \max_{x \in [-1, 1]} |x^3 - x| = 4 \cdot 0.3849 = 1.5396.$$
