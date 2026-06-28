# Pontos Extremos e Pontos Críticos

Este documento aborda a determinação e classificação de **pontos críticos** de funções de várias variáveis, o cálculo do determinante **Hessiano** e o Teste da Segunda Derivada para classificação de máximos, mínimos e pontos de sela.

---

## 1. Definição de Ponto Crítico e Extremo

Seja $f: D \subseteq \mathbb{R}^2 \to \mathbb{R}$ uma função diferenciável.

1. Um ponto $(x_0, y_0) \in D$ é chamado de **ponto crítico** de $f(x, y)$ se:
   - $\frac{\partial f}{\partial x}(x_0, y_0) = 0$ e $\frac{\partial f}{\partial y}(x_0, y_0) = 0$;
   - Ou se pelo menos uma das derivadas parciais $\frac{\partial f}{\partial x}$ ou $\frac{\partial f}{\partial y}$ não existir em $(x_0, y_0)$.

2. Um ponto $(x_0, y_0)$ é um **extremo local** (ou global) de $f(x, y)$ se $f(x_0, y_0)$ for um valor de máximo ou de mínimo (local ou global).

### Teorema
> [!IMPORTANT]
> Se $(x_0, y_0)$ é um ponto de extremo de $f(x, y)$ e $f$ é diferenciável nesse ponto, então $(x_0, y_0)$ é um **ponto crítico**.
>
> **Atenção:** A recíproca não é verdadeira. Um ponto crítico pode não ser um extremo (como no caso de um ponto de sela).

---

## 2. O Determinante Hessiano

Se $f: D \subseteq \mathbb{R}^2 \to \mathbb{R}$ tem derivadas segundas contínuas (classe $C^2$), definimos a **Matriz Hessiana** de $f$ no ponto $(x, y)$ como:
$$\mathcal{H}(x, y) = \begin{bmatrix} f_{xx}(x, y) & f_{xy}(x, y) \\ f_{yx}(x, y) & f_{yy}(x, y) \end{bmatrix}$$

O determinante dessa matriz, chamado de **Hessiano** $H(x, y)$, é dado por:
$$H(x, y) = \det \begin{bmatrix} f_{xx}(x, y) & f_{xy}(x, y) \\ f_{yx}(x, y) & f_{yy}(x, y) \end{bmatrix} = f_{xx}(x, y)f_{yy}(x, y) - [f_{xy}(x, y)]^2$$
*(Nota: Pelo Teorema de Clairaut, como as derivadas de segunda ordem são contínuas, $f_{xy} = f_{yx}$).*

---

## 3. Teste da Segunda Derivada (Classificação de Pontos Críticos)

Seja $f: D \subseteq \mathbb{R}^2 \to \mathbb{R}$ de classe $C^2$ e $(x_0, y_0)$ um ponto crítico de $f$. Denotamos $H = H(x_0, y_0)$.

- **Caso a) Se $H > 0$ e $f_{xx}(x_0, y_0) > 0$:**
  $(x_0, y_0)$ é um ponto de **mínimo local**.
- **Caso b) Se $H > 0$ e $f_{xx}(x_0, y_0) < 0$:**
  $(x_0, y_0)$ é um ponto de **máximo local**.
- **Caso c) Se $H < 0$:**
  $(x_0, y_0)$ é um **ponto de sela** (não é extremo).
- **Caso d) Se $H = 0$:**
  O teste é **inconclusivo** (nada podemos afirmar, necessitando de análises adicionais).

---

## 4. Exemplos Práticos Resolvidos

### Exemplo 1
Encontre os pontos críticos da função $f(x, y) = x^2 + 3xy + 4y^2 - 6x - 2y$ e classifique-os.

- **Resolução:**
  1. **Derivadas parciais de primeira ordem:**
     $$f_x(x, y) = 2x + 3y - 6$$
     $$f_y(x, y) = 3x + 8y - 2$$
  2. **Encontrando os pontos críticos ($f_x = 0$ e $f_y = 0$):**
     $$\begin{cases} 2x + 3y = 6 \\ 3x + 8y = 2 \end{cases}$$
     Multiplicando a primeira equação por $3$ e a segunda por $2$:
     $$\begin{cases} 6x + 9y = 18 \\ 6x + 16y = 4 \end{cases}$$
     Subtraindo as equações:
     $$7y = -14 \implies y = -2$$
     Substituindo $y = -2$ na primeira equação:
     $$2x + 3(-2) = 6 \implies 2x = 12 \implies x = 6$$
     Temos um único ponto crítico: $C_1 = (6, -2)$.
  3. **Derivadas parciais de segunda ordem e Hessiano:**
     $$f_{xx} = 2, \quad f_{yy} = 8, \quad f_{xy} = 3$$
     $$H(6, -2) = \det \begin{bmatrix} 2 & 3 \\ 3 & 8 \end{bmatrix} = 2(8) - 3^2 = 16 - 9 = 7$$
  4. **Classificação:**
     Como $H(6, -2) = 7 > 0$ e $f_{xx}(6, -2) = 2 > 0$, o ponto $C_1 = (6, -2)$ é um **ponto de mínimo local**.

