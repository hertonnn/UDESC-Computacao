# Polinômios e Fatoração

## Polinômios

### Definição
Um polinômio na variável real $x$ é toda expressão que pode ser escrita na forma:
$$a_n x^n + a_{n-1} x^{n-1} + \dots + a_2 x^2 + a_1 x + a_0$$

Onde:
* $n$ é um número natural ($\mathbb{N}$) e $a_n \ne 0$.
* Os números $a_n, a_{n-1}, \dots, a_2, a_1, a_0$ são números reais chamados de **coeficientes**.
* O maior expoente da variável (com coeficiente não nulo) define o **grau** do polinômio.

---

### Adição e Subtração de Polinômios
Nessa operação, devemos adicionar ou subtrair apenas os **termos semelhantes** (termos que possuem a mesma variável elevada ao mesmo expoente).

* **Exemplos**:
  * **a)** $(2x^2 + 3x - 2) + (3x^2 - 2x + 6)$
    $$\begin{aligned}
    &= (2x^2 + 3x^2) + (3x - 2x) + (-2 + 6) \\
    &= 5x^2 + x + 4
    \end{aligned}$$
  * **b)** $(-3x^2 + 5x - 8) - (x^3 - 5x^2 + 6)$
    $$\begin{aligned}
    &= -x^3 + (-3x^2 - (-5x^2)) + 5x + (-8 - 6) \\
    &= -x^3 + (-3x^2 + 5x^2) + 5x - 14 \\
    &= -x^3 + 2x^2 + 5x - 14
    \end{aligned}$$
    *(Nota de correção: no slide original, o termo $5x^2$ estava com sinal trocado no desenvolvimento, mas a regra geral de subtração requer a distribuição do sinal negativo a todos os termos do segundo polinômio)*

---

### Multiplicação de Polinômios
Nessa operação, multiplicamos cada termo de um polinômio por todos os termos do outro polinômio (propriedade distributiva) e depois agrupamos os termos semelhantes.

* **Exemplos**:
  * **a)** $(2x^2 - 2)(-2x + 6)$
    $$\begin{aligned}
    &= 2x^2 \cdot (-2x) + 2x^2 \cdot 6 + (-2) \cdot (-2x) + (-2) \cdot 6 \\
    &= -4x^3 + 12x^2 + 4x - 12
    \end{aligned}$$
  * **b)** $(-3x^4 + 5x^3 - 8)(x^2 - 6)$
    $$\begin{aligned}
    &= (-3x^4) \cdot x^2 + (-3x^4) \cdot (-6) + 5x^3 \cdot x^2 + 5x^3 \cdot (-6) + (-8) \cdot x^2 + (-8) \cdot (-6) \\
    &= -3x^6 + 18x^4 + 5x^5 - 30x^3 - 8x^2 + 48 \\
    &= -3x^6 + 5x^5 + 18x^4 - 30x^3 - 8x^2 + 48
    \end{aligned}$$

---

## Produtos Notáveis
São identidades algébricas que facilitam a simplificação e a multiplicação de expressões.

### Caso 1: Quadrado da soma de dois termos
$$(x + y)^2 = (x + y)(x + y) = x^2 + xy + xy + y^2 = x^2 + 2xy + y^2$$

* **Regra geral**:
  $$(\text{1º termo} + \text{2º termo})^2 = (\text{1º termo})^2 + 2 \cdot (\text{1º termo}) \cdot (\text{2º termo}) + (\text{2º termo})^2$$
* **Exemplo**:
  $$(3x + 2)^2 = (3x)^2 + 2 \cdot (3x) \cdot (2) + (2)^2 = 9x^2 + 12x + 4$$

### Caso 2: Quadrado da diferença de dois termos
$$(x - y)^2 = (x - y)(x - y) = x^2 - xy - xy + y^2 = x^2 - 2xy + y^2$$

* **Regra geral**:
  $$(\text{1º termo} - \text{2º termo})^2 = (\text{1º termo})^2 - 2 \cdot (\text{1º termo}) \cdot (\text{2º termo}) + (\text{2º termo})^2$$
* **Exemplo**:
  $$(x - 2)^2 = x^2 - 2 \cdot x \cdot 2 + (2)^2 = x^2 - 4x + 4$$

### Caso 3: Produto da soma pela diferença de dois termos
$$(x + y)(x - y) = x^2 - xy + xy - y^2 = x^2 - y^2$$

* **Regra geral**:
  $$(\text{1º termo} + \text{2º termo})(\text{1º termo} - \text{2º termo}) = (\text{1º termo})^2 - (\text{2º termo})^2$$
* **Exemplo**:
  $$(x + 2)(x - 2) = x^2 - 2^2 = x^2 - 4$$

---

### Exercícios Resolvidos de Produtos Notáveis
Desenvolva as expressões:
* **a)** $(5y - 4)^2$
  $$(5y - 4)^2 = (5y)^2 - 2(5y)(4) + 4^2 = 25y^2 - 40y + 16$$
* **b)** $(-2x - 3)^2$
  $$(-2x - 3)^2 = (-2x)^2 - 2(-2x)(3) + 3^2 = 4x^2 + 12x + 9$$
