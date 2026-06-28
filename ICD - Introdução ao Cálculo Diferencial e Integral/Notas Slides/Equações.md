# Equações

## Introdução

Uma **equação** é uma sentença matemática expressa por uma relação de igualdade entre duas expressões algébricas.
* **Exemplos**:
  * $5x^3 = 2x + 4$
  * $\frac{5y - 2}{8} = 2 + \frac{y}{4}$
  * $(2x - 1)^2 = 9$

---

## Verificação de uma Solução

Dizemos que um número real $r$ é uma **solução** (ou raiz) de uma equação se, ao substituirmos a variável por $r$, a igualdade se torna uma sentença verdadeira.

### Exemplo: Prove que $x = -2$ é uma solução da equação $x^3 - x + 6 = 0$
Substituindo $x = -2$ na equação:
$$(-2)^3 - (-2) + 6 = 0$$
$$(-8) + 2 + 6 = 0$$
$$-8 + 8 = 0$$
$$0 = 0 \quad (\text{Sentença Verdadeira})$$
Portanto, provamos que $x = -2$ é uma solução da equação.

---

## Equações Lineares com uma Variável

### Definição: Equação linear em $x$
Uma **equação linear em $x$** é toda equação que pode ser escrita na forma:
$$ax + b = 0$$
onde $a$ e $b$ são números reais e $a \ne 0$.

---

### Exemplo 1: Resolução de uma equação linear
Resolva a equação:
$$2(2x - 3) + 3(x + 1) = 5x + 2$$

1. **Desenvolvimento (distributiva)**:
   $$4x - 6 + 3x + 3 = 5x + 2$$
2. **Agrupamento dos termos semelhantes**:
   $$(4x + 3x) - 3 = 5x + 2$$
   $$7x - 3 = 5x + 2$$
3. **Isolando a variável $x$**:
   $$7x - 5x = 2 + 3$$
   $$2x = 5$$
   $$x = \frac{5}{2} = 2,5$$
* **Solução**: $x = 2,5$.

---

### Exemplo 2: Resolução de uma equação linear com frações
Resolva a equação:
$$\frac{5y - 2}{8} = 2 + \frac{y}{4}$$

* **Método 1: Redução ao mesmo denominador (MMC)**
  1. Encontrando o MMC entre $8$ e $4$, que é $8$:
     $$\frac{5y - 2}{8} = \frac{16}{8} + \frac{2y}{8}$$
     $$\frac{5y - 2}{8} = \frac{16 + 2y}{8}$$
  2. Multiplicando ambos os lados por $8$ (cancelando os denominadores):
     $$5y - 2 = 16 + 2y$$
  3. Resolvendo para $y$:
     $$5y - 2y = 16 + 2$$
     $$3y = 18$$
     $$y = \frac{18}{3} = 6$$

* **Método 2: Multiplicação Cruzada (após MMC parcial no lado direito)**
  1. Somando os termos do lado direito com MMC $4$:
     $$\frac{5y - 2}{8} = \frac{8 + y}{4}$$
  2. Multiplicando cruzado:
     $$4(5y - 2) = 8(8 + y)$$
     $$20y - 8 = 64 + 8y$$
  3. Isolando $y$:
     $$20y - 8y = 64 + 8$$
     $$12y = 72$$
     $$y = \frac{72}{12} = 6$$
* **Solução**: $y = 6$.

---

## Soluções de Equações por meio de Gráficos

A solução de uma equação da forma $f(x) = 0$ pode ser compreendida de duas maneiras:
1. **Algébrica**: Encontrar os valores que satisfazem a igualdade por meio de manipulações algébricas.
2. **Geométrica**: Encontrar os pontos de interseção da curva $y = f(x)$ com o eixo das abscissas ($eixo\ x$, onde $y = 0$).

---

### Exemplo 1: Equação Linear
Resolva a equação $2x + 6 = 0$ algébrica e geometricamente.

* **Resolução Algébrica**:
  $$2x + 6 = 0 \implies 2x = -6 \implies x = -\frac{6}{2} = -3$$
* **Resolução Geométrica**:
  A solução corresponde à raiz da função afim $y = 2x + 6$.
  * **Tabela de pontos**:

    | $x$ | $y = 2x + 6$ | Ponto |
    | :--- | :--- | :--- |
    | $-3$ | $2(-3) + 6 = 0$ | $(-3, 0)$ (Interseção com o eixo $x$) |
    | $-2$ | $2(-2) + 6 = 2$ | $(-2, 2)$ |
    | $-1$ | $2(-1) + 6 = 4$ | $(-1, 4)$ |
    | $0$ | $2(0) + 6 = 6$ | $(0, 6)$ (Interseção com o eixo $y$) |

  * Ao traçarmos a reta que passa por esses pontos, observamos que ela cruza o eixo horizontal exatamente na coordenada $x = -3$.

---

### Exemplo 2: Equação Quadrática
Resolva a equação $x^2 - 5x + 4 = 0$ algébrica e geometricamente.

* **Resolução Algébrica**:
  Fatorando o trinômio por termo comum (produto e soma: dois números com produto $4$ e soma $-5$, que são $-4$ e $-1$):
  $$x^2 - 5x + 4 = 0 \implies (x - 4)(x - 1) = 0$$
  $$x - 4 = 0 \implies x = 4 \qquad \text{ou} \qquad x - 1 = 0 \implies x = 1$$
