# Função Modular e Funções Polinomiais

Este documento apresenta as definições e propriedades da função modular, além de conceitos fundamentais das funções polinomiais, incluindo raízes, divisão de polinômios e teoremas relacionados.

---

## 1. Função Modular

### Definição
Chamamos de **função modular** a função $f(x) = |x|$, definida por:

$$
f(x) = 
\begin{cases} 
x, & \text{se } x \geq 0 \\ 
-x, & \text{se } x < 0 
\end{cases}
$$

A função modular é uma função definida por duas sentenças. O seu domínio é o conjunto dos números reais ($D = \mathbb{R}$) e a sua imagem é o conjunto dos números reais não negativos ($Im = \mathbb{R}_+$).

![Gráfico da Função Modular 2](./imagens/Função%20Modular%20e%20Funções%20Polinomiais/slide_3_img_2.png)

### Exemplo 1: $f(x) = |3x + 4|$

Pela definição:
$$
f(x) = 
\begin{cases} 
3x + 4, & \text{se } 3x + 4 \geq 0 \\ 
-(3x + 4), & \text{se } 3x + 4 < 0 
\end{cases}
\implies
f(x) = 
\begin{cases} 
3x + 4, & \text{se } x \geq -\frac{4}{3} \\ 
-3x - 4, & \text{se } x < -\frac{4}{3} 
\end{cases}
$$
**Domínio:** $\mathbb{R}$. **Imagem:** $\mathbb{R}_+$.
![Resolução Exemplo 1](./imagens/Função%20Modular%20e%20Funções%20Polinomiais/slide_4_img_2.png)

### Exemplo 2: $f(x) = |-x + 7|$

Pela definição:
$$
f(x) = 
\begin{cases} 
-x + 7, & \text{se } -x + 7 \geq 0 \\ 
-(-x + 7), & \text{se } -x + 7 < 0 
\end{cases}
\implies
f(x) = 
\begin{cases} 
-x + 7, & \text{se } x \leq 7 \\ 
x - 7, & \text{se } x > 7 
\end{cases}
$$
**Domínio:** $\mathbb{R}$. **Imagem:** $\mathbb{R}_+$.
![Resolução Exemplo 2](./imagens/Função%20Modular%20e%20Funções%20Polinomiais/slide_5_img_2.png)

### Exemplo 3: $f(x) = |x^2 + 3x - 10|$

$$
f(x) = 
\begin{cases} 
x^2 + 3x - 10, & \text{se } x^2 + 3x - 10 \geq 0 \\ 
-(x^2 + 3x - 10), & \text{se } x^2 + 3x - 10 < 0 
\end{cases}
$$
Resolvendo a desigualdade:
$$
f(x) = 
\begin{cases} 
x^2 + 3x - 10, & \text{se } x \leq -5 \text{ ou } x \geq 2 \\ 
-x^2 - 3x + 10, & \text{se } -5 < x < 2 
\end{cases}
$$
**Domínio:** $\mathbb{R}$. **Imagem:** $\mathbb{R}_+$.

### Exemplo 4: $f(x) = |x - 3| + 2$

$$
f(x) = 
\begin{cases} 
(x - 3) + 2, & \text{se } x - 3 \geq 0 \\ 
-(x - 3) + 2, & \text{se } x - 3 < 0 
\end{cases}
\implies
f(x) = 
\begin{cases} 
x - 1, & \text{se } x \geq 3 \\ 
-x + 5, & \text{se } x < 3 
\end{cases}
$$
**Domínio:** $\mathbb{R}$. **Imagem:** $[2, +\infty[$.

### Exemplo 5: $f(x) = |2x - 4| + |x - 1|$

Separando as raízes: $x = 2$ e $x = 1$. Os intervalos serão: $x < 1$, $1 \leq x < 2$ e $x \geq 2$.
$$
f(x) = 
\begin{cases} 
-(2x - 4) - (x - 1) = -3x + 5, & \text{se } x < 1 \\ 
-(2x - 4) + (x - 1) = -x + 3, & \text{se } 1 \leq x < 2 \\ 
(2x - 4) + (x - 1) = 3x - 5, & \text{se } x \geq 2 
\end{cases}
$$
**Domínio:** $\mathbb{R}$. **Imagem:** $[1, +\infty[$.

---

## 2. Funções Polinomiais

### Definição
Um polinômio de grau $n$ tem a forma geral:
$$P(x) = a_n x^n + a_{n-1} x^{n-1} + \dots + a_1 x + a_0$$

### Raízes das Funções Polinomiais
As raízes de um polinômio $P(x)$ são os valores de $x$ que tornam $P(x) = 0$.


#### Exemplo 6: Encontre as raízes de $f(x) = (x - 2)^3 (x + 1)^2$
As raízes podem ser obtidas diretamente dos fatores:
- $x - 2 = 0 \implies x = 2$ (raiz de multiplicidade 3)
- $x + 1 = 0 \implies x = -1$ (raiz de multiplicidade 2)

### Divisão de Polinômios
Ao dividirmos um polinômio $P(x)$ por $D(x)$, encontramos um quociente $Q(x)$ e um resto $R(x)$, tal que:
$$P(x) = D(x) \cdot Q(x) + R(x)$$

### Teorema do Resto e Teorema de D'Alembert
**Teorema do Resto:** O resto da divisão de um polinômio $P(x)$ pelo binômio $x - a$ é igual ao valor numérico do polinômio para $x = a$, ou seja, $R = P(a)$.
**Teorema de D'Alembert:** Um polinômio $P(x)$ é divisível por $x - a$ se, e somente se, $a$ for raiz de $P(x)$, ou seja, se $P(a) = 0$.


### Divisão por Briot-Ruffini
O dispositivo de Briot-Ruffini é um método prático para a divisão de um polinômio $P(x)$ por um binômio da forma $(x - a)$.

### Teorema das Raízes Racionais
Se um polinômio $P(x) = a_n x^n + \dots + a_1 x + a_0$, com coeficientes inteiros, admite uma raiz racional $\frac{p}{q}$ (fração irredutível), então:
- $p$ é um divisor do termo independente $a_0$.
- $q$ é um divisor do coeficiente principal $a_n$.

---

## Exercícios
1) Livro Texto: 
   - página 133 – Exercícios do 9 ao 12
   - página 134 – Exercícios do 25 ao 38
   - página 135 – Exercícios do 50 ao 58
   - página 136 – Exercícios do 61 ao 86
   - página 137 – Exercícios do 93 ao 104
   - página 138 – Exercícios do 109 ao 118
