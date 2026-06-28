
### Caracterização das soluções de um sistema linear do tipo $AX=B$


Considere o sistema linear de $m$ equações e $n$ incógnitas $AX = B$. O sistema é classificado como:

a. **Impossível (SI)**: se não admite solução. Neste caso, $\text{posto}([A|B]) \neq \text{posto}(A)$.
b. **Possível (SP)**: se admite solução. Neste caso, $\text{posto}([A|B]) = \text{posto}(A)$ e ainda, é:
   - **Determinado (SPD)**: quando a solução é única. Neste caso $\text{posto}(A) = n$ e, com isso, $\text{nulidade}(A) = n - \text{posto}(A) = n - n = 0$.
   - **Indeterminado (SPI)**: quando há infinitas soluções. Neste caso $\text{posto}(A) < n$ e $\text{nulidade}(A) = n - \text{posto}(A) \neq 0$.

### Definição
Considere o sistema linear possível e indeterminado $AX = B$, com $A$ uma matriz de ordem $m \times n$. O grau de liberdade do sistema é definido por:
```math
g = \text{nulidade}(A) = n - \text{posto}(A)
```
e corresponde ao número de variáveis livres da solução do sistema.

### Exemplo 1


Considere as matrizes:
```math
A = \begin{bmatrix} 1 & -2 & 1 \\ -4 & 8 & -5 \\ 2 & -4 & k \end{bmatrix}, \quad X = \begin{bmatrix} x \\ y \\ z \end{bmatrix} \quad \text{e} \quad B = \begin{bmatrix} 1 \\ k-1 \\ -4 \end{bmatrix}
```
onde $k \in \mathbb{R}$. Determine, se possível, o(s) valor(es) de $k$ para os quais o sistema $AX = B$ se torna:
i) impossível
ii) possível e indeterminado
iii) possível e determinado

**Solução:**

Escalonando a matriz ampliada do sistema:
```math
[A|B] = \begin{bmatrix} 1 & -2 & 1 & \mid & 1 \\ -4 & 8 & -5 & \mid & k-1 \\ 2 & -4 & k & \mid & -4 \end{bmatrix}
```
Operações: $L_2 \to L_2 + 4L_1$, $L_3 \to L_3 - 2L_1$

```math
\sim \begin{bmatrix} 1 & -2 & 1 & \mid & 1 \\ 0 & 0 & -1 & \mid & k+3 \\ 0 & 0 & k-2 & \mid & -6 \end{bmatrix}
```
Operações: $L_3 \to L_3 + (k-2)L_2$, $L_2 \to -L_2$

```math
\sim \begin{bmatrix} 1 & -2 & 1 & \mid & 1 \\ 0 & 0 & 1 & \mid & -k-3 \\ 0 & 0 & 0 & \mid & k^2+k-12 \end{bmatrix}
```


Com o escalonamento finalizado, podemos analisar o posto das matrizes $A$ e $[A|B]$.
Temos que $\text{posto}(A) = 2$, pois há somente duas linhas não nulas.
O posto da matriz ampliada depende do termo $k^2 + k - 12$:
```math
\text{posto}([A|B]) = \begin{cases} 3, & \text{se } k^2 + k - 12 \neq 0 \\ 2, & \text{se } k^2 + k - 12 = 0 \end{cases} = \begin{cases} 3, & \text{se } k \neq 3 \text{ e } k \neq -4 \\ 2, & \text{se } k = 3 \text{ ou } k = -4 \end{cases}
```

Assim, temos que:
i) O sistema é **impossível (SI)** se e somente se $\text{posto}([A|B]) \neq \text{posto}(A)$.
Nesse exemplo, esse caso ocorre se e somente se $\text{posto}([A|B]) = 3$, ou seja, quando $k \neq 3$ e $k \neq -4$.

ii) O sistema é **possível e indeterminado (SPI)** se e somente se $\text{posto}([A|B]) = \text{posto}(A) = 2$ e $\text{nulidade}(A) = 3 - \text{posto}(A) = 3 - 2 = 1 \neq 0$. Nesse exemplo, esse caso ocorre quando $k = 3$ ou $k = -4$.

iii) O sistema é **possível e determinado (SPD)** se e somente se $\text{posto}([A|B]) = \text{posto}(A) = 3 = n$ e $\text{nulidade}(A) = 3 - \text{posto}(A) = 3 - 3 = 0$. Como, nesse exemplo, temos $\text{posto}(A) = 2$, não existe $k \in \mathbb{R}$ que satisfaça essa condição.

### Exemplo 2


