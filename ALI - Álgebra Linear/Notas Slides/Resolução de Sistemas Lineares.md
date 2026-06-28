# Método da Eliminação de Gauss para classificação e resolução de sistemas de equações lineares



---

### Resolvendo um sistema de equações lineares

Qual sistema é mais fácil de resolver algebricamente?

```math
\begin{cases}
x - 2y + 3z = 9 \\
-x + 3y = -4 \\
2x - 5y + 5z = 17
\end{cases}
```

ou 

```math
\begin{cases}
x - 2y + 3z = 9 \\
y + 3z = 5 \\
z = 2
\end{cases}
```

* O sistema da direita é claramente mais fácil de resolver.
* Esse sistema está na forma escalonada por linhas, o que significa que sua matriz ampliada está escrita em um padrão de "degraus de escada", em que os coeficientes da primeira variável de cada equação são sempre iguais a $1$.
* Note que ambos os sistemas admitem a mesma solução: $x = 1$, $y = -1$ e $z = 2$.
* Tais sistemas são chamados de sistemas equivalentes, pois admitem a mesma solução.
* Para resolver um sistema que não esteja na forma escalonada por linhas, vamos "transformá-lo" em um sistema equivalente que esteja na forma escalonada por linhas, usando as operações elementares com as linhas da sua matriz ampliada.


---

### Operações elementares sobre as linhas

Vamos "escalonar" a matriz ampliada de um sistema qualquer, para transformá-lo em um sistema equivalente cuja matriz ampliada esteja na forma escalonada por linhas. Para isso, vamos utilizar SOMENTE as seguintes operações, sempre sobre as LINHAS da matriz.

**OPERAÇÕES ELEMENTARES SOBRE AS LINHAS:**
* Trocar a posição de duas linhas da matriz. Notação: $L_r \longleftrightarrow L_s$.
* Multiplicar todos os elementos de uma linha da matriz por um escalar diferente de zero. Notação: $L_r \longrightarrow kL_s$, com $k \in \mathbb{R}^*$.
* Somar uma linha da matriz com um múltiplo escalar de outra linha da matriz. Notação: $L_r \longrightarrow L_r + kL_s$.

**TEOREMA (SISTEMAS EQUIVALENTES):**
Se dois sistemas lineares $AX = B$ e $CX = D$ são tais que a matriz ampliada $[C|D]$ é obtida por meio da aplicação de uma quantidade finita de operações elementares sobre as linhas de $[A|B]$, então os dois sistemas possuem as mesmas soluções.


---

### Exemplo: usando operações elementares para resolver um sistema

Sistema linear e Matriz ampliada associada:

```math
\begin{cases}
x - 2y + 3z = 9 \\
-x + 3y = -4 \\
2x - 5y + 5z = 17
\end{cases}
\quad
\begin{bmatrix}
1 & -2 & 3 & \mid & 9 \\
-1 & 3 & 0 & \mid & -4 \\
2 & -5 & 5 & \mid & 17
\end{bmatrix}
```

Some a 1ª eq. à 2ª eq. ($L_2 \longrightarrow L_2 + L_1$):

```math
\begin{cases}
x - 2y + 3z = 9 \\
y + 3z = 5 \\
2x - 5y + 5z = 17
\end{cases}
\quad
\begin{bmatrix}
1 & -2 & 3 & \mid & 9 \\
0 & 1 & 3 & \mid & 5 \\
2 & -5 & 5 & \mid & 17
\end{bmatrix}
```

Some a 1ª eq. multiplicada por $-2$ à 3ª eq. ($L_3 \longrightarrow L_3 - 2L_1$):

```math
\begin{cases}
x - 2y + 3z = 9 \\
y + 3z = 5 \\
-y - z = -1
\end{cases}
\quad
\begin{bmatrix}
1 & -2 & 3 & \mid & 9 \\
0 & 1 & 3 & \mid & 5 \\
0 & -1 & -1 & \mid & -1
\end{bmatrix}
```

