# Equações Lineares e Sistemas de Equações Lineares



Álgebra Linear 
Equações Lineares
Sistemas de Equações Lineares

---

### Definição


Uma equação linear em $n$ variáveis (ou incógnitas) é uma equação da forma:

```math
a_1x_1 + a_2x_2 + a_3x_3 + \dots + a_nx_n = b
```

Nomenclatura:
- $a_1, a_2, a_3, \dots, a_n \in \mathbb{R}$ são chamados de coeficientes;
- $x_1, x_2, x_3, \dots, x_n$ são as variáveis (ou incógnitas);
- $b \in \mathbb{R}$ é dito termo independente.

### Exemplos e Contraexemplos

- $4x_1 - 7x_2 + 9x_3 - 5x_4 = 3$: é linear, com $a_1 = 4$, $a_2 = -7$, $a_3 = 9$, $a_4 = -5$, $b = 3$.
- $-x + 5y + 3z/2 = 0$: é linear, com $a_1 = -1$, $a_2 = 5$, $a_3 = 3/2$, $b = 0$.
- $8x + 3y - 2xyz = 0$: não é linear, devido ao produto $xyz$.
- $x^5 + 2e^y - 5\cos(z) = 4$: não é linear, devido aos fatores $x^5$, $e^y$, $\cos(z)$.
- $2x + e^8y + \ln(3)z = 7$: é linear, com $a_1 = 2$, $a_2 = e^8$, $a_3 = \ln(3)$.

Em ALI vamos considerar somente equações lineares em todas as variáveis!

Forma Matricial: 
```math
\begin{bmatrix}
a_1 & a_2 & a_3 & \dots & a_n
\end{bmatrix}
\cdot
\begin{bmatrix}
x_1 \\
x_2 \\
x_3 \\
\vdots \\
x_n
\end{bmatrix}
=
b
```

---

### Sistemas de Equações Lineares – Caracterização Geral


Um sistema de $m$ equações lineares a $n$ variáveis é da forma:

```math
\begin{cases}
a_{11}x_1 + a_{12}x_2 + a_{13}x_3 + \dots + a_{1n}x_n = b_1 \\
a_{21}x_1 + a_{22}x_2 + a_{23}x_3 + \dots + a_{2n}x_n = b_2 \\
a_{31}x_1 + a_{32}x_2 + a_{33}x_3 + \dots + a_{3n}x_n = b_3 \\
\vdots \\
a_{m1}x_1 + a_{m2}x_2 + a_{m3}x_3 + \dots + a_{mn}x_n = b_m
\end{cases}
```

Quando todos os termos independentes são nulos ($b_i = 0$) o sistema é dito homogêneo.

Uma solução para o sistema linear é uma sequência ordenada $(x_1, x_2, x_3, \dots, x_n)$ que satisfaça simultaneamente todas as equações do sistema.

### Exemplo 1

Verifique se a tripla ordenada $(5, 1, -1)$ é uma solução para o sistema linear

```math
\begin{cases}
x - 2y + 3z = 0 \\
-2x + 3y - z = -6 \\
3x + 4y - 13z = 32
\end{cases}
```

Como

```math
5 - 2 \cdot 1 + 3 \cdot (-1) = 0
```
```math
-2 \cdot 5 + 3 \cdot 1 - (-1) = -6
```
```math
3 \cdot 5 + 4 \cdot 1 - 13 \cdot (-1) = 32
```

temos que $(5, 1, -1)$ é uma solução do sistema dado.

---

### Sistemas de Equações Lineares – Representação Matricial



Todo sistema de $m$ equações lineares a $n$ variáveis

```math
\begin{cases}
a_{11}x_1 + a_{12}x_2 + a_{13}x_3 + \dots + a_{1n}x_n = b_1 \\
a_{21}x_1 + a_{22}x_2 + a_{23}x_3 + \dots + a_{2n}x_n = b_2 \\
a_{31}x_1 + a_{32}x_2 + a_{33}x_3 + \dots + a_{3n}x_n = b_3 \\
\vdots \\
a_{m1}x_1 + a_{m2}x_2 + a_{m3}x_3 + \dots + a_{mn}x_n = b_m
\end{cases}
```

pode ser escrito sob a forma de um produto de matrizes:

```math
\begin{bmatrix}
a_{11} & a_{12} & a_{13} & \dots & a_{1n} \\
a_{21} & a_{22} & a_{23} & \dots & a_{2n} \\
a_{31} & a_{32} & a_{33} & \dots & a_{3n} \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
a_{m1} & a_{m2} & a_{m3} & \dots & a_{mn}
\end{bmatrix}
\cdot
\begin{bmatrix}
x_1 \\
x_2 \\
x_3 \\
\vdots \\
x_n
\end{bmatrix}
=
\begin{bmatrix}
b_1 \\
b_2 \\
b_3 \\
\vdots \\
b_m
\end{bmatrix}
```

que denotaremos por $A_{m \times n} \cdot X_{n \times 1} = B_{m \times 1}$.

