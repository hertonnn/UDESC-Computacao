# Classificação de Sistemas Lineares

### Interpretação geométrica da classificação de sistemas lineares 2x2
Em sistemas de duas equações a duas variáveis em que cada equação representa uma reta no plano:
```math
\begin{cases} 
a_{11}x + a_{12}y = b_1 \\ 
a_{21}x + a_{22}y = b_2 
\end{cases}
```
temos as seguintes possibilidades:
- O sistema é possível e determinado (SPD).
- O sistema é possível e indeterminado (SPI).
- O sistema é impossível (SI).

![Imagem Embutida 3](imagens/Classifica%C3%A7%C3%A3o%20de%20Sistemas%20Lineares/slide_3_img_3.png)
![Imagem Embutida 5](imagens/Classifica%C3%A7%C3%A3o%20de%20Sistemas%20Lineares/slide_3_img_5.png)
![Imagem Embutida 7](imagens/Classifica%C3%A7%C3%A3o%20de%20Sistemas%20Lineares/slide_3_img_7.jpeg)

### Interpretação geométrica da classificação de sistemas lineares 3x3
Em sistemas de três equações a três variáveis, cada equação representa um plano no espaço:
```math
\begin{cases} 
a_{11}x + a_{12}y + a_{13}z = b_1 \\ 
a_{21}x + a_{22}y + a_{23}z = b_2 \\ 
a_{31}x + a_{32}y + a_{33}z = b_3 
\end{cases}
```
Encontrar as soluções para o sistema significa obter a interseção entre os três planos.
Temos diversas possibilidades, dadas pelas posições relativas entre os planos:
- O sistema é possível e determinado (SPD)
- O sistema é possível e indeterminado (SPI)

![Imagem Embutida 3](imagens/Classifica%C3%A7%C3%A3o%20de%20Sistemas%20Lineares/slide_4_img_3.jpeg)
![Imagem Embutida 5](imagens/Classifica%C3%A7%C3%A3o%20de%20Sistemas%20Lineares/slide_4_img_5.jpeg)
![Imagem Embutida 7](imagens/Classifica%C3%A7%C3%A3o%20de%20Sistemas%20Lineares/slide_4_img_7.jpeg)

### Interpretação geométrica da solução de sistemas lineares

O sistema é possível e indeterminado (SPI).
O sistema é impossível (SI).
O sistema é impossível (SI).

![Imagem Embutida 3](imagens/Classifica%C3%A7%C3%A3o%20de%20Sistemas%20Lineares/slide_5_img_3.png)
![Imagem Embutida 5](imagens/Classifica%C3%A7%C3%A3o%20de%20Sistemas%20Lineares/slide_5_img_5.jpeg)
![Imagem Embutida 7](imagens/Classifica%C3%A7%C3%A3o%20de%20Sistemas%20Lineares/slide_5_img_7.jpeg)

O sistema é impossível (SI).
O sistema é impossível (SI).

![Imagem Embutida 3](imagens/Classifica%C3%A7%C3%A3o%20de%20Sistemas%20Lineares/slide_6_img_3.jpeg)
![Imagem Embutida 5](imagens/Classifica%C3%A7%C3%A3o%20de%20Sistemas%20Lineares/slide_6_img_5.jpeg)

### Posto e nulidade de uma matriz

**Definição 1:** Dada uma matriz $A$ de ordem $m \times n$, o posto da matriz $A$ é definido pelo número de linhas não nulas da sua matriz reduzida à forma escalonada por linhas.
**Notação:** $\text{posto}(A)$ ou $P_A$.

**Definição 2:** Dada uma matriz $A$ de ordem $m \times n$, a nulidade da matriz é dada pela diferença entre o número de colunas e o seu posto.
**Notação:** $\text{nulidade}(A) = n - \text{posto}(A) = n - P_A$.

Conforme veremos nos exemplos a seguir, os postos da matriz ampliada $[A|B]$ e da matriz dos coeficientes $A$ de um sistema linear $AX = B$ nos auxiliarão a classificar o sistema como possível ou impossível (SI).