Some a 2ª eq. à 3ª eq. ($L_3 \longrightarrow L_3 + L_2$):

```math
\begin{cases}
x - 2y + 3z = 9 \\
y + 3z = 5 \\
2z = 4
\end{cases}
\quad
\begin{bmatrix}
1 & -2 & 3 & \mid & 9 \\
0 & 1 & 3 & \mid & 5 \\
0 & 0 & 2 & \mid & 4
\end{bmatrix}
```

Multiplique a 3ª linha por $\frac{1}{2}$ ($L_3 \longrightarrow \frac{1}{2} L_3$):

```math
\begin{cases}
x - 2y + 3z = 9 \\
y + 3z = 5 \\
z = 2
\end{cases}
\quad
\begin{bmatrix}
1 & -2 & 3 & \mid & 9 \\
0 & 1 & 3 & \mid & 5 \\
0 & 0 & 1 & \mid & 2
\end{bmatrix}
```

Substituindo $z = 2$ na 2ª equação, obtém-se $y = -1$.
Da 1ª equação, obtém-se $x = 1$.

A última matriz está na forma escalonada por linhas. Note que, na última matriz, o primeiro elemento não nulo de cada linha é igual a $1$ e há somente zeros abaixo deles.


---

### Matriz escalonada por linhas

**Matriz escalonada por linhas:** Uma matriz $m \times n$ está escrita na forma escalonada por linhas se e somente se satisfazer as seguintes propriedades:
a) Uma linha inteiramente nula (se existir) ocorre sempre abaixo de todas as linhas não nulas.
b) O primeiro elemento não nulo de uma linha é igual a $1$. Chamamos este elemento de pivô.
c) Para linhas sucessivas (não nulas), o $1$ pivô da linha superior está mais à esquerda do que o $1$ pivô da linha inferior. (Isso significa que a quantidade de zeros que precedem o pivô de um linha superior é sempre menor do que a de uma linha inferior).

Exemplos:

```math
A = \begin{bmatrix}
1 & -2 & 3 & 9 \\
0 & 1 & 4 & 5 \\
0 & 0 & 1 & 2
\end{bmatrix}
```

```math
B = \begin{bmatrix}
0 & 1 & 2 & 3 \\
0 & 0 & 1 & 4 \\
0 & 0 & 0 & 1 \\
0 & 0 & 0 & 0
\end{bmatrix}
```

```math
C = \begin{bmatrix}
1 & 2 & 3 & 5 & 6 \\
0 & 1 & 1 & 1 & 2 \\
0 & 0 & 1 & 3 & 0 \\
0 & 0 & 0 & 1 & 0 \\
0 & 0 & 0 & 0 & 1
\end{bmatrix}
```

Uma matriz na forma escalonada por linhas está na forma escalonada reduzida (forma escada) quando cada coluna que contêm um $1$ pivô tem zeros em todas as posições acima e abaixo de seu $1$ pivô. Exemplos:

```math
A = \begin{bmatrix}
1 & 0 & 0 & 1 \\
0 & 1 & 0 & 2 \\
0 & 0 & 1 & 3
\end{bmatrix}
```

```math
B = \begin{bmatrix}
1 & 0 & -1 & 1 & 2 \\
0 & 1 & 0 & 0 & 0 \\
0 & 0 & 0 & 1 & -5 \\
0 & 0 & 0 & 0 & 0
\end{bmatrix}
```

```math
C = \begin{bmatrix}
1 & 0 & 0 \\
0 & 1 & 0 \\
0 & 0 & 1 \\
0 & 0 & 0
\end{bmatrix}
```

```math
D = \begin{bmatrix}
1 & 0 & 0 & 0 & 1 \\
0 & 1 & 0 & 0 & 2 \\
0 & 0 & 1 & 0 & 3 \\
0 & 0 & 0 & 1 & 5 \\
0 & 0 & 0 & 0 & 0
\end{bmatrix}
```


