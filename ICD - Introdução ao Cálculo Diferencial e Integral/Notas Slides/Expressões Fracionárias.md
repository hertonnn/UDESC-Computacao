# Expressões Fracionárias

## Domínio de uma Expressão Algébrica

O quociente de duas expressões algébricas, além de ser outra expressão algébrica, é denominado uma **expressão fracionária** (ou racional).
* **Exemplos**:
  $$\frac{x^2 - 5x + 2}{\sqrt{x^2 - 1}} \qquad \qquad \frac{2x^3 - x^2 + 1}{5x^2 - x - 3}$$

O **domínio de uma expressão algébrica** é o conjunto de todos os números reais para os quais a expressão é bem definida.

---

### Exemplo: Verificar o domínio das expressões algébricas abaixo

* **a)** $3x^2 - x + 5$
  * Por ser uma expressão polinomial, não há divisões por zero nem raízes de índice par. É definida para qualquer número real.
  * **Domínio**:
    $$D = \mathbb{R}$$

* **b)** $\sqrt{x - 1}$
  * Para que o radical de índice par seja definido no conjunto dos números reais, o radicando deve ser maior ou igual a zero:
    $$x - 1 \ge 0 \implies x \ge 1$$
  * **Domínio**:
    $$D = \{x \in \mathbb{R} \mid x \ge 1\}$$

* **c)** $\frac{x}{x - 1}$
  * Para que a fração seja definida nos números reais, o denominador deve ser diferente de zero:
    $$x - 1 \ne 0 \implies x \ne 1$$
  * **Domínio**:
    $$D = \{x \in \mathbb{R} \mid x \ne 1\}$$

---

## Simplificação de Expressões Algébricas

Para simplificar uma expressão racional, fatoramos completamente o numerador e o denominador e cancelamos os fatores comuns, respeitando as restrições do domínio (pontos onde o denominador original se anula).

### Exemplo: Escreva $\frac{x^2 - 3x}{x^2 - 9}$ na forma reduzida
1. **Determinação do Domínio (Restrições)**:
   O denominador não pode ser nulo:
   $$x^2 - 9 \ne 0 \implies x^2 \ne 9 \implies x \ne \pm 3$$
2. **Fatoração**:
   * Numerador (fator comum $x$): $x^2 - 3x = x(x - 3)$
   * Denominador (diferença de dois quadrados): $x^2 - 9 = (x + 3)(x - 3)$
3. **Cancelamento**:
   $$\frac{x^2 - 3x}{x^2 - 9} = \frac{x(x - 3)}{(x + 3)(x - 3)} = \frac{x}{x + 3}$$
   * **Resultado**:
     $$\frac{x}{x + 3} \quad \text{para } x \ne -3 \text{ e } x \ne 3$$

---

## Operações com Frações Numéricas

Revisão das regras básicas de operações com frações:
* **a) Adição (mesmo denominador)**:
  $$\frac{2}{3} + \frac{5}{3} = \frac{2 + 5}{3} = \frac{7}{3}$$
* **b) Subtração (denominadores diferentes)**:
  $$\frac{2}{3} - \frac{4}{5} = \frac{2 \cdot 5 - 4 \cdot 3}{3 \cdot 5} = \frac{10 - 12}{15} = -\frac{2}{15}$$
* **c) Multiplicação**:
  $$\frac{2}{3} \cdot \frac{4}{5} = \frac{2 \cdot 4}{3 \cdot 5} = \frac{8}{15}$$
* **d) Divisão**:
  $$\frac{2}{3} \div \frac{4}{5} = \frac{2}{3} \cdot \frac{5}{4} = \frac{10}{12} = \frac{5}{6}$$

---

## Operações com Expressões Racionais

### Exemplo A: Adição
Calcule a soma:
$$\frac{x}{3x - 2} + \frac{3}{x - 5}$$

1. **Denominador comum**: $(3x - 2)(x - 5)$
2. **Desenvolvimento**:
   $$\begin{aligned}
   \frac{x}{3x - 2} + \frac{3}{x - 5} &= \frac{x(x - 5) + 3(3x - 2)}{(3x - 2)(x - 5)} \\
   &= \frac{x^2 - 5x + 9x - 6}{(3x - 2)(x - 5)} \\
   &= \frac{x^2 + 4x - 6}{(3x - 2)(x - 5)}
   \end{aligned}$$