Conforme veremos nos próximos exemplos, a nulidade da matriz dos coeficientes $A$ de um sistema linear $AX = B$ nos auxiliará a classificar um sistema possível como determinado (SPD) ou indeterminado (SPI).

Quando resolvemos um sistema linear por meio do método da Eliminação de Gauss (ou escalonamento da matriz ampliada do sistema), a existência/inexistência de linhas nulas obtidas após o escalonamento pode nos auxiliar a:
- classificar corretamente o sistema quanto ao número de soluções (SPD, SPI ou SI);
- obter uma informação sobre o número de variáveis livres (caso existam).

Vejamos alguns exemplos:

### Exemplo 1
Classifique e obtenha a(s) solução(ões), caso exista(m), para os sistemas lineares:

**a)**
```math
\begin{cases} 
-3x + 9y + z = 5 \\ 
x + 2y - 2z = -7 \\ 
5x - 8y - 4z = 3 
\end{cases}
```

**Solução:** Vamos escalonar a matriz ampliada do sistema, dada por:
```math
[A|B] = 
\begin{bmatrix} 
-3 & 9 & 1 & \mid & 5 \\ 
1 & 2 & -2 & \mid & -7 \\ 
5 & -8 & -4 & \mid & 3 
\end{bmatrix}
```

$L_1 \longleftrightarrow L_2$
```math
\sim 
\begin{bmatrix} 
1 & 2 & -2 & \mid & -7 \\ 
-3 & 9 & 1 & \mid & 5 \\ 
5 & -8 & -4 & \mid & 3 
\end{bmatrix}
```

$L_2 \longrightarrow L_2 + 3L_1$
$L_3 \longrightarrow L_3 - 5L_1$
```math
\sim 
\begin{bmatrix} 
1 & 2 & -2 & \mid & -7 \\ 
0 & 15 & -5 & \mid & -16 \\ 
0 & -18 & 6 & \mid & 38 
\end{bmatrix}
```

$L_2 \longrightarrow \frac{1}{15} L_2$
```math
\sim 
\begin{bmatrix} 
1 & 2 & -2 & \mid & -7 \\ 
0 & 1 & -1/3 & \mid & -16/15 \\ 
0 & -18 & 6 & \mid & 38 
\end{bmatrix}
```

$L_3 \longrightarrow L_3 + 18L_2$
```math
\sim 
\begin{bmatrix} 
1 & 2 & -2 & \mid & -7 \\ 
0 & 1 & -1/3 & \mid & -16/15 \\ 
0 & 0 & 0 & \mid & 94/5 
\end{bmatrix}
```

$L_3 \longrightarrow \frac{5}{94} L_3$
```math
\sim 
\begin{bmatrix} 
1 & 2 & -2 & \mid & -7 \\ 
0 & 1 & -1/3 & \mid & -16/15 \\ 
0 & 0 & 0 & \mid & 1 
\end{bmatrix}
```

Portanto, o sistema dado é equivalente ao sistema obtido por meio da matriz linha reduzida à forma escada:
```math
\begin{cases} 
x + 2y - 2z = -7 \\ 
y - \frac{1}{3}z = -\frac{16}{15} \\ 
0 = 1 
\end{cases}
```

Note que não existe nenhum valor que satisfaça a terceira equação (que é uma contradição).
Portanto, não existe solução para o sistema original.
Ele é um sistema impossível (SI).

**Questão:** Por que isso ocorreu?
Note que, após o escalonamento, a matriz ampliada $[A|B]$ possui três linhas não nulas, enquanto a matriz $A$ tem somente duas linhas não nulas.
Denotaremos: $\text{posto}([A|B]) = 3$ e $\text{posto}(A) = 2$.
Note que, em um sistema impossível (SI), temos que $\text{posto}([A|B]) \neq \text{posto}(A)$.

**b)**
```math
\begin{cases} 
2x + 6y + 4z = 8 \\ 
-5x - 9y + 8z = 4 \\ 
11x + 27y + 4z = 20 \\ 
-7x - 21y - 14z = -28 
\end{cases}
```