---

### Método da Eliminação de Gauss

* O Método para reescrever um sistema de equações na forma escalonada por linhas utilizando as operações elementares é chamado de método da eliminação de Gauss, em homenagem ao matemático alemão Carl-Friedrich Gauss (1777-1855).
* Popularmente, este método também é chamado de método do escalonamento.
* **Resumo do método:**
  * Escreva a matriz ampliada do sistema.
  * Utilize as operações elementares com as linhas da matriz ampliada até chegar na matriz escalonada por linhas.
  * Escreva o sistema correspondente e utilize a substituição regressiva para encontrar a solução.

> **Observação:** Para esse algoritmo, a ordem na qual executamos as operações é importante. Iniciamos criando o $1$ pivô na primeira linha. Após, operamos com a coluna desse pivô, de forma a obter os zeros nas posições situadas abaixo do pivô. Depois repete-se o processo com as demais linhas. Somente as operações elementares podem ser utilizadas em todo esse processo.


---

### Exemplo 1: Utilizando o método da eliminação de Gauss

**Exemplo 1)** Utilize o método da eliminação de Gauss para obter a solução dos sistemas abaixo, se possível:

**a)**
```math
\begin{cases}
x + 2y - z + 2t = 1 \\
-x - 2y + 2z - t = 1 \\
2x - z - t = 0
\end{cases}
```

Iniciamos com a matriz ampliada do sistema:

```math
[A|B] = 
\begin{bmatrix}
1 & 2 & -1 & 2 & \mid & 1 \\
-1 & -2 & 2 & -1 & \mid & 1 \\
2 & 0 & -1 & -1 & \mid & 0
\end{bmatrix}
```

Como o pivô da primeira linha da matriz já é igual a $1$, vamos para a próxima etapa.
Vamos zerar todos os elementos situados abaixo dele. Para isso, precisaremos operar com a segunda linha (fazendo $L_2 \longrightarrow L_2 + L_1$) e a terceira linha (fazendo $L_3 \longrightarrow L_3 - 2L_1$):

```math
\begin{bmatrix}
1 & 2 & -1 & 2 & \mid & 1 \\
-1 & -2 & 2 & -1 & \mid & 1 \\
2 & 0 & -1 & -1 & \mid & 0
\end{bmatrix}
\quad
\begin{matrix}
\\
L_2 \longrightarrow L_2 + L_1 \\
L_3 \longrightarrow L_3 - 2L_1
\end{matrix}
\quad \sim \quad
\begin{bmatrix}
1 & 2 & -1 & 2 & \mid & 1 \\
0 & 0 & 1 & 1 & \mid & 2 \\
0 & -4 & 1 & -5 & \mid & -2
\end{bmatrix}
```

Como o número de zeros que precede o pivô da segunda linha é maior do que o da terceira linha, precisamos trocar a posição entre essas linhas, denotado por $L_2 \longleftrightarrow L_3$.


---

### Exemplo 1a: Continuação

```math
\begin{bmatrix}
1 & 2 & -1 & 2 & \mid & 1 \\
0 & 0 & 1 & 1 & \mid & 2 \\
0 & -4 & 1 & -5 & \mid & -2
\end{bmatrix}
\quad L_2 \longleftrightarrow L_3 \quad \sim \quad
\begin{bmatrix}
1 & 2 & -1 & 2 & \mid & 1 \\
0 & -4 & 1 & -5 & \mid & -2 \\
0 & 0 & 1 & 1 & \mid & 2
\end{bmatrix}
```

Agora, devemos fazer com que o pivô da segunda linha seja igual a $1$.
Fazemos isso multiplicando toda a segunda linha por $-\frac{1}{4}$, que denotamos por $L_2 \longrightarrow -\frac{1}{4} L_2$:

