# Funções de Várias Variáveis

Este documento introduz o conceito de funções reais de duas ou mais variáveis reais, abordando a definição de domínio, imagem, representações gráficas (superfícies) e exercícios práticos de fixação.

---

## 1. Definição de Função de Duas Variáveis

Uma função é uma terna constituída de dois conjuntos não vazios $A$ e $B$ e uma regra $f$ que associa a cada elemento de $A$ um único elemento de $B$.

Uma **função real de duas variáveis** é uma função $f: D \to \mathbb{R}$, onde o domínio $D$ é um subconjunto de $\mathbb{R}^2$ ($D \subseteq \mathbb{R}^2$).
$$f: \mathbb{R}^2 \to \mathbb{R}$$
$$(x, y) \to z = f(x, y)$$

### Exemplos Iniciais

* **Exemplo 1:**
  $$f(x, y) = x \cdot y$$

* **Exemplo 2:**
  $$f(x, y) = x^2 + y^2$$
  Para o ponto $(1, 2)$:
  $$f(1, 2) = 1^2 + 2^2 = 5$$

* **Exemplo 3:**
  $$f(x, y) = \sqrt{x^2 + y^2 - 1} + \sin(y)$$
  O domínio desta função exige que o termo sob a raiz seja não negativo:
  $$x^2 + y^2 - 1 \ge 0 \implies x^2 + y^2 \ge 1$$

---

## 2. Estudo de Domínio e Limitações

* **Exemplo 4:** Encontre o domínio da função:
  $$f(x, y) = \frac{1}{\sqrt{x + y}}$$

  **Resolução:**
  Para que a função seja real e bem definida, o radicando no denominador deve ser estritamente positivo:
  $$x + y > 0 \implies y > -x$$
  Portanto, o domínio $D(f)$ é:
  $$D(f) = \{ (x, y) \in \mathbb{R}^2 \mid x + y > 0 \} = \{ (x, y) \in \mathbb{R}^2 \mid y > -x \}$$
  Graficamente, o domínio corresponde ao semiplano aberto acima da reta $y = -x$.

---

## 3. Gráfico de Funções de Duas Variáveis

O **gráfico** de uma função de duas variáveis é o conjunto de todos os pontos $(x, y, z) \in \mathbb{R}^3$ tais que $z = f(x, y)$ para $(x, y)$ pertencente ao domínio da função:
$$\text{Graf}(f) = \{ (x, y, z) \in \mathbb{R}^3 \mid z = f(x, y), \, (x, y) \in D(f) \}$$

Geometricamente, o gráfico representa uma **superfície** no espaço tridimensional.

### Exemplos Gráficos

* **Exemplo 5 (Parabolóide):**
  $$f(x, y) = x^2 + y^2$$
  O gráfico $z = x^2 + y^2$ representa um parabolóide de revolução com concavidade voltada para cima e vértice na origem $(0, 0, 0)$.

* **Exemplo 6 (Plano):**
  $$f(x, y) = \frac{6 - x - 2y}{3}$$
  Esta equação pode ser reescrita na forma geral do plano:
  $$x + 2y + 3z = 6$$
  Os pontos onde o plano intersecta os eixos coordenados são obtidos zerando duas variáveis de cada vez:
  - Intercepto com o eixo $x$ ($y = z = 0$): $x = 6 \implies (6, 0, 0)$
  - Intercepto com o eixo $y$ ($x = z = 0$): $2y = 6 \implies y = 3 \implies (0, 3, 0)$
  - Intercepto com o eixo $z$ ($x = y = 0$): $3z = 6 \implies z = 2 \implies (0, 0, 2)$

---

## 4. Funções de Três ou Mais Variáveis

Uma **função de $n$ variáveis** é uma regra $f$ que associa a cada $n$-upla $(x_1, x_2, \dots, x_n)$ de um domínio $D \subseteq \mathbb{R}^n$ um único número real em $\mathbb{R}$.

### Exemplos

* **Exemplo 7 (Três variáveis):**
  $$f(x, y, z) = x + 4y - 8z$$

* **Exemplo 8 (Quatro variáveis):**
  $$f(x, y, z, w) = x \cdot y \cdot z + w$$

* **Exemplo 9 (Sete variáveis):**
  $$f(x_1, x_2, x_3, x_4, x_5, x_6, x_7) = x_1 + x_2 \cdot x_3 + x_4 \cdot x_5 + x_6 \cdot x_7$$