Determine todos os valores de $a$ de forma que o sistema:
```math
\begin{cases} 3x + 6y - 9z = 12 \\ 7x + 7y - 7z = 18 \\ 4x + y + (a^2 - 14)z = a + 2 \end{cases}
```
i) admita apenas uma solução. Exiba a solução.
ii) admita infinitas soluções. Exiba as soluções.
iii) não admita solução.

**Solução:**

Escalonando a matriz ampliada do sistema:
```math
[A|B] = \begin{bmatrix} 3 & 6 & -9 & \mid & 12 \\ 7 & 7 & -7 & \mid & 18 \\ 4 & 1 & a^2 - 14 & \mid & a + 2 \end{bmatrix}
```
Operação: $L_1 \to \frac{1}{3}L_1$

```math
\sim \begin{bmatrix} 1 & 2 & -3 & \mid & 4 \\ 7 & 7 & -7 & \mid & 18 \\ 4 & 1 & a^2 - 14 & \mid & a + 2 \end{bmatrix}
```
Operações: $L_2 \to L_2 - 7L_1$, $L_3 \to L_3 - 4L_1$

```math
\sim \begin{bmatrix} 1 & 2 & -3 & \mid & 4 \\ 0 & -7 & 14 & \mid & -10 \\ 0 & -7 & a^2 - 2 & \mid & a - 14 \end{bmatrix}
```
Operações: $L_2 \to -\frac{1}{7}L_2$, $L_3 \to L_3 - L_2$

```math
\sim \begin{bmatrix} 1 & 2 & -3 & \mid & 4 \\ 0 & 1 & -2 & \mid & \frac{10}{7} \\ 0 & 0 & a^2 - 16 & \mid & a - 4 \end{bmatrix}
```


Com isso, podemos analisar o posto das matrizes $A$ e $[A|B]$.
Veja que o posto de $A$ depende do termo $a^2 - 16$:
```math
\text{posto}(A) = \begin{cases} 3, & \text{se } a^2 - 16 \neq 0 \\ 2, & \text{se } a^2 - 16 = 0 \end{cases} = \begin{cases} 3, & \text{se } a \neq \pm 4 \\ 2, & \text{se } a = \pm 4 \end{cases}
```

O posto da matriz ampliada depende dos termos $a^2 - 16$ e $a - 4$:
```math
\text{posto}([A|B]) = \begin{cases} 3, & \text{se } a^2 - 16 \neq 0 \\ 3, & \text{se } a^2 - 16 = 0 \text{ e } a - 4 \neq 0 \\ 2, & \text{se } a^2 - 16 = 0 \text{ e } a - 4 = 0 \end{cases} = \begin{cases} 3, & \text{se } a \neq \pm 4 \\ 3, & \text{se } a = -4 \\ 2, & \text{se } a = 4 \end{cases}
```

i) O sistema admite **única solução (é SPD)** quando $\text{posto}([A|B]) = \text{posto}(A) = 3$ e, com isso, $\text{nulidade}(A) = 3 - 3 = 0$. Nesse exemplo, isso ocorre quando $a \neq \pm 4$, pois somente nesse caso temos $\text{posto}(A) = 3$. A solução, nesse caso, é dada por:
```math
\begin{cases} x + 2y - 3z = 4 \\ y - 2z = \frac{10}{7} \\ (a^2-16)z = a-4 \end{cases} \implies \begin{cases} x = 4 - 2y + 3z \\ y = \frac{10}{7} + 2z \\ (a-4)(a+4)z = a-4 \end{cases} \implies \begin{cases} x = \frac{8a+185}{7a+28} \\ y = \frac{10a-26}{7a+28} \\ z = \frac{1}{a+4} \end{cases}
```


ii) O sistema admite **infinitas soluções (é SPI)** quando $\text{posto}([A|B]) = \text{posto}(A) = 2$ e, com isso, $\text{nulidade}(A) = 3 - 2 = 1 \neq 0$. Nesse exemplo, para haver uma variável livre, devemos ter que $a = \pm 4$ (para que $\text{posto}(A) = 2$) e, ao mesmo tempo, $a = 4$ (para que $\text{posto}([A|B]) = 2$). Portanto, tomando a interseção entre os valores, obtemos que $a = 4$.
As soluções, nesse caso, são dadas por:
```math
\begin{cases} x + 2y - 3z = 4 \\ y - 2z = \frac{10}{7} \\ 0 = 0 \end{cases} \implies \begin{cases} x = 4 - 2y + 3z \\ y = \frac{10}{7} + 2z \end{cases} \implies \begin{cases} x = \frac{8}{7} - z \\ y = \frac{10}{7} + 2z \end{cases}, \quad \text{com } z \in \mathbb{R}
```