```math
\begin{bmatrix}
1 & 2 & -1 & 2 & \mid & 1 \\
0 & -4 & 1 & -5 & \mid & -2 \\
0 & 0 & 1 & 1 & \mid & 2
\end{bmatrix}
\quad L_2 \longrightarrow -\frac{1}{4} L_2 \quad \sim \quad
\begin{bmatrix}
1 & 2 & -1 & 2 & \mid & 1 \\
0 & 1 & -\frac{1}{4} & \frac{5}{4} & \mid & \frac{1}{2} \\
0 & 0 & 1 & 1 & \mid & 2
\end{bmatrix}
```

Veja que a última matriz obtida está na forma escalonada por linhas.
Portanto, tomamos o sistema equivalente associado a essa matriz e o resolvemos "de baixo para cima":

```math
\begin{cases}
x + 2y - z + 2t = 1 \\
y - \frac{1}{4}z + \frac{5}{4}t = \frac{1}{2} \\
z + t = 2
\end{cases}
\implies
\begin{cases}
x = 1 - 2y + z - 2t \\
y = \frac{1}{2} + \frac{1}{4}z - \frac{5}{4}t \\
z = 2 - t
\end{cases}
\implies
\begin{cases}
x = 1 \\
y = 1 - \frac{3}{2}t \\
z = 2 - t
\end{cases}
\quad \text{com } t \in \mathbb{R}.
```


---

### Exemplo 1a: Classificação e Método Alternativo

O último sistema é equivalente ao sistema inicial, ou seja, a solução obtida também é solução do sistema original. Veja que $t$ é uma variável livre e o sistema tem infinitas soluções, sendo classificado como **Sistema Possível e Indeterminado (SPI)**.

Outra forma de resolvermos o sistema consiste em continuar "escalonando" a matriz até transformá-la na forma escada. Para fazer isso, basta zerar os elementos que estão situados acima dos pivôs da segunda e da terceira linha. Fazendo isso:

```math
\begin{bmatrix}
1 & 2 & -1 & 2 & \mid & 1 \\
0 & 1 & -\frac{1}{4} & \frac{5}{4} & \mid & \frac{1}{2} \\
0 & 0 & 1 & 1 & \mid & 2
\end{bmatrix}
\quad
\begin{matrix}
\\
L_1 \longrightarrow L_1 - 2L_2 \\
\end{matrix}
\quad \sim \quad
\begin{bmatrix}
1 & 0 & -\frac{1}{2} & -\frac{1}{2} & \mid & 0 \\
0 & 1 & -\frac{1}{4} & \frac{5}{4} & \mid & \frac{1}{2} \\
0 & 0 & 1 & 1 & \mid & 2
\end{bmatrix}
```

```math
\begin{bmatrix}
1 & 0 & -\frac{1}{2} & -\frac{1}{2} & \mid & 0 \\
0 & 1 & -\frac{1}{4} & \frac{5}{4} & \mid & \frac{1}{2} \\
0 & 0 & 1 & 1 & \mid & 2
\end{bmatrix}
\quad
\begin{matrix}
\\
L_1 \longrightarrow L_1 + \frac{1}{2} L_3 \\
L_2 \longrightarrow L_2 + \frac{1}{4} L_3
\end{matrix}
\quad \sim \quad
\begin{bmatrix}
1 & 0 & 0 & 0 & \mid & 1 \\
0 & 1 & 0 & \frac{3}{2} & \mid & 1 \\
0 & 0 & 1 & 1 & \mid & 2
\end{bmatrix}
```

E então, obtemos o sistema:

```math
\begin{cases}
x = 1 \\
y + \frac{3}{2}t = 1 \\
z + t = 2
\end{cases}
\implies
\begin{cases}
x = 1 \\
y = 1 - \frac{3}{2}t \\
z = 2 - t
\end{cases}
\quad \text{com } t \in \mathbb{R} \text{ variável livre.}
```

