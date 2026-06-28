# Função do 1º e 2º Grau

Este documento apresenta os conceitos fundamentais sobre funções polinomiais, com foco nas funções do 1º grau (lineares e afins) e do 2º grau (quadráticas), incluindo propriedades, gráficos e forma canônica.

---

## 1. Aplicações Iniciais

### Exemplo de Aplicação 1: Lucro
Um fabricante vende um produto por R$ 0,80 a unidade. O custo total do produto consiste numa taxa fixa de R$ 40,00 mais o custo de produção de R$ 0,30 por unidade.
a) Qual a função matemática que expressa o lucro em função das peças vendidas?
b) Qual o gráfico desta função?
c) Se vender 200 unidades desse produto, o comerciante terá lucro ou prejuízo?
d) Qual o número de unidades que o fabricante deve vender para não ter lucro nem prejuízo?

### Exemplo de Aplicação 2: Custo Mínimo
Uma caixa fechada com uma base quadrada deve apresentar um volume de 2.000 cm³. O material para a tampa e fundo custa R$ 3,00 por cm², e o material para os lados custa R$ 1,50 por cm².
a) Se $x$ cm for o comprimento de um lado do quadrado da base, expresse o custo do material como função de $x$.
b) Quais as dimensões da caixa para que o gasto com a sua confecção seja o mínimo possível?

---

## 2. Função Polinomial

Uma função polinomial de grau $n$ é definida pela expressão:
$$P(x) = a_n x^n + a_{n-1} x^{n-1} + \dots + a_1 x + a_0$$
Onde $n$ é um inteiro não negativo e $a_n, a_{n-1}, \dots, a_0$ são coeficientes reais com $a_n \neq 0$.

### Exemplo 1

Quais das seguintes funções são polinomiais? Para as que forem, determine o grau e o coeficiente principal. Para as que não forem, justifique:

* **a) $f(x) = 4x^3 - 5x - \frac{1}{2}$**
  > **Resolução:** Sim, é uma função polinomial. Grau: $3$. Coeficiente principal: $4$.
* **b) $g(x) = 6x^{-4} + 7$**
  > **Resolução:** Não, pois o expoente $-4$ não é um número inteiro não negativo (natural).
* **c) $h(x) = \sqrt{9x^4 + 16x^2}$**
  > **Resolução:** Não, pois a variável está sob um radical que não pode ser simplificado de forma a resultar em expoentes inteiros não negativos para todo o domínio real.
* **d) $k(x) = 15x - 2x^4$**
  > **Resolução:** Sim, é uma função polinomial (pode ser reescrita como $-2x^4 + 15x$). Grau: $4$. Coeficiente principal: $-2$.


---

## 3. Funções do 1º Grau e seus Gráficos

Uma função do primeiro grau tem a forma geral:
$$f(x) = ax + b$$
onde $a$ e $b$ são reais e $a \neq 0$.

### Observações:
*   **Domínio:** $\mathbb{R}$ (os números reais); $D = \mathbb{R}$
*   **Imagem:** $\mathbb{R}$ (os números reais); $Im = \mathbb{R}$
*   **Gráfico:** Uma reta que possui uma inclinação em relação ao eixo x.

### Variação e Zero da Função:
*   **Crescente:** Se $a > 0$
*   **Decrescente:** Se $a < 0$
*   **Zero da Função:** O valor do domínio ($x$) onde a imagem ($y$) é igual a zero. Também pode ser definido como o ponto onde o gráfico corta o eixo $x$. Para encontrar, resolve-se $f(x) = 0$.

### Exemplo: Traçar o gráfico
Trace o gráfico da função: $f(x) = 2x - 4$
1. Encontrar o zero: $2x - 4 = 0 \implies 2x = 4 \implies x = 2$.
2. Interseção com $y$: $f(0) = -4$.
O gráfico passa por $(2,0)$ e $(0,-4)$.

### Exemplo 2
Encontre a lei para a função do primeiro grau $f(x)$, tal que $f(-1) = 2$ e $f(3) = -2$.

### Exemplo 3
Determine a função representada no gráfico abaixo:

---

## 4. Funções do 2º Grau e seus Gráficos

Uma função do segundo grau tem a forma:
$$f(x) = ax^2 + bx + c$$
onde $a, b, c$ são reais e $a \neq 0$.

### Observações:
*   **Domínio:** $\mathbb{R}$ (os números reais); $D = \mathbb{R}$
*   **Gráfico:** Uma curva denominada "parábola".
    *   Se $a > 0$: Concavidade para cima.
    *   Se $a < 0$: Concavidade para baixo.

### Zero da função (Raízes):
Os pontos onde o gráfico corta o eixo $x$ são calculados pela Fórmula de Bhaskara:
$$ax^2 + bx + c = 0$$
$$x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$$