iii) O sistema não admite soluções (é **SI**) quando $\text{posto}([A|B]) \neq \text{posto}(A)$.
Esse caso ocorre quando $\text{posto}(A) = 2$ e $\text{posto}([A|B]) = 3$.
Para isso ocorrer, devemos ter que $a = \pm 4$ e, ao mesmo tempo, que $a \neq \pm 4$ ou $a = -4$ (casos em que $\text{posto}([A|B]) = 3$). Fazendo a interseção entre os valores, obtemos que $a = -4$.

### Sistemas Homogêneos


Em um sistema homogêneo, os termos independentes são todos obrigatoriamente nulos. Portanto, é um sistema da forma:
```math
\begin{cases} a_{11}x_1 + a_{12}x_2 + a_{13}x_3 + \cdots + a_{1n}x_n = 0 \\ a_{21}x_1 + a_{22}x_2 + a_{23}x_3 + \cdots + a_{2n}x_n = 0 \\ \vdots \\ a_{m1}x_1 + a_{m2}x_2 + a_{m3}x_3 + \cdots + a_{mn}x_n = 0 \end{cases}
```

Em sistemas homogêneos, a matriz dos termos independentes é $B = O$, ou seja, é a matriz nula de ordem $m \times 1$.

A matriz ampliada de um sistema homogêneo é tal que:
```math
[A|O] = \begin{bmatrix} a_{11} & a_{12} & a_{13} & \cdots & a_{1n} & \mid & 0 \\ a_{21} & a_{22} & a_{23} & \cdots & a_{2n} & \mid & 0 \\ \vdots & \vdots & \vdots & \ddots & \vdots & \mid & \vdots \\ a_{m1} & a_{m2} & a_{m3} & \cdots & a_{mn} & \mid & 0 \end{bmatrix}
```

Como $\text{posto}([A|O]) = \text{posto}(A)$, temos que um sistema homogêneo sempre é possível (SP), podendo ser determinado (SPD) ou indeterminado (SPI).
Note que um sistema homogêneo qualquer sempre admite pelo menos a solução:
```math
x_1 = 0, \quad x_2 = 0, \quad x_3 = 0, \quad \dots, \quad x_n = 0
```
Essa solução é denominada **solução trivial** ou **solução nula**; quaisquer outras soluções, se existirem, são ditas não triviais ou **soluções próprias**.


### Sistemas Homogêneos de equações lineares: $AX = O$
Ainda, se $\text{posto}([A|O]) = \text{posto}(A) = n$, onde $n$ é o número de variáveis do sistema homogêneo (e também o número de colunas da matriz $A$), então o sistema homogêneo é possível e determinado (SPD), pois
```math
\text{nulidade}(A) = n - \text{posto}(A) = n - n = 0
```
e não existem variáveis livres. Nesse caso, a solução trivial é a sua única solução.

Se $\text{posto}([A|O]) = \text{posto}(A) \neq n$, o sistema homogêneo é possível e indeterminado (SPI), pois
```math
\text{nulidade}(A) = n - \text{posto}(A) \neq 0
```
e, por isso, existem variáveis livres. Nesse caso, existem soluções não triviais.

### Exemplo 3
Determine as soluções, se existirem, dos sistemas homogêneos dados:

a) $\begin{cases} 3x - y - 7z = 0 \\ -5x + 4y - 9z = 0 \\ x - 2y + 3z = 0 \end{cases}$

**Solução:**

Escalonando a matriz ampliada do sistema homogêneo, obtemos:
```math
[A|O] = \begin{bmatrix} 3 & -1 & -7 & \mid & 0 \\ -5 & 4 & -9 & \mid & 0 \\ 1 & -2 & 3 & \mid & 0 \end{bmatrix}
```
Operação: $L_1 \leftrightarrow L_3$

```math
\sim \begin{bmatrix} 1 & -2 & 3 & \mid & 0 \\ -5 & 4 & -9 & \mid & 0 \\ 3 & -1 & -7 & \mid & 0 \end{bmatrix}
```
Operações: $L_2 \to L_2 + 5L_1$, $L_3 \to L_3 - 3L_1$

```math
\sim \begin{bmatrix} 1 & -2 & 3 & \mid & 0 \\ 0 & -6 & 6 & \mid & 0 \\ 0 & 5 & -16 & \mid & 0 \end{bmatrix}
```


Operação: $L_2 \to -\frac{1}{6}L_2$

