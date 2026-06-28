# Função Inversa

Este documento aborda o conceito de **função inversa**, que permite reverter o mapeamento de uma função, tornando o que era imagem em domínio e vice-versa. É um tópico fundamental para compreender logaritmos, funções trigonométricas inversas e diversas outras áreas do cálculo.

---

## 1. Definição

Dada uma função $f: A \to B$, dizemos que $f$ é **inversível** se existe uma função $f^{-1}: B \to A$ tal que:

$$f^{-1}(f(x)) = x, \quad \forall x \in A$$
$$f(f^{-1}(y)) = y, \quad \forall y \in B$$

A função $f^{-1}$ é chamada de **função inversa** de $f$. Uma função admite inversa se, e somente se, ela for **bijetora** (simultaneamente injetora e sobrejetora), ou seja, cada elemento do contradomínio deve ter exatamente uma pré-imagem no domínio.

> **Observação:** A notação $f^{-1}(x)$ **não** significa $\frac{1}{f(x)}$. O expoente $-1$ indica a função inversa, não o recíproco.

### Relação Inversa
O par ordenado $(a, b)$ pertence a uma relação somente se o par ordenado $(b, a)$ pertence à sua relação inversa.

### Teste da Linha Horizontal
A inversa de uma relação é uma função somente se cada linha horizontal intersecciona o gráfico da relação original no máximo em um ponto. Se for possível traçar uma linha horizontal que cruze o gráfico em mais de um ponto (como no caso da parábola $y = x^2$ para todo $x$ real), a sua relação inversa não representará uma função (pois um mesmo elemento do domínio da inversa seria mapeado em mais de um elemento no contradomínio).

---

## 2. Como Encontrar a Função Inversa

O procedimento para determinar a função inversa de uma função $f(x)$ segue os seguintes passos:

1. **Escrever $y = f(x)$**
2. **Isolar $x$ em função de $y$**, resolvendo a equação para $x$
3. **Trocar os papéis de $x$ e $y$** para obter $f^{-1}(x)$
4. **Verificar o domínio** — o domínio de $f^{-1}$ é a imagem de $f$

---

## 3. Exemplos Resolvidos

### Exemplo 1 — Encontre uma equação para $f^{-1}(x)$ se $f(x) = \dfrac{x}{x + 1}$

Fazemos $y = \dfrac{x}{x + 1}$ e isolamos $x$:

$$y(x + 1) = x \implies xy + y = x \implies y = x - xy \implies y = x(1 - y) \implies x = \frac{y}{1 - y}$$

Trocando os papéis de $x$ e $y$ para obter a fórmula da inversa:

$$f^{-1}(x) = \frac{x}{1 - x}$$

Como o domínio de $f$ exclui $x = -1$ e a sua imagem exclui $y = 1$, o domínio de $f^{-1}$ é $\{x \in \mathbb{R} \mid x \neq 1\}$.

### Exemplo 2 — Encontre a função inversa de $f(x) = \sqrt{x + 3}$

Fazemos $y = \sqrt{x + 3}$ e isolamos $x$:

$$y^2 = x + 3 \implies x = y^2 - 3$$

Trocando $x \leftrightarrow y$:

$$f^{-1}(x) = x^2 - 3, \quad x \geq 0$$

> Note que o domínio de $f^{-1}$ é restrito a $x \geq 0$ pois a imagem de $f$ é $[0, +\infty)$.

**Verificação:**
* $f(f^{-1}(x)) = f(x^2 - 3) = \sqrt{(x^2 - 3) + 3} = \sqrt{x^2} = x$ (pois $x \geq 0$)
* $f^{-1}(f(x)) = f^{-1}(\sqrt{x + 3}) = (\sqrt{x + 3})^2 - 3 = x + 3 - 3 = x$ (para $x \geq -3$)

### Exemplo 3 — Encontre a função inversa de $f(x) = \dfrac{x + 3}{x - 2}$

Fazemos $y = \frac{x+3}{x-2}$ e isolamos $x$:

$$y(x - 2) = x + 3 \implies xy - 2y = x + 3 \implies xy - x = 2y + 3 \implies x(y - 1) = 2y + 3 \implies x = \frac{2y + 3}{y - 1}$$

Trocando $x \leftrightarrow y$:

$$f^{-1}(x) = \frac{2x + 3}{x - 1}, \quad x \neq 1$$

**Verificação:**
$$f(f^{-1}(x)) = \frac{\frac{2x + 3}{x - 1} + 3}{\frac{2x + 3}{x - 1} - 2}$$

Multiplicando o numerador e o denominador por $x - 1$:
$$f(f^{-1}(x)) = \frac{(2x + 3) + 3(x - 1)}{(2x + 3) - 2(x - 1)} = \frac{2x + 3 + 3x - 3}{2x + 3 - 2x + 2} = \frac{5x}{5} = x$$

---

## 4. Gráfico da Função Inversa

O gráfico de $f^{-1}$ é a **reflexão** do gráfico de $f$ em relação à reta $y = x$ (bissetriz dos quadrantes ímpares). Isso ocorre porque a inversão troca os papéis de $x$ e $y$: o ponto $(a, b)$ pertencente ao gráfico de $f$ corresponde ao ponto $(b, a)$ no gráfico de $f^{-1}$.

---

## 5. Exercícios
1) Livro Texto: páginas 197 e 198