**Solução:** Vamos escalonar a matriz ampliada do sistema, dada por:
```math
[A|B] = 
\begin{bmatrix} 
2 & 6 & 4 & \mid & 8 \\ 
-5 & -9 & 8 & \mid & 4 \\ 
11 & 27 & 4 & \mid & 20 \\ 
-7 & -21 & -14 & \mid & -28 
\end{bmatrix}
```

$L_1 \longrightarrow \frac{1}{2} L_1$
```math
\sim 
\begin{bmatrix} 
1 & 3 & 2 & \mid & 4 \\ 
-5 & -9 & 8 & \mid & 4 \\ 
11 & 27 & 4 & \mid & 20 \\ 
-7 & -21 & -14 & \mid & -28 
\end{bmatrix}
```

$L_2 \longrightarrow L_2 + 5L_1$
$L_3 \longrightarrow L_3 - 11L_1$
$L_4 \longrightarrow L_4 + 7L_1$
```math
\sim 
\begin{bmatrix} 
1 & 3 & 2 & \mid & 4 \\ 
0 & 6 & 18 & \mid & 24 \\ 
0 & -6 & -18 & \mid & -24 \\ 
0 & 0 & 0 & \mid & 0 
\end{bmatrix}
```

$L_2 \longrightarrow \frac{1}{6} L_2$
$L_3 \longrightarrow L_3 + L_2$
```math
\sim 
\begin{bmatrix} 
1 & 3 & 2 & \mid & 4 \\ 
0 & 1 & 3 & \mid & 4 \\ 
0 & 0 & 0 & \mid & 0 \\ 
0 & 0 & 0 & \mid & 0 
\end{bmatrix}
```

Portanto, o sistema dado é equivalente ao sistema dado pela última matriz:
```math
\begin{cases} 
x + 3y + 2z = 4 \\ 
y + 3z = 4 \\ 
0 = 0 
\end{cases} \implies 
\begin{cases} 
x = 4 - 3y - 2z \\ 
y = 4 - 3z \\ 
0 = 0 
\end{cases} \implies 
\begin{cases} 
x = 4 - 3(4 - 3z) - 2z \\ 
y = 4 - 3z \\ 
z \in \mathbb{R} 
\end{cases} \implies 
\begin{cases} 
x = -8 + 7z \\ 
y = 4 - 3z \\ 
z \in \mathbb{R} 
\end{cases}
```

Portanto, o sistema é possível e indeterminado (SPI) com uma variável livre ($z$).

**Questão:** Por que isso ocorreu?
Note que obtivemos
```math
[A|B] \sim 
\begin{bmatrix} 
1 & 3 & 2 & \mid & 4 \\ 
0 & 1 & 3 & \mid & 4 \\ 
0 & 0 & 0 & \mid & 0 \\ 
0 & 0 & 0 & \mid & 0 
\end{bmatrix}
```
E que, após o escalonamento, tanto a matriz ampliada $[A|B]$ quanto a matriz dos coeficientes $A$ possuem duas linhas não nulas.
Como o número de linhas não nulas de uma matriz é o posto da matriz, temos que $\text{posto}([A|B]) = 2 = \text{posto}(A)$, que indica que o sistema é possível.
Já a terceira e quarta linhas (totalmente nulas) da matriz escalonada indicam que $0 = 0$, que consiste em uma tautologia (é sempre verdadeira).
Além disso, veja que a diferença entre o número de colunas de $A$ e o posto de $A$ é igual a 1 e temos somente uma variável livre no sistema. (SPI).
Denotaremos $\text{nulidade}(A) = 3 - \text{posto}(A) = 1$.

**c)**
```math
\begin{cases} 
3x + 2y - 4z = 10 \\ 
2x - 5y - 3z = 8 \\ 
-5x + 3y + 6z = -4 
\end{cases}
```

**Solução:** Escalonando a matriz ampliada do sistema, dada por:
```math
[A|B] = 
\begin{bmatrix} 
3 & 2 & -4 & \mid & 10 \\ 
2 & -5 & -3 & \mid & 8 \\ 
-5 & 3 & 6 & \mid & -4 
\end{bmatrix}
```