---

### Exemplo 2
Encontre os pontos críticos da função $f(x, y) = 2x^3 + xy^2 - 5x^2 - y^2$ e classifique-os.

- **Resolução:**
  1. **Derivadas de primeira ordem:**
     $$f_x(x, y) = 6x^2 + y^2 - 10x$$
     $$f_y(x, y) = 2xy - 2y = 2y(x - 1)$$
  2. **Encontrando os pontos críticos ($f_x = 0$ e $f_y = 0$):**
     De $f_y = 2y(x - 1) = 0$, temos duas possibilidades:
     - **Caso 1: $y = 0$**
       Substituindo em $f_x = 0$:
       $$6x^2 - 10x = 0 \implies 2x(3x - 5) = 0 \implies x = 0 \quad \text{ou} \quad x = \frac{5}{3}$$
       Temos os pontos críticos: $C_1 = (0, 0)$ e $C_2 = \left(\frac{5}{3}, 0\right)$.
     - **Caso 2: $x = 1$**
       Substituindo em $f_x = 0$:
       $$6(1)^2 + y^2 - 10(1) = 0 \implies y^2 - 4 = 0 \implies y^2 = 4 \implies y = \pm 2$$
       Temos os pontos críticos: $C_3 = (1, 2)$ e $C_4 = (1, -2)$.
  3. **Derivadas de segunda ordem:**
     $$f_{xx} = 12x - 10, \quad f_{yy} = 2x - 2, \quad f_{xy} = 2y$$
     $$H(x, y) = (12x - 10)(2x - 2) - 4y^2$$
  4. **Classificação dos pontos:**
     - **Para $C_1(0, 0)$:**
       $$f_{xx}(0, 0) = -10, \quad H(0, 0) = (-10)(-2) - 0 = 20 > 0$$
       Como $H > 0$ e $f_{xx} < 0$, o ponto $(0, 0)$ é de **máximo local**.
     - **Para $C_2\left(\frac{5}{3}, 0\right)$:**
       $$f_{xx}\left(\frac{5}{3}, 0\right) = 10, \quad f_{yy}\left(\frac{5}{3}, 0\right) = \frac{4}{3}$$
       $$H\left(\frac{5}{3}, 0\right) = 10 \cdot \frac{4}{3} - 0 = \frac{40}{3} > 0$$
       Como $H > 0$ e $f_{xx} > 0$, o ponto $\left(\frac{5}{3}, 0\right)$ é de **mínimo local**.
     - **Para $C_3(1, 2)$:**
       $$f_{xx}(1, 2) = 2, \quad f_{yy}(1, 2) = 0, \quad f_{xy}(1, 2) = 4$$
       $$H(1, 2) = 2(0) - 4^2 = -16 < 0$$
       Como $H < 0$, o ponto $(1, 2)$ é um **ponto de sela**.
     - **Para $C_4(1, -2)$:**
       $$f_{xx}(1, -2) = 2, \quad f_{yy}(1, -2) = 0, \quad f_{xy}(1, -2) = -4$$
       $$H(1, -2) = 2(0) - (-4)^2 = -16 < 0$$
       Como $H < 0$, o ponto $(1, -2)$ é um **ponto de sela**.

---

## 5. Exercícios Propostos

### 1. Encontre as derivadas de segunda ordem das funções abaixo:

#### a) $f(x, y) = x^3 - 4xy^2 + y^2$
- **Resolução:**
  - $f_x = 3x^2 - 4y^2 \implies f_{xx} = 6x, \quad f_{xy} = -8y$
  - $f_y = -8xy + 2y \implies f_{yy} = -8x + 2, \quad f_{yx} = -8y$

#### b) $f(x, y, z) = z e^x + y \ln(z)$
- **Resolução:**
  - $f_x = z e^x \implies f_{xx} = z e^x, \quad f_{xy} = 0, \quad f_{xz} = e^x$
  - $f_y = \ln(z) \implies f_{yy} = 0, \quad f_{yx} = 0, \quad f_{yz} = \frac{1}{z}$
  - $f_z = e^x + \frac{y}{z} \implies f_{zz} = -\frac{y}{z^2}, \quad f_{zx} = e^x, \quad f_{zy} = \frac{1}{z}$

