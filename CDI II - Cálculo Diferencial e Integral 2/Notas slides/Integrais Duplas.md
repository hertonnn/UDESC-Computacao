# Integrais Duplas

Este documento apresenta a definição rigorosa de **Integrais Duplas** sobre regiões retangulares, o cálculo prático por meio de integrais iteradas, a demonstração de exemplos resolvidos detalhadamente e o enunciado do **Teorema de Fubini**.

---

## 1. Motivação e Equações Diferenciais Parciais Simples

* **Exemplo 1:** Encontre o conjunto de todas as funções $f: \mathbb{R}^2 \to \mathbb{R}$ de classe $C^2$ tais que:
  $$\frac{\partial^2 f}{\partial x \partial y}(x, y) = g(x, y)$$

  **Resolução:**
  Podemos reescrever a equação diferencial parcial como:
  $$\frac{\partial}{\partial x} \left( \frac{\partial f}{\partial y} \right) = g(x, y)$$
  Integrando em relação a $x$:
  $$\frac{\partial f}{\partial y} = G(x, y) + \phi(y)$$
  Onde $G(x, y)$ é uma primitiva de $g(x, y)$ em relação a $x$ (ou seja, $\frac{\partial G}{\partial x} = g$) e $\phi(y)$ é uma função arbitrária que depende apenas de $y$.
  
  Agora, integrando em relação a $y$:
  $$f(x, y) = \int [G(x, y) + \phi(y)] \, dy = F(x, y) + \Phi(y) + \Psi(x)$$
  Onde $F(x, y)$ é uma primitiva de $G(x, y)$ em relação a $y$, $\Phi(y)$ é a primitiva de $\phi(y)$ (uma função arbitrária de classe $C^2$ de $y$) e $\Psi(x)$ é a constante de integração que depende apenas de $x$ (uma função arbitrária de classe $C^2$ de $x$).
  
  Portanto, a solução geral é:
  $$f(x, y) = F(x, y) + \Phi(y) + \Psi(x)$$

---

## 2. Integrais Iteradas (Cálculo Prático)

As integrais sobre regiões retangulares podem ser resolvidas calculando-se integrais de uma única variável de maneira sucessiva (iterada).

* **Exemplo 2:** Calcule a integral iterada:
  $$\int_{0}^{4} \int_{0}^{1} (2x^4 y^2 + 2x^6) \, dx \, dy$$

  **Resolução:**
  Primeiro, calculamos a integral interna em relação a $x$, tratando $y$ como constante:
  $$\int_{0}^{1} (2x^4 y^2 + 2x^6) \, dx = \left[ \frac{2x^5 y^2}{5} + \frac{2x^7}{7} \right]_{x=0}^{x=1} = \frac{2}{5} y^2 + \frac{2}{7}$$
  Agora, integramos o resultado em relação a $y$ de $0$ a $4$:
  $$\int_{0}^{4} \left( \frac{2}{5} y^2 + \frac{2}{7} \right) \, dy = \left[ \frac{2y^3}{15} + \frac{2y}{7} \right]_{y=0}^{y=4} = \left( \frac{2(4^3)}{15} + \frac{2(4)}{7} \right) - 0$$
  $$= \frac{128}{15} + \frac{8}{7} = \frac{128 \cdot 7 + 8 \cdot 15}{105} = \frac{896 + 120}{105} = \frac{1016}{105}$$

* **Exemplo 3:** Calcule a integral iterada:
  $$\int_{0}^{3} \int_{1}^{2} (4y^2 + 9x^2 y^2) \, dx \, dy$$

  **Resolução:**
  Primeiro, resolvemos a integral interna com relação a $x$, tratando $y$ como constante:
  $$\int_{1}^{2} (4y^2 + 9x^2 y^2) \, dx = y^2 \int_{1}^{2} (4 + 9x^2) \, dx = y^2 \left[ 4x + 3x^3 \right]_{x=1}^{x=2}$$
  $$= y^2 \left[ (4(2) + 3(2^3)) - (4(1) + 3(1^3)) \right] = y^2 \left[ (8 + 24) - (4 + 3) \right] = y^2 [32 - 7] = 25y^2$$
  Agora, integramos em relação a $y$ de $0$ a $3$:
  $$\int_{0}^{3} 25y^2 \, dy = 25 \left[ \frac{y^3}{3} \right]_{0}^{3} = 25 \left( \frac{27}{3} - 0 \right) = 25 \cdot 9 = 225$$

---

## 3. Definição Formal de Integral Dupla

Seja $f(x, y)$ uma função definida em uma região retangular fechada $R = [a, b] \times [c, d]$ do plano $\mathbb{R}^2$.

1. Dividimos $R$ em sub-retângulos de área $\Delta A = \Delta x \cdot \Delta y$.
2. Escolhemos um ponto de amostragem $(x_i^*, y_j^*)$ em cada sub-retângulo.
3. Formamos a Soma de Riemann:
   $$S_{m,n} = \sum_{i=1}^m \sum_{j=1}^n f(x_i^*, y_j^*) \, \Delta A$$

Definimos a **Integral Dupla** de $f$ sobre a região $R$ como o limite dessas somas quando a partição se torna infinitamente fina:
$$\iint_R f(x, y) \, dA = \lim_{m,n \to \infty} \sum_{i=1}^m \sum_{j=1}^n f(x_i^*, y_j^*) \, \Delta A$$
desde que o limite exista.

---

## 4. Teorema de Fubini

O cálculo da integral dupla por meio de integrais iteradas é garantido pelo **Teorema de Fubini**:

> [!IMPORTANT]
> **Teorema de Fubini:** Se $f(x, y)$ for contínua na região retangular $R = [a, b] \times [c, d]$, então a integral dupla de $f$ sobre $R$ pode ser calculada por qualquer uma das integrais iteradas:
> $$\iint_R f(x, y) \, dA = \int_{a}^{b} \int_{c}^{d} f(x, y) \, dy \, dx = \int_{c}^{d} \int_{a}^{b} f(x, y) \, dx \, dy$$

---

## 5. Exercícios Propostos

### 1. Encontre o conjunto de todas as funções $f: \mathbb{R}^2 \to \mathbb{R}$ de classe $C^2$ tais que:
$$\frac{\partial^2 f}{\partial x \partial y}(x, y) = 2$$

- **Resolução:**
  Integramos primeiro em relação a $x$:
  $$\frac{\partial f}{\partial y} = \int 2 \, dx = 2x + \phi(y)$$
  Onde $\phi(y)$ é uma função arbitrária que depende apenas de $y$.
  
  Agora, integramos em relação a $y$:
  $$f(x, y) = \int [2x + \phi(y)] \, dy = 2xy + \Phi(y) + \Psi(x)$$
  Onde $\Phi(y) = \int \phi(y) \, dy$ e $\Psi(x)$ são funções arbitrárias de classe $C^2$ de uma única variável.
  
  Portanto, o conjunto de funções é dado por:
  $$f(x, y) = 2xy + \Phi(y) + \Psi(x)$$