$L_1 \longrightarrow L_1 - L_2$
```math
\sim 
\begin{bmatrix} 
1 & 7 & -1 & \mid & 2 \\ 
2 & -5 & -3 & \mid & 8 \\ 
-5 & 3 & 6 & \mid & -4 
\end{bmatrix}
```

$L_2 \longrightarrow L_2 - 2L_1$
$L_3 \longrightarrow L_3 + 5L_1$
```math
\sim 
\begin{bmatrix} 
1 & 7 & -1 & \mid & 2 \\ 
0 & -19 & -1 & \mid & 4 \\ 
0 & 38 & 1 & \mid & 6 
\end{bmatrix}
```

$L_2 \longrightarrow -\frac{1}{19} L_2$
```math
\sim 
\begin{bmatrix} 
1 & 7 & -1 & \mid & 2 \\ 
0 & 1 & 1/19 & \mid & -4/19 \\ 
0 & 38 & 1 & \mid & 6 
\end{bmatrix}
```

$L_3 \longrightarrow L_3 - 38L_2$
```math
\sim 
\begin{bmatrix} 
1 & 7 & -1 & \mid & 2 \\ 
0 & 1 & 1/19 & \mid & -4/19 \\ 
0 & 0 & -1 & \mid & 14 \end{bmatrix}
```

$L_3 \longrightarrow -L_3$
```math
\sim 
\begin{bmatrix} 
1 & 7 & -1 & \mid & 2 \\ 
0 & 1 & 1/19 & \mid & -4/19 \\ 
0 & 0 & 1 & \mid & -14 \end{bmatrix}
```

Portanto, o sistema dado é equivalente ao sistema dado pela última matriz:
```math
\begin{cases} 
x + 7y - z = 2 \\ 
y + \frac{1}{19}z = -\frac{4}{19} \\ 
z = -14 
\end{cases}
```

Portanto, o sistema é possível e determinado (SPD).
E sua única solução é:
```math
z = -14
```
```math
y = -\frac{4}{19} - \frac{1}{19}z = -\frac{4}{19} - \frac{1}{19}(-14) = \frac{10}{19}
```
```math
x = 2 - 7y + z = 2 - 7 \left(\frac{10}{19}\right) + (-14) = -\frac{298}{19}
```

```math
x = -\frac{298}{19}, \quad y = \frac{10}{19}, \quad z = -14
```

**Questão:** Por que isso ocorreu?
Note que obtivemos
```math
[A|B] \sim \begin{bmatrix} 1 & 7 & -1 & \mid & 2 \\ 0 & 1 & 1/19 & \mid & -4/19 \\ 0 & 0 & 1 & \mid & -14 \end{bmatrix}
```
Ou seja, após o escalonamento, tanto a matriz ampliada $[A|B]$ quanto a matriz dos coeficientes $A$ possuem três linhas não nulas. Portanto $\text{posto}([A|B]) = 3 = \text{posto}(A)$, que indica que o sistema é possível (SP).
Além disso, a diferença entre o número de colunas de $A$ e o posto de $A$ é igual a 0 e não temos nenhuma variável livre no sistema, ou seja, ele é determinado (SPD).
Note que $\text{nulidade}(A) = 3 - \text{posto}(A) = 3 - 3 = 0$.

### Caracterização das soluções de um sistema linear do tipo AX=B

Considere o sistema linear de $m$ equações e $n$ incógnitas $AX=B$.
O sistema é classificado como:
a. **Impossível (SI):** se não admite solução. Neste caso, $\text{posto}([A|B]) \neq \text{posto}(A)$.
b. **Possível (SP):** se admite solução. Neste caso, $\text{posto}([A|B]) = \text{posto}(A)$ e ainda, é:
- **Determinado (SPD):** quando a solução é única. Neste caso $\text{posto}(A) = n$ e, com isso, $\text{nulidade}(A) = n - \text{posto}(A) = n - n = 0$.
- **Indeterminado (SPI):** quando há infinitas soluções. Neste caso $\text{posto}(A) < n$ e $\text{nulidade}(A) = n - \text{posto}(A) \neq 0$.