---

### 2. Determine e classifique, se possível, os pontos críticos das seguintes funções:

#### a) $f(x, y) = x^2 + y^2 - 2x$
- **Resolução:**
  - $f_x = 2x - 2 = 0 \implies x = 1$
  - $f_y = 2y = 0 \implies y = 0$. Ponto crítico: $(1, 0)$.
  - $f_{xx} = 2, \quad f_{yy} = 2, \quad f_{xy} = 0 \implies H = 4 > 0$.
  Como $H > 0$ e $f_{xx} > 0$, $(1, 0)$ é um **mínimo local**.

#### b) $f(x, y) = x^3 + y^3 - 3x - 3y + 12$
- **Resolução:**
  - $f_x = 3x^2 - 3 = 0 \implies x = \pm 1$
  - $f_y = 3y^2 - 3 = 0 \implies y = \pm 1$.
  Pontos críticos: $C_1(1, 1)$, $C_2(1, -1)$, $C_3(-1, 1)$ e $C_4(-1, -1)$.
  - $f_{xx} = 6x, \quad f_{yy} = 6y, \quad f_{xy} = 0 \implies H = 36xy$.
    - $C_1(1, 1): H = 36 > 0, f_{xx} = 6 > 0 \implies$ **Mínimo local**.
    - $C_2(1, -1): H = -36 < 0 \implies$ **Ponto de sela**.
    - $C_3(-1, 1): H = -36 < 0 \implies$ **Ponto de sela**.
    - $C_4(-1, -1): H = 36 > 0, f_{xx} = -6 < 0 \implies$ **Máximo local**.

#### c) $f(x, y) = x + y + \frac{1}{x} + \frac{1}{y}$
- **Resolução:**
  - $f_x = 1 - \frac{1}{x^2} = 0 \implies x = \pm 1$
  - $f_y = 1 - \frac{1}{y^2} = 0 \implies y = \pm 1$.
  Pontos críticos: $(1, 1)$, $(1, -1)$, $(-1, 1)$, $(-1, -1)$.
  - $f_{xx} = \frac{2}{x^3}, \quad f_{yy} = \frac{2}{y^3}, \quad f_{xy} = 0 \implies H = \frac{4}{x^3 y^3}$.
    - $(1, 1): H = 4 > 0, f_{xx} = 2 > 0 \implies$ **Mínimo local**.
    - $(1, -1): H = -4 < 0 \implies$ **Ponto de sela**.
    - $(-1, 1): H = -4 < 0 \implies$ **Ponto de sela**.
    - $(-1, -1): H = 4 > 0, f_{xx} = -2 < 0 \implies$ **Máximo local**.

#### d) $f(x, y) = x^2 + y^2 - e^{-(x^2+y^2)}$
- **Resolução:**
  - $f_x = 2x + 2xe^{-(x^2+y^2)} = 2x(1 + e^{-(x^2+y^2)}) = 0 \implies x = 0$
  - $f_y = 2y + 2ye^{-(x^2+y^2)} = 2y(1 + e^{-(x^2+y^2)}) = 0 \implies y = 0$.
  Ponto crítico único na origem: $(0, 0)$.
  - $f_{xx} = 2 + 2e^{-(x^2+y^2)} - 4x^2e^{-(x^2+y^2)} \implies f_{xx}(0, 0) = 4$.
  - $f_{yy}(0, 0) = 4, \quad f_{xy}(0, 0) = 0 \implies H(0, 0) = 16 > 0$.
  Como $H > 0$ e $f_{xx} > 0$, $(0, 0)$ é um **mínimo local**.

#### e) $f(x, y) = x^2 + 2xy + y^2 - 4x$
- **Resolução:**
  - $f_x = 2x + 2y - 4 = 0 \implies x + y = 2$
  - $f_y = 2x + 2y = 0 \implies x + y = 0$.
  Como não há valores de $x$ e $y$ que satisfaçam simultaneamente $x + y = 2$ e $x + y = 0$, a função **não possui pontos críticos**.

---

### 3. Problema Teórico:
Encontre o conjunto das funções $f: \mathbb{R}^2 \to \mathbb{R}$ tais que $\frac{\partial^2 f}{\partial x^2} = 2$.

- **Resolução:**
  Integramos duas vezes em relação a $x$:
  - Primeira integração:
    $$\frac{\partial f}{\partial x} = \int 2 \, dx = 2x + g(y)$$
  - Segunda integração:
    $$f(x, y) = \int (2x + g(y)) \, dx = x^2 + x \cdot g(y) + h(y)$$
  Onde $g(y)$ e $h(y)$ são funções reais arbitrárias de classe $C^2$.