Veja que obtivemos a mesma solução anterior.


---

### Exemplo 1b

**b)**
```math
\begin{cases}
x + y + z = 2 \\
2x - y - z = 0 \\
-2x + 2y + 2z = 1
\end{cases}
```

**Solução:** Iniciamos com a matriz ampliada do sistema:

```math
[A|B] = 
\begin{bmatrix}
1 & 1 & 1 & \mid & 2 \\
2 & -1 & -1 & \mid & 0 \\
-2 & 2 & 2 & \mid & 1
\end{bmatrix}
```

Como o pivô da primeira linha da matriz novamente é igual a $1$, vamos para a próxima etapa:
Vamos zerar todos os elementos situados abaixo dele. Para isso, precisaremos operar com a segunda linha (fazendo $L_2 \longrightarrow L_2 - 2L_1$) e a terceira linha (fazendo $L_3 \longrightarrow L_3 + 2L_1$):

```math
\begin{bmatrix}
1 & 1 & 1 & \mid & 2 \\
2 & -1 & -1 & \mid & 0 \\
-2 & 2 & 2 & \mid & 1
\end{bmatrix}
\quad
\begin{matrix}
\\
L_2 \longrightarrow L_2 - 2L_1 \\
L_3 \longrightarrow L_3 + 2L_1
\end{matrix}
\quad \sim \quad
\begin{bmatrix}
1 & 1 & 1 & \mid & 2 \\
0 & -3 & -3 & \mid & -4 \\
0 & 4 & 4 & \mid & 5
\end{bmatrix}
```

Agora, devemos fazer com que o pivô da segunda linha seja igual a $1$. Fazemos isso multiplicando toda a segunda linha por $-\frac{1}{3}$, operação que denotamos por $L_2 \longrightarrow -\frac{1}{3} L_2$.


---

### Exemplo 1b: Continuação

```math
\begin{bmatrix}
1 & 1 & 1 & \mid & 2 \\
0 & -3 & -3 & \mid & -4 \\
0 & 4 & 4 & \mid & 5
\end{bmatrix}
\quad L_2 \longrightarrow -\frac{1}{3} L_2 \quad \sim \quad
\begin{bmatrix}
1 & 1 & 1 & \mid & 2 \\
0 & 1 & 1 & \mid & \frac{4}{3} \\
0 & 4 & 4 & \mid & 5
\end{bmatrix}
```

O próximo passo é anular o elemento situado abaixo do pivô da segunda linha.
Fazemos isso com a operação $L_3 \longrightarrow L_3 - 4L_2$:

```math
\begin{bmatrix}
1 & 1 & 1 & \mid & 2 \\
0 & 1 & 1 & \mid & \frac{4}{3} \\
0 & 4 & 4 & \mid & 5
\end{bmatrix}
\quad L_3 \longrightarrow L_3 - 4L_2 \quad \sim \quad
\begin{bmatrix}
1 & 1 & 1 & \mid & 2 \\
0 & 1 & 1 & \mid & \frac{4}{3} \\
0 & 0 & 0 & \mid & -\frac{1}{3}
\end{bmatrix}
```

A próxima etapa é fazer com que o pivô da terceira linha seja igual a $1$.
Veja que nesse exemplo tal pivô está situado na coluna que diz respeito aos termos independentes do sistema. Fazemos isso com a operação $L_3 \longrightarrow -3 L_3$:

```math
\begin{bmatrix}
1 & 1 & 1 & \mid & 2 \\
0 & 1 & 1 & \mid & \frac{4}{3} \\
0 & 0 & 0 & \mid & -\frac{1}{3}
\end{bmatrix}
\quad L_3 \longrightarrow -3 L_3 \quad \sim \quad
\begin{bmatrix}
1 & 1 & 1 & \mid & 2 \\
0 & 1 & 1 & \mid & \frac{4}{3} \\
0 & 0 & 0 & \mid & 1
\end{bmatrix}
```