**Definição 3:** Considere o sistema linear possível e indeterminado $AX=B$, com $A$ uma matriz de ordem $m \times n$. O grau de liberdade do sistema é definido por
```math
g = \text{nulidade}(A) = n - \text{posto}(A)
```
e corresponde ao número de variáveis livres da solução do sistema.

### Exemplo 2
Considere as matrizes
```math
A = \begin{bmatrix} 1 & -2 & 1 \\ -4 & 8 & -5 \\ 2 & -4 & k \end{bmatrix}, \quad X = \begin{bmatrix} x \\ y \\ z \end{bmatrix} \quad \text{e} \quad B = \begin{bmatrix} 1 \\ k - 1 \\ -4 \end{bmatrix}
```
onde $k \in \mathbb{R}$. Determine, se possível, o(s) valor(es) de $k$ para os quais o sistema $AX = B$ se torna:
i) impossível
ii) possível e indeterminado
iii) possível e determinado

**Solução:** Escalonando a matriz ampliada do sistema:
```math
[A|B] = 
\begin{bmatrix} 
1 & -2 & 1 & \mid & 1 \\ 
-4 & 8 & -5 & \mid & k - 1 \\ 
2 & -4 & k & \mid & -4 
\end{bmatrix}
```

$L_2 \longrightarrow L_2 + 4L_1$
$L_3 \longrightarrow L_3 - 2L_1$
```math
\sim 
\begin{bmatrix} 
1 & -2 & 1 & \mid & 1 \\ 
0 & 0 & -1 & \mid & k + 3 \\ 
0 & 0 & k - 2 & \mid & -6 
\end{bmatrix}
```

$L_2 \longrightarrow -L_2$
$L_3 \longrightarrow L_3 + (k-2)L_2$
```math
\sim 
\begin{bmatrix} 
1 & -2 & 1 & \mid & 1 \\ 
0 & 0 & 1 & \mid & -k - 3 \\ 
0 & 0 & 0 & \mid & -6 + (k-2)(k+3) 
\end{bmatrix}
```
```math
= 
\begin{bmatrix} 
1 & -2 & 1 & \mid & 1 \\ 
0 & 0 & 1 & \mid & -k - 3 \\ 
0 & 0 & 0 & \mid & k^2 + k - 12 
\end{bmatrix}
```

Com o escalonamento finalizado, podemos analisar o posto das matrizes $A$ e $[A|B]$.
Temos que
$\text{posto}(A) = 2$,
pois há somente duas linhas não nulas.
O posto da matriz ampliada depende do termo $k^2 + k - 12$:
```math
\text{posto}([A|B]) = \begin{cases} 3, & \text{se } k^2 + k - 12 \neq 0 \\ 2, & \text{se } k^2 + k - 12 = 0 \end{cases} = \begin{cases} 3, & \text{se } k \neq 3 \text{ e } k \neq -4 \\ 2, & \text{se } k = 3 \text{ ou } k = -4 \end{cases}
```

Assim, temos que:
i) O sistema é impossível (SI) se e somente se $\text{posto}([A|B]) \neq \text{posto}(A)$.
Nesse exemplo, esse caso ocorre se e somente se $\text{posto}([A|B]) = 3$, ou seja, quando $k \neq 3$ e $k \neq -4$.

ii) O sistema é possível e indeterminado (SPI) se e somente se $\text{posto}([A|B]) = \text{posto}(A) = 2$ e $\text{nulidade}(A) = 3 - \text{posto}(A) = 3 - 2 = 1 \neq 0$. Nesse exemplo, esse caso ocorre quando $k = 3$ ou $k = -4$.

iii) O sistema é possível e determinado (SPD) se e somente se $\text{posto}([A|B]) = \text{posto}(A) = 3 = n$ e $\text{nulidade}(A) = 3 - \text{posto}(A) = 3 - 3 = 0$. Como, nesse exemplo, temos $\text{posto}(A) = 2$, não existe $k \in \mathbb{R}$ que satisfaça essa condição.
