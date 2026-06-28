# Funções Hiperbólicas

As funções hiperbólicas surgem de forma análoga às funções trigonométricas, mas baseadas na **hipérbole** em vez da circunferência. Elas aparecem com frequência em cálculo, física e engenharia — especialmente em equações diferenciais, catenárias e física relativística.

---

## 1. Analogia com as Funções Trigonométricas

Nas funções trigonométricas, o ponto $P(x,y) = (\cos\theta, \,\text{sen}\,\theta)$ pertence à **circunferência** de equação $x^2 + y^2 = 1$.

Para as funções hiperbólicas, o ponto $P(x,y) = (\cosh\theta, \,\text{senh}\,\theta)$ pertence à **hipérbole** de equação $x^2 - y^2 = 1$.

![Analogia Trigonométrica e Hiperbólica](./imagens/Funções%20Hiperbólicas/slide_2_img_1.png)

---

## 2. Definições Fundamentais

As duas funções hiperbólicas primárias são definidas em termos da função exponencial $e^x$:

$$\text{senh}(x) = \frac{e^x - e^{-x}}{2}$$

$$\cosh(x) = \frac{e^x + e^{-x}}{2}$$

> **Observação:** $\text{senh}$ é uma função **ímpar** ($\text{senh}(-x) = -\text{senh}(x)$), enquanto $\cosh$ é uma função **par** ($\cosh(-x) = \cosh(x)$). Além disso, $\cosh(x) \geq 1$ para todo $x \in \mathbb{R}$.

![Definições Senh e Cosh](./imagens/Funções%20Hiperbólicas/slide_3_img_1.png)

---

## 3. Gráficos das Funções Principais

O gráfico de $\text{senh}(x)$ é similar ao da função cúbica — cresce sem limite em ambas as direções. Já $\cosh(x)$ forma uma curva em forma de **catenária** (o formato de uma corrente suspensa pelos extremos), com valor mínimo em $x = 0$ onde $\cosh(0) = 1$.

![Gráficos Senh e Cosh](./imagens/Funções%20Hiperbólicas/slide_4_img_1.png)

---

## 4. Outras Funções Hiperbólicas

As demais funções hiperbólicas são definidas a partir de senh e cosh, de forma análoga às razões trigonométricas:

| Função | Definição | Domínio |
|--------|-----------|---------|
| Tangente hiperbólica | $\tanh(x) = \dfrac{\text{senh}(x)}{\cosh(x)} = \dfrac{e^x - e^{-x}}{e^x + e^{-x}}$ | $\mathbb{R}$ |
| Cotangente hiperbólica | $\coth(x) = \dfrac{\cosh(x)}{\text{senh}(x)} = \dfrac{e^x + e^{-x}}{e^x - e^{-x}}$ | $x \neq 0$ |
| Secante hiperbólica | $\text{sech}(x) = \dfrac{1}{\cosh(x)} = \dfrac{2}{e^x + e^{-x}}$ | $\mathbb{R}$ |
| Cossecante hiperbólica | $\text{cosech}(x) = \dfrac{1}{\text{senh}(x)} = \dfrac{2}{e^x - e^{-x}}$ | $x \neq 0$ |

A $\tanh(x)$ possui assíntotas horizontais em $y = 1$ e $y = -1$. A $\coth(x)$ possui assíntota vertical em $x = 0$ e assíntotas horizontais em $y = \pm 1$.

![Tangente e Cotangente Hiperbólica](./imagens/Funções%20Hiperbólicas/slide_5_img_1.png)
![Secante e Cossecante Hiperbólica](./imagens/Funções%20Hiperbólicas/slide_6_img_1.png)

---

## 5. Identidades Hiperbólicas

As funções hiperbólicas satisfazem identidades análogas às trigonométricas, com algumas diferenças de sinal importantes:

$$\cosh^2(x) - \text{senh}^2(x) = 1$$

$$1 - \tanh^2(x) = \text{sech}^2(x)$$

$$\coth^2(x) - 1 = \text{cosech}^2(x)$$

$$\text{senh}(x \pm y) = \text{senh}(x)\cosh(y) \pm \cosh(x)\text{senh}(y)$$

$$\cosh(x \pm y) = \cosh(x)\cosh(y) \pm \text{senh}(x)\text{senh}(y)$$

![Identidades Hiperbólicas 1](./imagens/Funções%20Hiperbólicas/slide_7_img_1.png)
![Identidades Hiperbólicas 2](./imagens/Funções%20Hiperbólicas/slide_8_img_1.png)
![Identidades Hiperbólicas 3](./imagens/Funções%20Hiperbólicas/slide_9_img_1.png)
![Identidades Hiperbólicas 4](./imagens/Funções%20Hiperbólicas/slide_10_img_1.png)

---

## 6. Exemplos Resolvidos

### Exemplo 1 — Determine $x$ sabendo que $\text{senh}(x) = \frac{3}{4}$

Usando a definição:

$$\frac{e^x - e^{-x}}{2} = \frac{3}{4} \implies e^x - e^{-x} = \frac{3}{2}$$

Multiplicando por $e^x$:

$$(e^x)^2 - \frac{3}{2}e^x - 1 = 0$$

Pela fórmula quadrática (com $u = e^x$):

$$u = \frac{\frac{3}{2} \pm \sqrt{\frac{9}{4} + 4}}{2} = \frac{\frac{3}{2} \pm \frac{5}{2}}{2}$$

Como $e^x > 0$, tomamos apenas a raiz positiva: $e^x = \frac{3/2 + 5/2}{2} = 2$, portanto:

$$x = \ln(2)$$

![Exemplo 1 - parte 1](./imagens/Funções%20Hiperbólicas/slide_11_img_1.png)
![Exemplo 1 - parte 2](./imagens/Funções%20Hiperbólicas/slide_12_img_1.png)

### Exemplo 2 — Resolva $2\cosh(2x) + 10\,\text{senh}(2x) = 5$

Substituindo as definições:

$$2 \cdot \frac{e^{2x} + e^{-2x}}{2} + 10 \cdot \frac{e^{2x} - e^{-2x}}{2} = 5$$

$$(e^{2x} + e^{-2x}) + 5(e^{2x} - e^{-2x}) = 5$$

$$6e^{2x} - 4e^{-2x} = 5$$

Multiplicando por $e^{2x}$ (com $u = e^{2x}$):

$$6u^2 - 5u - 4 = 0 \implies u = \frac{5 \pm \sqrt{25 + 96}}{12} = \frac{5 \pm 11}{12}$$

Como $e^{2x} > 0$, tomamos $u = \frac{16}{12} = \frac{4}{3}$, portanto:

$$e^{2x} = \frac{4}{3} \implies 2x = \ln\!\left(\frac{4}{3}\right) \implies x = \frac{1}{2}\ln\!\left(\frac{4}{3}\right)$$

![Exemplo 2 - parte 1](./imagens/Funções%20Hiperbólicas/slide_13_img_1.png)
![Exemplo 2 - parte 2](./imagens/Funções%20Hiperbólicas/slide_14_img_1.png)

---

## 7. Exercícios
1) Lista de Exercícios postada no Moodle.