Note que as ordens das matrizes são tais que $A \cdot X = B$.
Note que para o produto de matrizes $A \cdot X$ estar definido, é preciso que o número de colunas da matriz $A$ seja igual ao número de linhas da matriz $X$.

---

### Sistemas de Equações Lineares – Matriz Ampliada


Podemos simplificar a representação matricial de um sistema de equações lineares tomando a matriz ampliada do sistema, dada por:

```math
[A|B] = 
\begin{bmatrix}
a_{11} & a_{12} & a_{13} & \dots & a_{1n} & \mid & b_1 \\
a_{21} & a_{22} & a_{23} & \dots & a_{2n} & \mid & b_2 \\
a_{31} & a_{32} & a_{33} & \dots & a_{3n} & \mid & b_3 \\
\vdots & \vdots & \vdots & \ddots & \vdots & \mid & \vdots \\
a_{m1} & a_{m2} & a_{m3} & \dots & a_{mn} & \mid & b_m
\end{bmatrix}
```

Isso só é possível pois $A$ e $B$ são matrizes com a mesma quantidade de linhas!

### Exemplo 2

O sistema
```math
\begin{cases}
x - 3y = -9 \\
-6x + 7y = -1
\end{cases}
```

pode ser escrito na forma matricial como

```math
\begin{bmatrix}
1 & -3 \\
-6 & 7
\end{bmatrix}
\cdot
\begin{bmatrix}
x \\
y
\end{bmatrix}
=
\begin{bmatrix}
-9 \\
-1
\end{bmatrix}
```

e a sua matriz ampliada é

```math
[A|B] =
\begin{bmatrix}
1 & -3 & \mid & -9 \\
-6 & 7 & \mid & -1
\end{bmatrix}
```

Ainda, sua solução $x = 6$ e $y = 5$ pode ser escrita matricialmente como $X = \begin{bmatrix} 6 \\ 5 \end{bmatrix}$.

---

### Exemplo 3


O sistema 
```math
\begin{cases}
x - 2y + 3z = 0 \\
-2x + 3y - z = -6 \\
3x + 4y - 13z = 32
\end{cases}
```

pode ser escrito na forma matricial como

```math
\begin{bmatrix}
1 & -2 & 3 \\
-2 & 3 & -1 \\
3 & 4 & -13
\end{bmatrix}
\cdot
\begin{bmatrix}
x \\
y \\
z
\end{bmatrix}
=
\begin{bmatrix}
0 \\
-6 \\
32
\end{bmatrix}
```

A matriz ampliada do sistema é

```math
[A|B] =
\begin{bmatrix}
1 & -2 & 3 & \mid & 0 \\
-2 & 3 & -1 & \mid & -6 \\
3 & 4 & -13 & \mid & 32
\end{bmatrix}
```

A solução do sistema, dada por $x = 5$, $y = 1$ e $z = -1$ pode ser escrita matricialmente como

```math
X = \begin{bmatrix} 5 \\ 1 \\ -1 \end{bmatrix}
```

---

### Interpretação Geométrica de Sistemas 2 por 2




Geometricamente, uma equação linear com duas variáveis, da forma $a_1x + a_2y = b_1$ representa uma reta em $\mathbb{R}^2$. Dessa forma, um sistema com duas equações lineares a duas variáveis permite obter a interseção entre duas retas em $\mathbb{R}^2$.

### Exemplo 4

Qual a interseção entre as retas $x - 2y = 9$ e $-5x + 7y = -6$?

Basta resolver (se possível) o sistema:
```math
\begin{cases}
x - 2y = 9 \\
-5x + 7y = -6
\end{cases}
```

Somando a segunda equação com o quíntuplo da primeira, obtemos:
```math
0x - 3y = 39
```
Logo:
```math
y = -13
```

Substituindo na primeira equação:
```math
x - 2 \cdot (-13) = 9 \implies x = 9 - 26 = -17
```

Assim, a única solução do sistema é $(x, y) = (-17, -13)$.
Portanto, a interseção entre as retas é o ponto $P(-17, -13)$.
Como obtemos uma única solução, dizemos que o sistema é possível e determinado (SPD).

---

### Exercícios Propostos


1. Verifique se $X = \begin{bmatrix} 3 \\ 4 \\ -2 \end{bmatrix}$ é solução do sistema de equações lineares 
```math
\begin{cases}
5x - y + 2z = 7 \\
-2x + 6y + 9z = 0 \\
-7x + 5y - 3z = -7
\end{cases}
```

2. Indique as equações de um sistema linear não-homogêneo, em que $\begin{bmatrix} 5 & -3 \\ -2 & 6 \end{bmatrix}$ é a matriz dos coeficientes e $\begin{bmatrix} 9 \\ -11 \end{bmatrix}$ é uma solução do sistema.

3. Mostre que os sistemas abaixo admitem a mesma solução:
```math
\begin{cases}
6x + 11y = 43 \\
-7x + 3y = 29
\end{cases}
```
```math
\begin{cases}
-x + 14y = 72 \\
4x - 2y = -18
\end{cases}
```