* **Resolução Geométrica**:
  Esboçando a parábola $y = x^2 - 5x + 4$.
  * **Tabela de pontos**:

    | $x$ | $y = x^2 - 5x + 4$ | Ponto |
    | :--- | :--- | :--- |
    | $-1$ | $(-1)^2 - 5(-1) + 4 = 10$ | $(-1, 10)$ |
    | $0$ | $0^2 - 5(0) + 4 = 4$ | $(0, 4)$ |
    | $1$ | $1^2 - 5(1) + 4 = 0$ | $(1, 0)$ (Raiz / Interseção) |
    | $2$ | $2^2 - 5(2) + 4 = -2$ | $(2, -2)$ |
    | $3$ | $3^2 - 5(3) + 4 = -2$ | $(3, -2)$ |
    | $4$ | $4^2 - 5(4) + 4 = 0$ | $(4, 0)$ (Raiz / Interseção) |
    | $5$ | $5^2 - 5(5) + 4 = 4$ | $(5, 4)$ |

  * O vértice da parábola localiza-se em $x_v = 2,5$ e $y_v = -2,25$. As interseções com o eixo $x$ ocorrem nos pontos $(1,0)$ e $(4,0)$, confirmando graficamente as soluções $x=1$ e $x=4$.

---

## Equações Quadráticas

### Definição: Equação quadrática em $x$
Uma **equação quadrática em $x$** é toda equação que pode ser escrita na forma:
$$ax^2 + bx + c = 0$$
onde $a$, $b$ e $c$ são números reais e $a \ne 0$.

### Fórmula de Bhaskara
As soluções da equação quadrática $ax^2 + bx + c = 0$ são dadas por:
$$x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$$
Onde $\Delta = b^2 - 4ac$ é o discriminante:
* Se $\Delta > 0$, a equação possui duas soluções reais distintas.
* Se $\Delta = 0$, a equação possui uma única solução real (raiz dupla).
* Se $\Delta < 0$, a equação não possui soluções reais.

---

### Exemplo: Resolução de equação quadrática
Resolva a equação:
$$x^2 - 4x - 5 = 0$$

1. **Identificação dos coeficientes**: $a = 1$, $b = -4$, $c = -5$.
2. **Cálculo do discriminante ($\Delta$)**:
   $$\Delta = b^2 - 4ac = (-4)^2 - 4(1)(-5) = 16 + 20 = 36$$
3. **Cálculo das raízes**:
   $$x = \frac{-(-4) \pm \sqrt{36}}{2(1)} = \frac{4 \pm 6}{2}$$
   * **Primeira raiz ($x'$)**:
     $$x' = \frac{4 + 6}{2} = \frac{10}{2} = 5$$
   * **Segunda raiz ($x''$)**:
     $$x'' = \frac{4 - 6}{2} = \frac{-2}{2} = -1$$
* **Soluções**: $x = 5$ e $x = -1$.

---

## Equações Modulares

Equações modulares envolvem a variável dentro de um valor absoluto (módulo). Requerem a aplicação da definição de módulo:
$$\lvert u \rvert = a \implies u = a \quad \text{ou} \quad u = -a \qquad (\text{para } a \ge 0)$$

---

### Exemplo 1: Equação modular com segundo membro constante
Resolva a equação:
$$\lvert 2x - 3 \rvert = 7$$

Como $7 \ge 0$, dividimos o problema em dois casos:
* **Caso 1**:
  $$2x - 3 = 7 \implies 2x = 10 \implies x = 5$$
* **Caso 2**:
  $$2x - 3 = -7 \implies 2x = -4 \implies x = -2$$
* **Soluções**: $x = 5$ e $x = -2$.

---

### Exemplo 2: Equação modular com segundo membro variável
Resolva a equação:
$$\lvert x - 3 \rvert = 3x - 5$$

1. **Condição de existência**:
   O resultado do módulo deve ser não negativo:
   $$3x - 5 \ge 0 \implies 3x \ge 5 \implies x \ge \frac{5}{3}$$
2. **Resolução dos casos**:
   * **Caso 1**:
     $$x - 3 = 3x - 5$$
     $$x - 3x = -5 + 3$$
     $$-2x = -2 \implies x = 1$$
   * **Caso 2**:
     $$x - 3 = -(3x - 5) \implies x - 3 = -3x + 5$$
     $$x + 3x = 5 + 3$$
     $$4x = 8 \implies x = 2$$
3. **Verificação (teste das soluções)**:
   * **Para $x = 1$**:
     $$\lvert 1 - 3 \rvert = 3(1) - 5 \implies \lvert -2 \rvert = -2 \implies 2 = -2 \quad (\text{Falso!})$$
     *(Note que $x = 1 < \frac{5}{3}$)*
   * **Para $x = 2$**:
     $$\lvert 2 - 3 \rvert = 3(2) - 5 \implies \lvert -1 \rvert = 6 - 5 \implies 1 = 1 \quad (\text{Verdadeiro!})$$
     *(Note que $x = 2 \ge \frac{5}{3}$)*
* **Solução**: $x = 2$.