```math
\sim \begin{bmatrix} 1 & -2 & 3 & \mid & 0 \\ 0 & 1 & -1 & \mid & 0 \\ 0 & 5 & -16 & \mid & 0 \end{bmatrix}
```
Operação: $L_3 \to L_3 - 5L_2$

```math
\sim \begin{bmatrix} 1 & -2 & 3 & \mid & 0 \\ 0 & 1 & -1 & \mid & 0 \\ 0 & 0 & -11 & \mid & 0 \end{bmatrix}
```

Com isso, temos que $\text{posto}([A|O]) = \text{posto}(A) = 3 = n$ e o sistema é SPD. Portanto, sua única solução é a trivial, dada por $x = 0, y = 0, z = 0$.

b) $\begin{cases} 2x + y - z = 0 \\ x - 2y - 8z = 0 \\ -4x - 7y - 13z = 0 \\ 6x + 8y + 12z = 0 \end{cases}$

**Solução:**

Escalonando a matriz ampliada do sistema:
```math
[A|O] = \begin{bmatrix} 2 & 1 & -1 & \mid & 0 \\ 1 & -2 & -8 & \mid & 0 \\ -4 & -7 & -13 & \mid & 0 \\ 6 & 8 & 12 & \mid & 0 \end{bmatrix}
```
Operação: $L_1 \leftrightarrow L_2$

```math
\sim \begin{bmatrix} 1 & -2 & -8 & \mid & 0 \\ 2 & 1 & -1 & \mid & 0 \\ -4 & -7 & -13 & \mid & 0 \\ 6 & 8 & 12 & \mid & 0 \end{bmatrix}
```
Operações: $L_2 \to L_2 - 2L_1$, $L_3 \to L_3 + 4L_1$, $L_4 \to L_4 - 6L_1$

```math
\sim \begin{bmatrix} 1 & -2 & -8 & \mid & 0 \\ 0 & 5 & 15 & \mid & 0 \\ 0 & -15 & -45 & \mid & 0 \\ 0 & 20 & 60 & \mid & 0 \end{bmatrix}
```


Operações: $L_2 \to \frac{1}{5}L_2$, $L_3 \to L_3 + 3L_2$, $L_4 \to L_4 - 4L_2$

```math
\sim \begin{bmatrix} 1 & -2 & -8 & \mid & 0 \\ 0 & 1 & 3 & \mid & 0 \\ 0 & 0 & 0 & \mid & 0 \\ 0 & 0 & 0 & \mid & 0 \end{bmatrix}
```

Com isso, temos que $\text{posto}([A|O]) = \text{posto}(A) = 2 < 3 = n$ e o sistema é SPI, com uma variável livre, pois $\text{nulidade}(A) = 3 - \text{posto}(A) = 3 - 2 = 1$.
Além disso, suas infinitas soluções são tais que:
```math
\begin{cases} x - 2y - 8z = 0 \\ y + 3z = 0 \\ 0 = 0 \end{cases} \implies \begin{cases} x = 2y + 8z \\ y = -3z \\ z \in \mathbb{R} \end{cases} \implies \begin{cases} x = 2z \\ y = -3z \\ z \in \mathbb{R} \end{cases}
```

**Observação:** Note que, em ambos os exemplos, a matriz nula dos termos independentes não interferiu no posto da matriz ampliada. Por isso, em um sistema homogêneo, é possível omitir a última coluna (inteiramente nula) ao efetuar o escalonamento.


Além disso, escrevendo no formato matricial as infinitas soluções desse sistema homogêneo, temos que:
```math
X = \begin{bmatrix} x \\ y \\ z \end{bmatrix} = \begin{bmatrix} 2z \\ -3z \\ z \end{bmatrix} = z \begin{bmatrix} 2 \\ -3 \\ 1 \end{bmatrix}
```
em que $z \in \mathbb{R}$ e onde
```math
X_0 = \begin{bmatrix} 2 \\ -3 \\ 1 \end{bmatrix}
```
é uma solução particular do sistema homogêneo dado.
Dizemos que $X_0 = \begin{bmatrix} 2 \\ -3 \\ 1 \end{bmatrix}$ é a **solução fundamental** do sistema homogêneo, pois essa solução "gera" todas as demais soluções, a partir de uma simples multiplicação pelo valor atribuído à variável livre $z$. Por exemplo, atribuindo $z = -5$, obtemos a solução:
```math
X = -5 \begin{bmatrix} 2 \\ -3 \\ 1 \end{bmatrix} = \begin{bmatrix} -10 \\ 15 \\ -5 \end{bmatrix}
```