Essa última matriz está na forma escalonada por linhas.


---

### Exemplo 1b: Conclusão

Portanto, tomamos o sistema equivalente associado a essa última matriz:

```math
\begin{cases}
x + y + z = 2 \\
y + z = \frac{4}{3} \\
0 = 1
\end{cases}
```

Veja que a última equação desse sistema consiste em uma contradição ($0 = 1$ é um absurdo).
Isso significa que o sistema não admite solução, pois não existem valores de $x, y, z$ que façam com que a última equação seja verdadeira. Nesse caso, dizemos que o sistema é impossível (SI)! Como esse sistema é equivalente ao sistema original, não existe solução para o sistema dado.

> **Observação:** Veja que a contradição acima decorre do fato da última linha da matriz ampliada $[A|B]$ possuir somente elementos iguais a zero na parte que corresponde à matriz dos coeficientes $A$, enquanto o elemento da última linha da matriz que corresponde à matriz dos termos independentes $B$ é diferente de zero:
> 
> ```math
> [A|B] \sim
> \begin{bmatrix}
> 1 & 1 & 1 & \mid & 2 \\
> 0 & 1 & 1 & \mid & \frac{4}{3} \\
> 0 & 0 & 0 & \mid & 1
> \end{bmatrix}
> ```


---

### Exemplo 1c

**c)**
```math
\begin{cases}
3x - 3y + 6z = -15 \\
2x - 4y + 3z = -16 \\
5x + y + 7z = 5
\end{cases}
```

**Solução:** Iniciamos com a matriz ampliada do sistema:

```math
[A|B] = 
\begin{bmatrix}
3 & -3 & 6 & \mid & -15 \\
2 & -4 & 3 & \mid & -16 \\
5 & 1 & 7 & \mid & 5
\end{bmatrix}
```

Aqui, precisamos transformar o pivô da primeira linha em $1$.
Podemos fazer isso com a operação $L_1 \longrightarrow L_1 - L_2$:

```math
\begin{bmatrix}
3 & -3 & 6 & \mid & -15 \\
2 & -4 & 3 & \mid & -16 \\
5 & 1 & 7 & \mid & 5
\end{bmatrix}
\quad L_1 \longrightarrow L_1 - L_2 \quad \sim \quad
\begin{bmatrix}
1 & 1 & 3 & \mid & 1 \\
2 & -4 & 3 & \mid & -16 \\
5 & 1 & 7 & \mid & 5
\end{bmatrix}
```

Para zerar todos os elementos situados abaixo do pivô da primeira linha, precisaremos operar com a segunda linha ($L_2 \longrightarrow L_2 - 2L_1$) e com a terceira linha ($L_3 \longrightarrow L_3 - 5L_1$):

```math
\begin{bmatrix}
1 & 1 & 3 & \mid & 1 \\
2 & -4 & 3 & \mid & -16 \\
5 & 1 & 7 & \mid & 5
\end{bmatrix}
\quad
\begin{matrix}
\\
L_2 \longrightarrow L_2 - 2L_1 \\
L_3 \longrightarrow L_3 - 5L_1
\end{matrix}
\quad \sim \quad
\begin{bmatrix}
1 & 1 & 3 & \mid & 1 \\
0 & -6 & -3 & \mid & -18 \\
0 & -4 & -8 & \mid & 0
\end{bmatrix}
```


---

### Exemplo 1c: Continuação

Agora, vamos transformar o pivô da segunda linha em $1$.
Existem diferentes formas de fazermos isso. Vamos usar a operação $L_2 \longrightarrow -\frac{1}{6} L_2$:

```math
\begin{bmatrix}
1 & 1 & 3 & \mid & 1 \\
0 & -6 & -3 & \mid & -18 \\
0 & -4 & -8 & \mid & 0
\end{bmatrix}
\quad L_2 \longrightarrow -\frac{1}{6} L_2 \quad \sim \quad
\begin{bmatrix}
1 & 1 & 3 & \mid & 1 \\
0 & 1 & \frac{1}{2} & \mid & 3 \\
0 & -4 & -8 & \mid & 0
\end{bmatrix}
```

O próximo passo é zerar o elemento situado abaixo do pivô da segunda linha, com a operação $L_3 \longrightarrow L_3 + 4L_2$:

```math
\begin{bmatrix}
1 & 1 & 3 & \mid & 1 \\
0 & 1 & \frac{1}{2} & \mid & 3 \\
0 & -4 & -8 & \mid & 0
\end{bmatrix}
\quad L_3 \longrightarrow L_3 + 4L_2 \quad \sim \quad
\begin{bmatrix}
1 & 1 & 3 & \mid & 1 \\
0 & 1 & \frac{1}{2} & \mid & 3 \\
0 & 0 & -6 & \mid & 12
\end{bmatrix}
```

A próxima etapa é transformar o pivô da terceira linha em $1$, com a operação $L_3 \longrightarrow -\frac{1}{6} L_3$:

```math
\begin{bmatrix}
1 & 1 & 3 & \mid & 1 \\
0 & 1 & \frac{1}{2} & \mid & 3 \\
0 & 0 & -6 & \mid & 12
\end{bmatrix}
\quad L_3 \longrightarrow -\frac{1}{6} L_3 \quad \sim \quad
\begin{bmatrix}
1 & 1 & 3 & \mid & 1 \\
0 & 1 & \frac{1}{2} & \mid & 3 \\
0 & 0 & 1 & \mid & -2
\end{bmatrix}
```

Essa última matriz está na forma escalonada por linhas.


---

### Exemplo 1c: Conclusão

Portanto, tomamos o sistema equivalente associado a essa última matriz:

```math
\begin{cases}
x + y + 3z = 1 \\
y + \frac{1}{2}z = 3 \\
z = -2
\end{cases}
```

Resolvendo "de baixo para cima" esse sistema, obtemos que $x = 3$, $y = 4$ e $z = -2$.
Portanto, o sistema admite uma única solução e é um sistema possível e determinado (SPD).
O sistema original é equivalente a esse sistema, ou seja, admite a mesma solução.

**Exercícios da lista: até o 12.**


---

### Exercício

Determine se cada matriz abaixo está escrita na forma escalonada por linhas. Caso positivo, determine também se a matriz está na forma escada.

a) 
```math
A = \begin{bmatrix}
1 & 2 & -1 & 4 \\
0 & 1 & 0 & 3 \\
0 & 0 & 1 & -2
\end{bmatrix}
```

b) 
```math
B = \begin{bmatrix}
1 & 2 & -1 & 2 \\
0 & 0 & 0 & 0 \\
0 & 1 & 2 & -4
\end{bmatrix}
```

c) 
```math
C = \begin{bmatrix}
1 & -5 & 2 & -1 & 3 \\
0 & 0 & 1 & 3 & 2 \\
0 & 0 & 0 & 1 & 4 \\
0 & 0 & 0 & 0 & 1
\end{bmatrix}
```

d) 
```math
D = \begin{bmatrix}
1 & 0 & 0 & -1 \\
0 & 1 & 0 & 2 \\
0 & 0 & 1 & 3 \\
0 & 0 & 0 & 0
\end{bmatrix}
```

e) 
```math
E = \begin{bmatrix}
1 & 2 & -1 & 2 \\
0 & 2 & 1 & -1 \\
0 & 0 & 2 & -4
\end{bmatrix}
```

f) 
```math
F = \begin{bmatrix}
0 & 1 & 0 & 2 \\
0 & 0 & 1 & -1 \\
0 & 0 & 0 & 0
\end{bmatrix}
```