* **Exemplo 10:** Encontre o domínio da função:
  $$f(x, y, z) = \frac{1}{x^2 + y^2 + z^2 - 4}$$
  **Resolução:**
  O denominador não pode ser nulo:
  $$x^2 + y^2 + z^2 - 4 \neq 0 \implies x^2 + y^2 + z^2 \neq 4$$
  Portanto, o domínio $D(f)$ é:
  $$D(f) = \{ (x, y, z) \in \mathbb{R}^3 \mid x^2 + y^2 + z^2 \neq 4 \}$$
  Geometricamente, o domínio é todo o espaço tridimensional $\mathbb{R}^3$, exceto a casca esférica de raio $2$ centrada na origem.

---

## 5. Gráfico de Funções de $n$ Variáveis

O **gráfico** de uma função de $n$ variáveis é o conjunto de pontos em $\mathbb{R}^{n+1}$ dado por:
$$\text{Graf}(f) = \{ (x_1, x_2, \dots, x_n, f(x_1, x_2, \dots, x_n)) \in \mathbb{R}^{n+1} \mid (x_1, x_2, \dots, x_n) \in D(f) \}$$

- Para $n = 3$, o gráfico reside no espaço quadridimensional $\mathbb{R}^4$, o que impossibilita a visualização geométrica direta. Nesses casos, usamos superfícies de nível para auxiliar no estudo do comportamento da função.

---

## 6. Exercícios Propostos

### 1. Encontre o domínio $D(f)$ das seguintes funções e faça um esboço gráfico de $D(f)$ quando possível:

#### a) $f(x, y) = \sqrt{1 - xy}$
- **Resolução:**
  O termo sob a raiz quadrada deve ser não negativo:
  $$1 - xy \ge 0 \implies xy \le 1$$
  - Se $x > 0 \implies y \le \frac{1}{x}$
  - Se $x < 0 \implies y \ge \frac{1}{x}$
  - Se $x = 0 \implies 0 \le 1$ (válido para todo $y$).
  O domínio é:
  $$D(f) = \{ (x, y) \in \mathbb{R}^2 \mid xy \le 1 \}$$

#### b) $f(x, y) = \sqrt{1 - x^2 - y^2}$
- **Resolução:**
  Exige-se que:
  $$1 - x^2 - y^2 \ge 0 \implies x^2 + y^2 \le 1$$
  O domínio é:
  $$D(f) = \{ (x, y) \in \mathbb{R}^2 \mid x^2 + y^2 \le 1 \}$$
  Graficamente, representa o disco fechado unitário (círculo e seu interior) centrado na origem.

#### c) $f(x, y) = \ln(y - x^2 - 2)$
- **Resolução:**
  O argumento do logaritmo deve ser estritamente positivo:
  $$y - x^2 - 2 > 0 \implies y > x^2 + 2$$
  O domínio é:
  $$D(f) = \{ (x, y) \in \mathbb{R}^2 \mid y > x^2 + 2 \}$$
  Graficamente, representa a região aberta acima da parábola $y = x^2 + 2$.

#### d) $f(x, y) = \frac{1}{xy - 1}$
- **Resolução:**
  O denominador deve ser diferente de zero:
  $$xy - 1 \neq 0 \implies xy \neq 1$$
  O domínio é:
  $$D(f) = \{ (x, y) \in \mathbb{R}^2 \mid xy \neq 1 \}$$
  Graficamente, representa todo o plano cartesiano $\mathbb{R}^2$ exceto os pontos sobre a hipérbole $y = \frac{1}{x}$.

#### e) $f(x, y, z) = \frac{1}{x^2 + y^2 + z^2}$
- **Resolução:**
  O denominador deve ser diferente de zero:
  $$x^2 + y^2 + z^2 \neq 0 \implies (x, y, z) \neq (0, 0, 0)$$
  O domínio é:
  $$D(f) = \mathbb{R}^3 \setminus \{ (0, 0, 0) \}$$
  Graficamente, representa todo o espaço tridimensional exceto o ponto de origem.

#### f) $f(x, y, z) = \frac{1}{\sqrt{x^2 + y^2 + z^2 - 4}}$
- **Resolução:**
  O termo sob a raiz no denominador deve ser estritamente positivo:
  $$x^2 + y^2 + z^2 - 4 > 0 \implies x^2 + y^2 + z^2 > 4$$
  O domínio é:
  $$D(f) = \{ (x, y, z) \in \mathbb{R}^3 \mid x^2 + y^2 + z^2 > 4 \}$$
  Graficamente, representa a região externa à casca esférica de raio $2$ centrada na origem.
