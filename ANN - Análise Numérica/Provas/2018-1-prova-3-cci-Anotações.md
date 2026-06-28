# Anotações - Prova 3 (Análise Numérica)

**Questão 1:** Explique o funcionamento e as vantagens do método de Newton-Cotes adaptável.

**Resposta:**
Neste método, depois de aproximar o valor de $\int_a^b f(x) dx$, é feita uma estimativa do erro cometido nesta aproximação. Se o erro é maior do que o desejado, o intervalo é subdividido ao meio, e são calculadas aproximações individuais para $\int_a^{\frac{a+b}{2}} f(x) dx$ e $\int_{\frac{a+b}{2}}^b f(x) dx$.
Em cada caso, o erro cometido é avaliado, e usado como critério para decidir se algum dos intervalos (ou ambos) precisa ser dividido ao meio novamente. O processo se repete até que a soma das aproximações das integrais nos subintervalos considerados esteja próxima o bastante do valor exato da integral em $[a, b]$. Uma vantagem deste tipo de abordagem é que ele evita calcular $f(x)$ desnecessariamente em regiões onde é possível alcançar uma boa aproximação sem usar muitos pontos.

**Questão 2:** Seja $f(x) = 1 - x^4$. Se for utilizada a regra 1/3 de Simpson com repetição, qual será o menor número de **pontos** distintos em que $f$ precisará ser calculada para que o erro relativo percentual ao aproximar $\int_{-1}^1 f(x) dx$ seja de no máximo $1\%$?
*(Utilize números decimais com 4 dígitos após a vírgula)*

**Resposta:**
O valor exato da integral é:
$$\int_{-1}^1 (1 - x^4) dx = \left( x - \frac{x^5}{5} \right) \bigg|_{-1}^1 = \frac{8}{5} = 1,6$$
As aproximações obtidas pelo método 1/3 de Simpson são as seguintes:

| Subintervalos | Pontos | Aproximação | Erro (%) |
|---|---|---|---|
| 1 | 3 | 1,3333 | 16,6688 |
| 2 | 5 | 1,5833 | 1,0438 |
| 3 | 7 | 1,5967 | 0,2063 |

Então é preciso calcular $f$ em pelo menos 7 pontos para que o erro relativo percentual não ultrapasse $1\%$.

**Questão 3:** Considerando que $\int_{-1}^3 \sqrt[3]{x} dx = \frac{9\sqrt[3]{3}-3}{4} \approx 2,4951$ e que $\int_{-1}^5 \sqrt[3]{x} dx = \frac{15\sqrt[3]{5}-3}{4} \approx 5,6624$, verifique que o erro relativo da aproximação de $\int_{-1}^3 \sqrt[3]{x} dx$ pela regra de Gauss-Legendre com $3$ pontos é cerca de um terço do erro relativo da aproximação de $\int_{-1}^5 \sqrt[3]{x} dx$ pelo mesmo método.
*(Utilize números decimais com 4 dígitos após a vírgula)*

**Resposta:**
Considerando $x = 2t + 1$, tem-se $\int_{-1}^3 \sqrt[3]{x} dx = 2 \int_{-1}^1 \sqrt[3]{2t+1} dt$. Consequentemente, o valor aproximado da integral pode ser calculado pelo método de Gauss-Legendre com 3 pontos com o auxílio da seguinte tabela:

| $x_i$ | $t_i = 2x_i + 1$ | $\sqrt[3]{t_i}$ | $w_i$ | $w_i \sqrt[3]{t_i}$ |
|---|---|---|---|---|
| -0,7746 | -0,5492 | -0,8189 | 0,5556 | -0,4550 |
| 0,0000 | 1,0000 | 1,0000 | 0,8889 | 0,8889 |
| 0,7746 | 2,5492 | 1,3661 | 0,5556 | 0,7589 |

Assim,
$\int_{-1}^3 \sqrt[3]{x} dx \approx 2 \cdot (-0,4550 + 0,8889 + 0,7589) = 2,3856$,
e o erro relativo desta aproximação é $\varepsilon_1 = -0,0439$.

Analogamente, tomando $x = 3t + 2$, tem-se $\int_{-1}^5 \sqrt[3]{x} dx = 3 \int_{-1}^1 \sqrt[3]{3t+2} dt$. Consequentemente:

| $x_i$ | $t_i = 3x_i + 2$ | $\sqrt[3]{t_i}$ | $w_i$ | $w_i \sqrt[3]{t_i}$ |
|---|---|---|---|---|
| -0,7746 | -0,3238 | -0,6867 | 0,5556 | -0,3815 |
| 0,0000 | 2,0000 | 1,2599 | 0,8889 | 1,1199 |
| 0,7746 | 4,3238 | 1,6291 | 0,5556 | 0,9051 |

Assim,
$\int_{-1}^5 \sqrt[3]{x} dx \approx 3 \cdot (-0,3815 + 1,1199 + 0,9051) = 4,9305$,
e o erro relativo desta aproximação é $\varepsilon_2 = -0,1293$.
Comparando-se os erros relativos de ambas as aproximações, resulta que $\frac{\varepsilon_1}{\varepsilon_2} = \frac{-0,0439}{-0,1293} = 0,3395 \approx 1/3$.