* **c)** $(y + 4)^2$
  $$(y + 4)^2 = y^2 + 2(y)(4) + 4^2 = y^2 + 8y + 16$$
* **d)** $(x - 2y)^2$
  $$(x - 2y)^2 = x^2 - 2(x)(2y) + (2y)^2 = x^2 - 4xy + 4y^2$$
* **e)** $(3x + 8)(3x - 8)$
  $$(3x + 8)(3x - 8) = (3x)^2 - 8^2 = 9x^2 - 64$$

---

## Fatoração
Fatorar é o processo inverso do desenvolvimento, consistindo em escrever um polinômio como um produto de outros polinômios de menor grau.

### Caso 1: Colocação de fator comum em evidência
Identificamos os fatores que aparecem em todos os termos do polinômio e os colocamos em evidência.
* **Exemplos**:
  * **a)** $2x^3 + 2x^2 - 6x$
    O termo comum é $2x$:
    $$2x^3 + 2x^2 - 6x = 2x(x^2 + x - 3)$$
  * **b)** $u^3v + uv^3$
    O termo comum é $uv$:
    $$u^3v + uv^3 = uv(u^2 + v^2)$$

### Caso 2: Fatoração da diferença de dois quadrados
Utiliza a identidade inversa do produto da soma pela diferença:
$$A^2 - B^2 = (A + B)(A - B)$$

* **Exemplos**:
  * **a)** $25x^2 - 36$
    $$25x^2 - 36 = (5x)^2 - 6^2 = (5x + 6)(5x - 6)$$
  * **b)** $4y^2 - 25x^4$
    $$4y^2 - 25x^4 = (2y)^2 - (5x^2)^2 = (2y + 5x^2)(2y - 5x^2)$$

### Caso 3: Fatoração de trinômios quadrados perfeitos
Identifica se o trinômio é resultado de um quadrado da soma ou da diferença:
$$A^2 \pm 2AB + B^2 = (A \pm B)^2$$

* **Exemplos**:
  * **a)** $9x^2 + 6x + 1$
    Como $\sqrt{9x^2} = 3x$, $\sqrt{1} = 1$ e $2(3x)(1) = 6x$ (termo central):
    $$9x^2 + 6x + 1 = (3x + 1)^2$$
  * **b)** $4x^2 - 12xy + 9y^2$
    Como $\sqrt{4x^2} = 2x$, $\sqrt{9y^2} = 3y$ e $2(2x)(3y) = 12xy$ (termo central):
    $$4x^2 - 12xy + 9y^2 = (2x - 3y)^2$$

---

### Caso 4: Fatoração de trinômios da forma $ax^2 + bx + c$
Para fatorar o trinômio $ax^2 + bx + c$ como um produto de binômios com coeficientes inteiros:
$$ax^2 + bx + c = (p_1 x + q_1)(p_2 x + q_2)$$

Devemos determinar inteiros tais que:
* $p_1 \cdot p_2 = a$ (fatores de $a$)
* $q_1 \cdot q_2 = c$ (fatores de $c$)
* $p_1 q_2 + p_2 q_1 = b$ (soma cruzada)

#### Exemplo Prático: Fatorar $x^2 + 5x - 14$
Aqui temos $a = 1$, $b = 5$, $c = -14$.
* **Fatores de $a=1$**:
  * $1 \cdot 1$ ou $(-1) \cdot (-1)$
* **Fatores de $c=-14$**:
  * $1 \cdot (-14)$
  * $(-1) \cdot 14$
  * $2 \cdot (-7)$
  * $(-2) \cdot 7$

Avaliando as possíveis combinações de fatores de $a$ e $c$:
1. $(x + 1)(x - 14) = x^2 - 13x - 14 \quad (\text{Incorreto, } b = -13)$
2. $(x - 1)(x + 14) = x^2 + 13x - 14 \quad (\text{Incorreto, } b = 13)$
3. $(x + 2)(x - 7) = x^2 - 5x - 14 \quad (\text{Incorreto, } b = -5)$
4. $(x - 2)(x + 7) = x^2 + 5x - 14 \quad (\text{Correto! } b = 5)$

> **Fatoração final**:
> $$x^2 + 5x - 14 = (x - 2)(x + 7)$$

---

### Caso 5: Fatoração por agrupamento
Agrupamos os termos que possuem fatores comuns parciais, colocamos esses fatores em evidência e, em seguida, colocamos o polinômio comum resultante em evidência.

* **Exemplos**:
  * **a)** $3x^3 + x^2 - 6x - 2$
    Agrupando de dois em dois:
    $$3x^3 + x^2 - 6x - 2 = x^2(3x + 1) - 2(3x + 1)$$
    Colocando o binômio $(3x + 1)$ em evidência:
    $$= (3x + 1)(x^2 - 2)$$
  * **b)** $2ac - 2ad + bc - bd$
    Agrupando por $2a$ e $b$:
    $$2ac - 2ad + bc - bd = 2a(c - d) + b(c - d)$$
    Colocando o binômio $(c - d)$ em evidência:
    $$= (c - d)(2a + b)$$