3. **Restrições**:
   $$3x - 2 \ne 0 \implies x \ne \frac{2}{3} \qquad \text{e} \qquad x - 5 \ne 0 \implies x \ne 5$$

---

### Exemplo B: Multiplicação
Simplifique o produto:
$$\frac{2x^2 + 11x - 21}{x^3 + 2x^2 + 4x} \cdot \frac{x^3 - 8}{x^2 + 5x - 14}$$

1. **Fatoração de cada termo**:
   * **Termo 1: $2x^2 + 11x - 21$**
     Utilizando a fórmula de Bhaskara para encontrar as raízes:
     $$\Delta = 11^2 - 4(2)(-21) = 121 + 168 = 289$$
     $$x = \frac{-11 \pm \sqrt{289}}{2 \cdot 2} = \frac{-11 \pm 17}{4} \implies x' = \frac{3}{2}, \quad x'' = -7$$
     Fatoração: $2\left(x - \frac{3}{2}\right)(x + 7) = (2x - 3)(x + 7)$
   * **Termo 2: $x^3 + 2x^2 + 4x$**
     Colocando $x$ em evidência: $x(x^2 + 2x + 4)$ (o termo quadrático não tem raízes reais, pois $\Delta = 4 - 16 = -12 < 0$)
   * **Termo 3: $x^3 - 8$**
     Fatoração pela diferença de cubos: $(x - 2)(x^2 + 2x + 4)$
   * **Termo 4: $x^2 + 5x - 14$**
     Bhaskara: $\Delta = 25 - 4(1)(-14) = 81 \implies x = \frac{-5 \pm 9}{2} \implies x' = 2, \ x'' = -7$
     Fatoração: $(x - 2)(x + 7)$

2. **Substituição e Simplificação**:
   $$\frac{(2x - 3)(x + 7)}{x(x^2 + 2x + 4)} \cdot \frac{(x - 2)(x^2 + 2x + 4)}{(x - 2)(x + 7)}$$
   Cancelando os fatores comuns $(x + 7)$, $(x - 2)$ e $(x^2 + 2x + 4)$:
   $$\frac{2x - 3}{x}$$
3. **Restrições**:
   $$x \ne 0, \quad x \ne -7, \quad x \ne 2$$

---

### Exemplo C: Divisão
Simplifique o quociente:
$$\frac{x^3 + 1}{x^2 - x - 2} \div \frac{x^2 - x + 1}{x^2 - 4x + 4}$$

1. **Inversão da segunda fração**:
   $$\frac{x^3 + 1}{x^2 - x - 2} \cdot \frac{x^2 - 4x + 4}{x^2 - x + 1}$$
2. **Fatoração de cada termo**:
   * **Termo 1: $x^3 + 1$** (Soma de cubos): $(x + 1)(x^2 - x + 1)$
   * **Termo 2: $x^2 - 4x + 4$** (Trinômio quadrado perfeito): $(x - 2)^2$
   * **Termo 3: $x^2 - x - 2$** (Trinômio do 2º grau): raízes $x' = 2, \ x'' = -1 \implies (x - 2)(x + 1)$
   * **Termo 4: $x^2 - x + 1$** (sem raízes reais, pois $\Delta = 1 - 4 = -3 < 0$)
3. **Substituição e Simplificação**:
   $$\frac{(x + 1)(x^2 - x + 1)}{(x - 2)(x + 1)} \cdot \frac{(x - 2)(x - 2)}{x^2 - x + 1}$$
   Cancelando os fatores comuns $(x + 1)$, $(x^2 - x + 1)$ e um dos fatores $(x - 2)$:
   $$x - 2$$
4. **Restrições**:
   Os denominadores originais e o termo que foi invertido não podem ser nulos:
   * $x^2 - x - 2 \ne 0 \implies x \ne 2 \text{ e } x \ne -1$
   * $x^2 - 4x + 4 \ne 0 \implies x \ne 2$
   * $x^2 - x + 1 \ne 0$ (sempre satisfeito nos reais)
   * **Resultado**:
     $$x - 2 \quad \text{para } x \ne 2 \text{ e } x \ne -1$$