**Questão 4:** Dados os pontos $x_0 = 0$, $x_1 = 1$ e $x_2 = 4$, obtenha os pesos $w_i$ para que a aproximação
$$ \int_0^4 f(x) dx \approx w_0 f(0) + w_1 f(1) + w_2 f(4) $$
seja exata para polinômios de grau menor ou igual a dois. Utilize a regra obtida para calcular $\int_0^4 g(x) dx$ considerando que $g(0) = 2$, $g(1) = 0$ e $g(4) = 3$.

**Resposta:**
Se a aproximação for exata para polinômios de grau menor ou igual a dois então, em particular, ela será exata para os polinômios $1$, $x$ e $x^2$, isto é:
$$ \int_0^4 1 dx = 4 = w_0 \cdot 1 + w_1 \cdot 1 + w_2 \cdot 1 $$
$$ \int_0^4 x dx = 8 = w_0 \cdot 0 + w_1 \cdot 1 + w_2 \cdot 4 $$
$$ \int_0^4 x^2 dx = \frac{64}{3} = w_0 \cdot 0 + w_1 \cdot 1 + w_2 \cdot 16 $$
Resolvendo o sistema, chega-se a $w_0 = -2/3$, $w_1 = 32/9$ e $w_2 = 10/9$.
Em particular,
$$ \int_0^4 g(x) dx \approx -0,6667 \cdot 2 + 3,5556 \cdot 0 + 1,1111 \cdot 3 = 1,9999 $$

**Questão 5:** Em relação às soluções aproximadas do problema de valor inicial
$$
\begin{cases}
y'(x) = x - y(x), \quad x \in [0, 1] \\
y(0) = 2
\end{cases}
$$
pelos métodos de Euler explícito e implícito, com passo $h = 0,25$, verifique se é correto afirmar que o maior erro absoluto (em módulo) em ambos os casos ocorre quando $x = 1$, considerando que a solução exata é $y(x) = 3e^{-x} + x - 1$.
*(Utilize números decimais com 3 dígitos após a vírgula)*

**Resposta:**
Denotando $f(x,y) = x - y$ e $h = 0,25$, pode-se expressar a fórmula do método de Euler explícito da seguinte forma:
$y_n = y_{n-1} + hf(x_{n-1}, y_{n-1}) = y_{n-1} + 0,25(x_{n-1} - y_{n-1}) = 0,25x_{n-1} + 0,75y_{n-1}$

| $n$ | $x_n$ | $y_n = 0,25x_{n-1} + 0,75y_{n-1}, n \ge 1$ | $y_{exato}(x_n)$ | $\varepsilon_n = y_n - y_{exato}(x_n)$ |
|---|---|---|---|---|
| 0 | 0,000 | 2,000 | 2,000 | 0,000 |
| 1 | 0,250 | 0,25 . 0,000 + 0,75 . 2,000 = 1,500 | 1,586 | 0,086 |
| 2 | 0,500 | 0,25 . 0,250 + 0,75 . 1,500 = 1,188 | 1,320 | 0,132 |
| 3 | 0,750 | 0,25 . 0,500 + 0,75 . 1,188 = 1,016 | 1,167 | 0,151 |
| 4 | 1,000 | 0,25 . 0,750 + 0,75 . 1,016 = 0,950 | 1,104 | **0,154** |

Em particular, o maior erro absoluto ocorre no ponto $x = 1$.

No método de Euler implícito, por sua vez, utiliza-se a relação $y_n = y_{n-1} + hf(x_n, y_n)$ que, no problema considerado, pode ser reescrita de forma equivalente como:
$y_n = y_{n-1} + 0,25(x_n - y_n) \iff 1,25y_n = 0,25x_n + y_{n-1} \iff y_n = 0,2x_n + 0,8y_{n-1}$

| $n$ | $x_n$ | $y_n = 0,2x_n + 0,8y_{n-1}, n \ge 1$ | $y_{exato}(x_n)$ | $\varepsilon_n = y_n - y_{exato}(x_n)$ |
|---|---|---|---|---|
| 0 | 0,000 | 2,000 | 2,000 | 0,000 |
| 1 | 0,250 | 0,200 . 0,250 + 0,800 . 2,000 = 1,650 | 1,586 | -0,064 |
| 2 | 0,500 | 0,200 . 0,500 + 0,800 . 1,650 = 1,420 | 1,320 | -0,100 |
| 3 | 0,750 | 0,200 . 0,750 + 0,800 . 1,420 = 1,286 | 1,167 | -0,119 |
| 4 | 1,000 | 0,200 . 1,000 + 0,800 . 1,286 = 1,229 | 1,104 | **-0,125** |

Novamente, o maior erro absoluto (em módulo) ocorre no ponto $x = 1$. Portanto a afirmação é correta.