### Análise do Discriminante ($\Delta = b^2 - 4ac$):
*   Se $\Delta > 0$: A parábola corta o eixo x em dois pontos distintos ($x'$ e $x''$).
*   Se $\Delta = 0$: A parábola toca o eixo x em um único ponto ($x' = x''$).
*   Se $\Delta < 0$: A parábola não corta o eixo x (não possui raízes reais).

### Vértice da Parábola e Imagem:
O vértice $V(x_v, y_v)$ da parábola é dado por:
$$x_v = \frac{-b}{2a}$$
$$y_v = \frac{-\Delta}{4a}$$

**Conjunto Imagem:**
*   Se $a > 0$: O vértice é um ponto de **mínimo**. $Im = \{ y \in \mathbb{R} \mid y \geq y_v \}$
*   Se $a < 0$: O vértice é um ponto de **máximo**. $Im = \{ y \in \mathbb{R} \mid y \leq y_v \}$

---

## 5. Forma Canônica

A forma canônica da função do 2º grau é expressa completando quadrados, permitindo visualizar facilmente as coordenadas do vértice:
$$f(x) = a(x - h)^2 + k$$
Onde o vértice é $(h, k)$.

### Exemplo 1
Escreva a função $f(x) = 3x^2 + 12x + 11$ na forma canônica.
**Resolução:**
$$f(x) = 3x^2 + 12x + 11$$
$$f(x) = 3(x^2 + 4x) + 11$$
Adicionando e subtraindo $(4/2)^2 = 4$:
$$f(x) = 3(x^2 + 4x + 4 - 4) + 11$$
$$f(x) = 3(x+2)^2 - 12 + 11$$
$$f(x) = 3(x+2)^2 - 1$$

### Exemplo 2
Dada a função $f(x) = x^2 - 4x - 5$. Determine:
a) $f(-3)$
b) Os valores de $x$ para os quais $f(x) = 7$

**Resolução a):**
$$f(-3) = (-3)^2 - 4(-3) - 5 = 9 + 12 - 5 = 16$$

**Resolução b):**
$$7 = x^2 - 4x - 5 \implies x^2 - 4x - 12 = 0$$
$$\Delta = (-4)^2 - 4(1)(-12) = 16 + 48 = 64$$
$$x = \frac{-(-4) \pm \sqrt{64}}{2(1)} = \frac{4 \pm 8}{2}$$
$$x' = 6 \quad \text{e} \quad x'' = -2$$

### Exemplo 3
Dada a função do 2º grau $f(x) = ax^2 + bx - 3$, sabendo que $f(-2) = 5$ e $f(3) = 0$. Determine a função $f(x)$.

**Resolução:**
$f(-2) = a(-2)^2 + b(-2) - 3 = 4a - 2b - 3 = 5 \implies 4a - 2b = 8 \implies 2a - b = 4$
$f(3) = a(3)^2 + b(3) - 3 = 9a + 3b - 3 = 0 \implies 9a + 3b = 3 \implies 3a + b = 1$
Resolvendo o sistema:
$b = 2a - 4$ substituindo na outra equação: $3a + (2a - 4) = 1 \implies 5a = 5 \implies a = 1$
Então, $b = 2(1) - 4 = -2$.
**Portanto:** $f(x) = x^2 - 2x - 3$.

### Exemplo 4
Dada a função $f(x) = x^2 - 4x + 3$. Trace o gráfico da função, destacando os zeros da função, o ponto de intersecção com o eixo y, conjunto imagem e o valor máximo ou mínimo.

**Resolução:**
1. Zeros: $\Delta = 16 - 12 = 4$. $x = \frac{4 \pm 2}{2} \implies x' = 3, x'' = 1$.
2. Interseção y: $f(0) = 3$.
3. Vértice: $x_v = \frac{4}{2} = 2$. $y_v = \frac{-4}{4} = -1$.
4. Imagem: $Im = \{ y \in \mathbb{R} \mid y \geq -1 \}$. O valor é mínimo.

### Exemplo 5
Qual a função geradora do gráfico?
*(Considerando os pontos $A(1, -2)$, $C(5, 2)$ e $c = 2$)*
**Resolução:**
$f(x) = ax^2 + bx + 2$
$f(1) = a + b + 2 = -2 \implies a + b = -4$
$f(5) = 25a + 5b + 2 = 2 \implies 25a + 5b = 0 \implies 5a + b = 0$
Subtraindo as equações: $4a = 4 \implies a = 1$.
Logo, $b = -5$.
**Portanto:** $f(x) = x^2 - 5x + 2$.

---

## 6. Exercícios
1) Livro Texto: páginas 101 à 103 – Exercícios do 1 ao 60.