### Exemplo Teórico 1


**Exemplo:** Dado um sistema homogêneo $AX = O$, que admita soluções diferente da trivial, mostre que se $X_1$ e $X_2$ são duas de suas soluções, então qualquer combinação destas soluções, dada por $aX_1 + bX_2$, com $a, b \in \mathbb{R}$, também é solução do sistema homogêneo.

**Solução:**

Se $X_1$ e $X_2$ são soluções do sistema homogêneo $AX = O$, então pela definição de solução, temos que são satisfeitas as igualdades matriciais:
```math
AX_1 = O \quad \text{e} \quad AX_2 = O
```
Assim, usando propriedades das operações com matrizes, obtemos que, para quaisquer $a, b \in \mathbb{R}$, é válido que:
```math
A(aX_1 + bX_2) = A(aX_1) + A(bX_2) = a(AX_1) + b(AX_2) = a(O) + b(O) = O + O = O
```
Como obtemos que $A(aX_1 + bX_2) = O$, essa igualdade significa que $aX_1 + bX_2$ também é uma solução do sistema homogêneo $AX = O$.

### Exemplo Teórico 2


**Exemplo:** Suponha que $X_1$ e $X_2$ sejam duas soluções de um sistema não homogêneo $AX = B$, em que $B \neq O$. Mostre que:
a) $X_1 + X_2$ não é solução do sistema $AX = B$.
b) $X_1 - X_2$ é solução do sistema homogêneo $AX = O$.

**Solução:**

Se $X_1$ e $X_2$ são soluções do sistema não homogêneo $AX = B$, então pela definição de solução, temos que são satisfeitas as igualdades matriciais:
```math
AX_1 = B \quad \text{e} \quad AX_2 = B
```
Assim, usando propriedades das operações com matrizes, obtemos que:

a) $X_1 + X_2$ é tal que:
```math
A(X_1 + X_2) = AX_1 + AX_2 = B + B = 2B \neq B
```
pois $B \neq O$. Assim, $X_1 + X_2$ não é solução do sistema $AX = B$.

b) $X_1 - X_2$ é tal que:
```math
A(X_1 - X_2) = AX_1 - AX_2 = B - B = O
```
Assim, $X_1 - X_2$ é solução do sistema homogêneo $AX = O$.

### Exemplo Teórico 3


**Exemplo:** Seja $A_{8 \times 11}$ uma matriz não nula. Analise as possibilidades para a solução do sistema homogêneo formado por oito equações e onze variáveis associado à matriz $A$, dado por $AX = O$.

**Solução:**

Como $A$ tem 8 linhas e pelo menos uma delas é não nula, obtemos que:
```math
1 \leq \text{posto}(A) \leq 8
```
Como $A$ tem 11 colunas, temos que:
```math
\text{nulidade}(A) = 11 - \text{posto}(A)
```
Dessa forma, obtemos que:
```math
10 \geq \text{nulidade}(A) \geq 3
```
Portanto, o sistema homogêneo associado à matriz $A$ tem, obrigatoriamente, pelo menos três variáveis e, no máximo, 10 variáveis livres.
Em particular, como $\text{nulidade}(A) \neq 0$, o sistema homogêneo jamais será possível e determinado (SPD).

### Exemplo Teórico 4


**Exemplo:** Seja $A_{8 \times 7}$ uma matriz não nula. Analise as possibilidades para a solução do sistema homogêneo formado por oito equações e sete variáveis associado à matriz $A$, dado por $AX = O$.

**Solução:**

Como $A$ tem 8 linhas e 7 colunas, existirão, no máximo, sete pivôs em sua matriz escalonada. Todos os elementos da oitava linha estarão, obrigatoriamente, situados na coluna de um pivô e, por isso, serão anulados no processo de escalonamento. Dessa forma, o posto de $A$ é no máximo igual a 7. Como $A$ é não nula, temos que:
```math
1 \leq \text{posto}(A) \leq 7
```
Como $A$ tem 7 colunas, temos que:
```math
\text{nulidade}(A) = 7 - \text{posto}(A)
```
Dessa forma, obtemos que:
```math
6 \geq \text{nulidade}(A) \geq 0
```
Portanto, o sistema homogêneo associado à matriz $A$ tem no máximo, 6 variáveis livres.
Em particular, como pode ocorrer o caso em que $\text{nulidade}(A) = 0$, o sistema homogêneo pode ser possível e determinado (SPD). Isso ocorre justamente quando $\text{posto}(A) = 7$.

### Exercícios
**Exercícios da Lista:** fazer até o 35.
