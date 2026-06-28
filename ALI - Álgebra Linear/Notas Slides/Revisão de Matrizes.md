# Álgebra Linear: Revisão sobre Matrizes

### Definição

Intuitivamente, uma matriz é uma "tabela" composta por números reais dispostos em linhas e colunas.
Em geral, denotamos matrizes por letras maiúsculas do alfabeto latino.

### Exemplo 1:
a) $A = \begin{bmatrix} 8 & 1 & 2 & -4 & 9 \\ 5 & 7 & 0 & 6 & -3 \end{bmatrix}$ é uma matriz de duas linhas e cinco colunas.
b) $B = \begin{bmatrix} 1 & -2 & 4 & 3 \\ \ln 5 & 5 & \pi & -1 \\ e & 0 & 2 & 7 \end{bmatrix}$ é uma matriz de três linhas e quatro colunas.
c) $C = \begin{bmatrix} -1 & 2 \\ 3 & -4 \\ -5 & 6 \end{bmatrix}$ é uma matriz de três linhas e duas colunas.
d) $D = \begin{bmatrix} 1 & -2 & 3 \end{bmatrix}$ é uma matriz de uma linha e três colunas.
e) $E = \begin{bmatrix} -7 \end{bmatrix}$ é uma matriz de uma linha e uma coluna.

### Notação

Uma matriz $A$ de $m$ linhas e $n$ colunas pode ser representada por
```math
A_{m \times n} = \begin{bmatrix} a_{11} & a_{12} & a_{13} & \dots & a_{1n} \\ a_{21} & a_{22} & a_{23} & \dots & a_{2n} \\ a_{31} & a_{32} & a_{33} & \dots & a_{3n} \\ \vdots & \vdots & \vdots & \ddots & \vdots \\ a_{m1} & a_{m2} & a_{m3} & \dots & a_{mn} \end{bmatrix}
```
em que $a_{ij} \in \mathbb{R}$ simboliza o elemento (ou entrada) da matriz que está situado na $i$-ésima linha e na $j$-ésima coluna, para $i \in \{1, 2, 3, \dots, m\}$ e $j \in \{1, 2, 3, \dots, n\}$.

### Ordem de uma matriz

A ordem de uma matriz corresponde ao número de linhas e de colunas da matriz, e fornece uma ideia sobre o seu "tamanho".
Dessa forma, se uma matriz $A$ possui $m$ linhas e $n$ colunas, dizemos que a ordem de $A$ é igual a $m \times n$ (lido como $m$ por $n$).

**Notação:**
$A_{m \times n} = [a_{ij}]_{m \times n}$.

### Exemplo 2:
Para as matrizes do Exemplo 1, temos as seguintes ordens:
a) $A_{2 \times 5} = \begin{bmatrix} 8 & 1 & 2 & -4 & 9 \\ 5 & 7 & 0 & 6 & -3 \end{bmatrix}$.
b) $B_{3 \times 4} = \begin{bmatrix} 1 & -2 & 4 & 3 \\ \ln 5 & 5 & \pi & -1 \\ e & 0 & 2 & 7 \end{bmatrix}$.
c) $C_{3 \times 2} = \begin{bmatrix} -1 & 2 \\ 3 & -4 \\ -5 & 6 \end{bmatrix}$.
d) $D_{1 \times 3} = \begin{bmatrix} 1 & -2 & 3 \end{bmatrix}$.
e) $E_{1 \times 1} = \begin{bmatrix} -7 \end{bmatrix}$.

### Exemplo 3:
Determine a matriz $A_{5 \times 3} = [a_{ij}]$ tal que
```math
a_{ij} = \begin{cases} i + j, & \text{se } i < j \\ 2i - 3j, & \text{se } i = j \\ i \cdot j + 1, & \text{se } i > j \end{cases}
```

**Solução:**
Vamos obter os elementos da matriz $A$, que possui cinco linhas e três colunas.
Usando a definição dos elementos $a_{ij}$, de acordo com a relação entre $i$ e $j$, obtemos:

$a_{11} = 2 \cdot 1 - 3 \cdot 1 = -1$
$a_{21} = 2 \cdot 1 + 1 = 3$
$a_{31} = 3 \cdot 1 + 1 = 4$
$a_{41} = 4 \cdot 1 + 1 = 5$
$a_{51} = 5 \cdot 1 + 1 = 6$

$a_{12} = 1 + 2 = 3$
$a_{22} = 2 \cdot 2 - 3 \cdot 2 = -2$
$a_{32} = 3 \cdot 2 + 1 = 7$
$a_{42} = 4 \cdot 2 + 1 = 9$
$a_{52} = 5 \cdot 2 + 1 = 11$

$a_{13} = 1 + 3 = 4$
$a_{23} = 2 + 3 = 5$
$a_{33} = 2 \cdot 3 - 3 \cdot 3 = -3$
$a_{43} = 4 \cdot 3 + 1 = 13$
$a_{53} = 5 \cdot 3 + 1 = 16$.

Portanto, a matriz desejada é
```math
A = \begin{bmatrix} -1 & 3 & 4 \\ 3 & -2 & 5 \\ 4 & 7 & -3 \\ 5 & 9 & 13 \\ 6 & 11 & 16 \end{bmatrix}
```

### Aplicação de Matrizes: Definição de imagem digital

Uma imagem digital pode ser interpretada como uma matriz, cujas linhas e colunas representam um ponto específico da imagem. Os elementos dessa matriz são conhecidos como pixels.
O processamento de uma imagem digital passa por algumas etapas. Inicia pelo processo chamado de aquisição, que converte a imagem para uma representação numérica, passa por mais algumas etapas e, ao término, ocorre a exibição, cujos principais dispositivos de saída são monitores/telas.
A representação numérica feita na etapa de aquisição é organizada em uma matriz. Os elementos dessa matriz determinam informações como cor e resolução da imagem.
Uma imagem binária ou booleana é uma imagem digital monocromática, cujos elementos da matriz correspondente são iguais a 0 ou 1, que especificam a cor de cada pixel. As cores mais comuns nesse tipo de imagens são branco e preto. O número 0 indica a cor preta e o número 1, a cor branca.
A figura da página a seguir apresenta uma imagem do personagem Gato Félix, onde cada quadrado representa um pixel e, ao lado, é apresentada sua matriz de aquisição correspondente, de ordem $35 \times 35$.

![Imagem Embutida 2](imagens/Revis%C3%A3o%20de%20Matrizes/slide_7_img_2.png)
![Imagem Embutida 3](imagens/Revis%C3%A3o%20de%20Matrizes/slide_7_img_3.jpeg)

### Aplicação de Matrizes: Resolução de imagem digital

Quanto maior for a ordem da matriz que representa a imagem digital, melhor será a sua resolução.
Se considerarmos quatro imagens digitais do mesmo objeto, com as mesmas dimensões, mudando apenas a quantidade de pixels (ou seja, a ordem da matriz de aquisição da imagem) de cada uma, obteremos resoluções completamente diferentes, conforme ilustrado abaixo:

![Imagem Embutida 3](imagens/Revis%C3%A3o%20de%20Matrizes/slide_8_img_3.jpeg)

Portanto, a resolução espacial de uma imagem é determinada pelo número de pixels por área da imagem, ou seja, pela quantidade de elementos na matriz que representa tal imagem.
Quanto mais pixels uma imagem tiver (ou seja, quanto maior for a ordem da matriz), maior é a sua resolução e melhor a sua qualidade.
A resolução espacial de uma imagem influi na qualidade da percepção que se tem da mesma. A figura abaixo apresenta uma imagem em diversas resoluções:

![Imagem Embutida 3](imagens/Revis%C3%A3o%20de%20Matrizes/slide_9_img_3.jpeg)

### Imagens digitais coloridas

A maioria das cores visíveis pelo olho humano pode ser representada como uma combinação de três cores primárias:
vermelho (R)
verde (G)
azul (B).
Uma imagem digital colorida pode ser entendida como uma imagem em que cada pixel é uma combinação de imagens monocromáticas (chamadas de bandas) das cores R, G e B.

![Imagem Embutida 3](imagens/Revis%C3%A3o%20de%20Matrizes/slide_10_img_3.jpeg)

### Mapa de cores de imagens digitais

Em uma imagem colorida (chamada de imagem multibanda), cada pixel tem associado valores para R, G e B, que determinam, respectivamente, o "tom" utilizado para cada uma das cores (bandas) primárias.
Uma imagem colorida também pode ser armazenada usando uma imagem monocromática e um mapa de cores. Um mapa de cores é um conjunto de matrizes (uma matriz para cada cor/banda), cujos elementos correspondem aos respectivos valores das componentes R, G e B referentes à cor de cada pixel:

![Imagem Embutida 3](imagens/Revis%C3%A3o%20de%20Matrizes/slide_11_img_3.jpeg)
![Imagem Embutida 5](imagens/Revis%C3%A3o%20de%20Matrizes/slide_11_img_5.jpeg)

### Tipos Especiais de Matrizes

Uma matriz $A_{m \times n}$ pode ser classificada de acordo com as características de sua ordem e/ou de seus elementos.

**Matriz Linha:** É qualquer matriz que possua uma única linha ($m = 1$).
**Notações:** 
$A_{1 \times n} = [a_{ij}]_{1 \times n} = \begin{bmatrix} a_{11} & a_{12} & a_{13} & \dots & a_{1n} \end{bmatrix}$.
**Exemplos:** 
$A_{1 \times 3} = \begin{bmatrix} 3 & 2 & -1 \end{bmatrix}$, $B_{1 \times 3} = \begin{bmatrix} 1 & 2 & 3 \end{bmatrix}$, $C_{1 \times 1} = \begin{bmatrix} -7 \end{bmatrix}$.

**Matriz Coluna:** É qualquer matriz que possua uma única coluna ($n = 1$).
**Notações:** 
```math
A_{m \times 1} = [a_{ij}]_{m \times 1} = \begin{bmatrix} a_{11} \\ a_{21} \\ a_{31} \\ \vdots \\ a_{m1} \end{bmatrix}
```
**Exemplos:** 
$A_{3 \times 1} = \begin{bmatrix} -1 \\ 2 \\ -3 \end{bmatrix}$, $B_{2 \times 1} = \begin{bmatrix} 4 \\ -9 \end{bmatrix}$, $C_{1 \times 1} = \begin{bmatrix} -\pi \end{bmatrix}$.

**Matriz Nula:** É qualquer matriz cujos elementos são todos iguais a zero $a_{ij} = 0, \forall i, \forall j$.
**Notação:** Uma matriz nula é denotada por:
$O = [0]_{m \times n}$.
**Exemplos:** 
$O = \begin{bmatrix} 0 & 0 & 0 \\ 0 & 0 & 0 \end{bmatrix}_{2 \times 3}$, 
$O = \begin{bmatrix} 0 & 0 \\ 0 & 0 \\ 0 & 0 \\ 0 & 0 \end{bmatrix}_{4 \times 2}$, 
$O = \begin{bmatrix} 0 \\ 0 \\ 0 \\ 0 \\ 0 \end{bmatrix}_{5 \times 1}$, 
$O = \begin{bmatrix} 0 \end{bmatrix}_{1 \times 1}$.

**Matriz Retangular:** É qualquer matriz cujo número de linhas é diferente do número de colunas, ou seja, em que $m \neq n$.
**Exemplos:** 
$A_{3 \times 2} = \begin{bmatrix} 1 & 2 \\ 3 & 4 \\ 5 & 6 \end{bmatrix}$, 
$B_{2 \times 5} = \begin{bmatrix} 8 & 1 & 2 & -4 & 9 \\ 5 & 7 & 0 & 6 & -3 \end{bmatrix}$, 
$C_{4 \times 1} = \begin{bmatrix} 0 \\ 1 \\ 0 \\ -1 \end{bmatrix}$.

**Matriz Quadrada:** É qualquer matriz cujo número de linhas é igual ao número de colunas, ou seja, em que $m = n$.
**Notação:** 
$A_{n \times n} = [a_{ij}]_{n \times n}$.
**Exemplos:** 
$A_{2 \times 2} = \begin{bmatrix} 1 & -2 \\ -3 & 4 \end{bmatrix}$, 
$B_{3 \times 3} = \begin{bmatrix} 9 & 0 & 7 \\ 5 & 3 & -1 \\ -4 & -2 & 8 \end{bmatrix}$, 
$C_{1 \times 1} = \begin{bmatrix} -7 \end{bmatrix}$.

**Observações:** 
- No caso de matrizes quadradas, costumamos denotar $A_{n \times n} = A_n$ e dizer que $A_n$ é uma matriz de ordem $n$.
- Em uma matriz quadrada destacamos os elementos pertencentes às suas diagonais:
A diagonal principal é formada pelos elementos $a_{ij}$ tais que $i = j$.
A diagonal secundária é formada pelos elementos $a_{ij}$ tais que $i + j = n + 1$.


**Matriz Diagonal:** É uma matriz quadrada ($m = n$) em que $a_{ij} = 0$ sempre que $i \neq j$, ou seja, todos os elementos que não estão na diagonal principal são sempre nulos.
**Exemplos:** 
$A_{2 \times 2} = \begin{bmatrix} -1 & 0 \\ 0 & 4 \end{bmatrix}$, 
$B_{3 \times 3} = \begin{bmatrix} 9 & 0 & 0 \\ 0 & 3 & 0 \\ 0 & 0 & -6 \end{bmatrix}$, 
$I_{3 \times 3} = \begin{bmatrix} 1 & 0 & 0 \\ 0 & 1 & 0 \\ 0 & 0 & 1 \end{bmatrix}$, 
$C_{2 \times 2} = \begin{bmatrix} 0 & 0 \\ 0 & 1 \end{bmatrix}$.
**Observação:** Em uma matriz diagonal é possível que algum (ou inclusive todos) elemento situado sobre a diagonal principal seja igual a zero.

**Matriz Identidade:** É uma matriz diagonal, cujos elementos da diagonal principal são todos iguais a 1, isto é, $a_{ij} = 0$ sempre que $i \neq j$ e $a_{ij} = 1$ sempre que $i = j$. É denotada por $I$.

**Matriz Triangular Superior:** É uma matriz quadrada ($m = n$) em que todos os elementos situados abaixo da diagonal principal são todos nulos, ou seja, $a_{ij} = 0$ sempre que $i > j$.
**Exemplos:** 
$A_{2 \times 2} = \begin{bmatrix} 1 & -2 \\ 0 & 4 \end{bmatrix}$, 
$B_{3 \times 3} = \begin{bmatrix} 9 & -1 & 4 \\ 0 & 3 & -5 \\ 0 & 0 & 8 \end{bmatrix}$, 
$C_{3 \times 3} = \begin{bmatrix} 1 & 0 & 3 \\ 0 & 2 & -7 \\ 0 & 0 & 0 \end{bmatrix}$.
**Observação:** Em uma matriz triangular superior é possível que algum (ou inclusive todos) elemento situado sobre ou acima da diagonal principal seja igual a zero.

**Matriz Triangular Inferior:** É uma matriz quadrada ($m = n$) em que todos os elementos situados acima da diagonal principal são todos nulos, ou seja, $a_{ij} = 0$ sempre que $i < j$.
**Exemplos:** 
$A_{2 \times 2} = \begin{bmatrix} 2 & 0 \\ -3 & 4 \end{bmatrix}$, 
$B_{3 \times 3} = \begin{bmatrix} 1 & 0 & 0 \\ -4 & 2 & 0 \\ -5 & -6 & 3 \end{bmatrix}$, 
$C_{3 \times 3} = \begin{bmatrix} 1 & 0 & 0 \\ 0 & 0 & 0 \\ -2 & 0 & 7 \end{bmatrix}$.
**Observação:** Em uma matriz triangular inferior é possível que algum (ou inclusive todos) elemento situado sobre ou abaixo da diagonal principal seja igual a zero.

### Igualdade entre Matrizes

**Definição:** Duas matrizes $A = [a_{ij}]_{m \times n}$ e $B = [b_{ij}]_{r \times s}$ são iguais se e somente se possuírem o mesmo número de linhas e de colunas e se todos os seus elementos correspondentes forem respectivamente iguais.
**Notação:**
$A = B \Leftrightarrow [a_{ij}]_{m \times n} = [b_{ij}]_{r \times s} \Leftrightarrow m = r$, $n = s$ e $a_{ij} = b_{ij} \ \forall i, j$.

**Exemplo:** As seguintes matrizes são iguais:
```math
\begin{bmatrix} 3^2 & \ln(1) & 5^{-1} & \cos \pi \\ -1 & 16^{1/2} & (-2)^3 & 0,2 \end{bmatrix} = \begin{bmatrix} 9 & 0 & 1/5 & -1 \\ -1 & 4 & -8 & 1/5 \end{bmatrix}
```

**Exemplo:** Determine os valores de $x, y, z$ para os quais as matrizes abaixo sejam iguais:
```math
A = \begin{bmatrix} 2x & 1 \\ -12 & z^2 \end{bmatrix} \quad \text{e} \quad B = \begin{bmatrix} 18 & z+6 \\ 3y & 25 \end{bmatrix}
```
**Solução:** Como as matrizes $A$ e $B$ possuem a mesma ordem, para que sejam iguais é necessário que:
$2x = 18$,
$-12 = 3y$,
$1 = z + 6$
e
$z^2 = 25$.
Portanto,
$x = 9$,
$y = -4$,
$z = -5$ ou $z = 5$.

### Adição entre Matrizes

**Definição:** A adição (ou soma) de duas matrizes $A$ e $B$ (ambas de mesma ordem $m \times n$), é outra matriz de ordem $m \times n$, denotada por $A + B$, cujos elementos são as somas dos elementos correspondentes (posição a posição) de $A$ e $B$, isto é:
```math
A + B = [a_{ij}]_{m \times n} + [b_{ij}]_{m \times n} = [a_{ij} + b_{ij}]_{m \times n}
```

**Exemplo:**
```math
\begin{bmatrix} 4 & -2 & 5 \\ -3 & 1 & -7 \end{bmatrix} + \begin{bmatrix} 2 & 3 & 8 \\ 1 & -1 & 6 \end{bmatrix} = \begin{bmatrix} 4 + 2 & -2 + 3 & 5 + 8 \\ -3 + 1 & 1 - 1 & -7 + 6 \end{bmatrix} = \begin{bmatrix} 6 & 1 & 13 \\ -2 & 0 & -1 \end{bmatrix}
```
**Observação:** Somente é possível somar matrizes que possuam a mesma ordem!

**Exercício 1:** Determine as somas $(A + B) + C$ e $A + (C + B)$ das matrizes abaixo
```math
A = \begin{bmatrix} -1 & 2 & 3 \\ 4 & -2 & -3 \end{bmatrix}, \quad B = \begin{bmatrix} 3 & 5 & -4 \\ -9 & 8 & 0 \end{bmatrix}, \quad C = \begin{bmatrix} -2 & -7 & 1 \\ 5 & -6 & 3 \end{bmatrix}
```
A seguir, classifique as matrizes obtidas.

### Propriedades da Adição de Matrizes

Sejam $A = [a_{ij}]_{m \times n}$, $B = [b_{ij}]_{m \times n}$ e $C = [c_{ij}]_{m \times n}$ matrizes de ordem $m \times n$.
São válidas as seguintes propriedades para a adição de matrizes:

**i) Comutatividade:** $A + B = B + A$.
**Justificativa:** Pela comutatividade da soma de números reais, como $a_{ij} + b_{ij} = b_{ij} + a_{ij}$, temos que
```math
A + B = [a_{ij}]_{m \times n} + [b_{ij}]_{m \times n} = [a_{ij} + b_{ij}]_{m \times n} = [b_{ij} + a_{ij}]_{m \times n} = [b_{ij}]_{m \times n} + [a_{ij}]_{m \times n} = B + A
```

**ii) Associatividade:** $(A + B) + C = A + (B + C)$.
**Justificativa:** Pela associatividade da soma de números reais, como $(a_{ij} + b_{ij}) + c_{ij} = a_{ij} + (b_{ij} + c_{ij})$, temos que
```math
(A + B) + C = ([a_{ij}]_{m \times n} + [b_{ij}]_{m \times n}) + [c_{ij}]_{m \times n} = [a_{ij} + b_{ij}]_{m \times n} + [c_{ij}]_{m \times n}
```
```math
= [(a_{ij} + b_{ij}) + c_{ij}]_{m \times n} = [a_{ij} + (b_{ij} + c_{ij})]_{m \times n} = [a_{ij}]_{m \times n} + [b_{ij} + c_{ij}]_{m \times n} = A + (B + C)
```

**iii) Existência de Elemento Neutro Aditivo:** A matriz nula de ordem $m \times n$, denotada por $O = [0]_{m \times n}$ é o elemento neutro da adição de matrizes, ou seja, é tal que
$A + O = A$,
para toda matriz $A = [a_{ij}]_{m \times n}$.
**Justificativa:** Como zero é o elemento neutro da adição entre números reais, temos que $a_{ij} + 0 = a_{ij}$ e, assim,
```math
A + O = [a_{ij}]_{m \times n} + [0]_{m \times n} = [a_{ij} + 0]_{m \times n} = [a_{ij}]_{m \times n} = A
```
é válido para qualquer matriz $A_{m \times n}$.

### Multiplicação por Escalar

**Definição:** Se $A$ é uma matriz de ordem $m \times n$ e $k$ é um número real, definimos a multiplicação de $A$ pelo escalar $k \in \mathbb{R}$ como a matriz dada por
```math
k \cdot A = k \cdot [a_{ij}]_{m \times n} = [k \cdot a_{ij}]_{m \times n}
```

**Exemplo:** A multiplicação da matriz $A = \begin{bmatrix} 9 & 1 & -2 \\ 1 & -5 & 3 \end{bmatrix}$ pelo escalar $k = 2$ é dada por
```math
2 \cdot A = 2 \cdot \begin{bmatrix} 9 & 1 & -2 \\ 1 & -5 & 3 \end{bmatrix} = \begin{bmatrix} 2 \cdot 9 & 2 \cdot 1 & 2 \cdot -2 \\ 2 \cdot 1 & 2 \cdot -5 & 2 \cdot 3 \end{bmatrix} = \begin{bmatrix} 18 & 2 & -4 \\ 2 & -10 & 6 \end{bmatrix}
```
**Observação:** Para multiplicar uma matriz pelo escalar $k$, basta multiplicar todos os seus elementos por $k$.

**Exercício:** Determine a matriz $C = 3A - 2B$, em que $A$, $B$ são as matrizes abaixo:
```math
A = \begin{bmatrix} -1 & 2 & 3 \\ 4 & -2 & -3 \end{bmatrix}, \quad B = \begin{bmatrix} 3 & 5 & -4 \\ 9 & 8 & 0 \end{bmatrix}
```

### Aplicação da Multiplicação por Escalar

Se $A$ é a matriz de aquisição de uma imagem digital monocromática, então a multiplicação de $A$ pelo escalar $k$ realiza uma alteração no tom da imagem, clareando-a ou escurecendo-a, conforme ilustram as figuras abaixo:

![Imagem Embutida 2](imagens/Revis%C3%A3o%20de%20Matrizes/slide_22_img_2.jpeg)
![Imagem Embutida 4](imagens/Revis%C3%A3o%20de%20Matrizes/slide_22_img_4.jpeg)
![Imagem Embutida 6](imagens/Revis%C3%A3o%20de%20Matrizes/slide_22_img_6.jpeg)
![Imagem Embutida 8](imagens/Revis%C3%A3o%20de%20Matrizes/slide_22_img_8.jpeg)

### Propriedades da Multiplicação por Escalar

Sejam $k, t \in \mathbb{R}$ e $A = [a_{ij}]_{m \times n}$ e $B = [b_{ij}]_{m \times n}$ duas matrizes de ordem $m \times n$.
São válidas as seguintes propriedades da multiplicação por escalar:

**i) Distributividade em relação à soma de matrizes:** $k(A + B) = kA + kB$.
**Justificativa:** A propriedade decorre da distributividade entre números reais:
```math
k(A + B) = k[a_{ij} + b_{ij}] = [k \cdot (a_{ij} + b_{ij})] = [k a_{ij} + k b_{ij}] = [k a_{ij}] + [k b_{ij}] = kA + kB
```

**ii) Distributividade em relação à soma de escalares:** $(k + t)A = kA + tA$.
**Justificativa:** A propriedade decorre da distributividade entre números reais:
```math
(k + t)A = (k + t)[a_{ij}] = [(k + t)a_{ij}] = [k a_{ij} + t a_{ij}] = [k a_{ij}] + [t a_{ij}] = kA + tA
```

**iii) Associatividade:** $(kt)A = k(tA)$.
**Justificativa:** A propriedade decorre da distributividade entre números reais:
```math
(kt)A = [kt a_{ij}] = [k(t a_{ij})] = k[t a_{ij}] = k(tA)
```

**iv) A multiplicação de qualquer matriz pelo escalar zero resulta na matriz nula:** $0 \cdot A = O$.
**Justificativa:**
```math
0 \cdot A = [0 \cdot a_{ij}] = [0] = O
```

### Multiplicação de Matrizes

**Definição:** Sejam $A = [a_{ij}]_{m \times n}$ e $B = [b_{rs}]_{n \times p}$ matrizes de ordem $m \times n$ e $n \times p$, respectivamente.
Definimos a multiplicação de $A$ por $B$ como a matriz
```math
A \cdot B = [c_{uv}]_{m \times p}
```
onde
```math
c_{uv} = \sum_{k=1}^{n} a_{uk} \cdot b_{kv} = a_{u1} \cdot b_{1v} + a_{u2} \cdot b_{2v} + a_{u3} \cdot b_{3v} + \dots + a_{un} \cdot b_{nv}
```

**Cuidado ao multiplicar Matrizes:**
- Só é possível efetuar o produto entre as matrizes $A_{m \times n}$ e $B_{n \times p}$ se o número de colunas da primeira matriz ($A$) for igual ao número de linhas da segunda matriz ($B$).
- Nesse caso, a matriz resultante $A \cdot B$ terá ordem $m \times p$.
- De forma prática, a multiplicação entre matrizes é obtida por meio do produto ordenado dos elementos de cada linha da primeira matriz pelos elementos de cada coluna da segunda matriz, somando-se tais produtos.

### Exemplo de multiplicação de matrizes

A multiplicação $AB$ entre as matrizes $A_{3 \times 2} = \begin{bmatrix} 2 & 1 \\ 4 & 2 \\ 5 & 3 \end{bmatrix}$ e $B_{2 \times 2} = \begin{bmatrix} 1 & -1 \\ 0 & 4 \end{bmatrix}$ está definida, pois $A$ tem duas colunas e $B$ tem duas linhas. O produto é dado por
```math
A \cdot B = \begin{bmatrix} 2 \cdot 1 + 1 \cdot 0 & 2 \cdot (-1) + 1 \cdot 4 \\ 4 \cdot 1 + 2 \cdot 0 & 4 \cdot (-1) + 2 \cdot 4 \\ 5 \cdot 1 + 3 \cdot 0 & 5 \cdot (-1) + 3 \cdot 4 \end{bmatrix} = \begin{bmatrix} 2 & 2 \\ 4 & 4 \\ 5 & 7 \end{bmatrix}
```

Já a multiplicação $BA$ entre as matrizes anteriores não está definida, pois o número de colunas de $B$ (igual a 2) é diferente do número de linhas de $A$ (igual a 3).
- **Importante:** Em geral, para a multiplicação de matrizes, temos que $A \cdot B \neq B \cdot A$, pois um dos produtos pode sequer estar definido.
- **Observação:** Ainda que os produtos $A \cdot B$ e $B \cdot A$ estejam ambos definidos, não é possível afirmar que sejam iguais. Por exemplo, caso tenhamos $A_{3 \times 4}$ e $B_{4 \times 3}$ temos que:
$A_{3 \times 4} \cdot B_{4 \times 3}$ está definido e o produto $A \cdot B$ é uma matriz de ordem $3 \times 3$,
$B_{4 \times 3} \cdot A_{3 \times 4}$ está definido e o produto $B \cdot A$ é uma matriz de ordem $4 \times 4$.


### Propriedades da Multiplicação entre Matrizes

São válidas as seguintes propriedades da multiplicação entre matrizes:
**i)** Se $I$ é a matriz identidade de ordem $n \times n$ então $I \cdot A = A = A \cdot I$ para qualquer matriz quadrada $A$ de ordem $n \times n$.
**ii)** Se $A$ é uma matriz de ordem $m \times n$ e $O$ é uma matriz nula de ordem $n \times p$, então $A \cdot O = O_{m \times p}$.
**iii)** Se $O$ é uma matriz nula de ordem $m \times n$ e $A$ é uma matriz de ordem $n \times p$ então $O \cdot A = O_{m \times p}$.
**iv) Distributividade:** Se $A$ é uma matriz de ordem $m \times n$ e $B, C$ são ambas matrizes de ordem $n \times p$, então $A \cdot (B + C) = A \cdot B + A \cdot C$.
**v) Associatividade:** Se $A$ é uma matriz de ordem $m \times n$, $B$ uma matriz de ordem $n \times p$ e $C$ uma matriz de ordem $p \times q$ então $A \cdot (B \cdot C) = (A \cdot B) \cdot C$.
**Justificativas:** As propriedades decorrem da definição de multiplicação de matrizes e de propriedades de números reais.

### Potência de uma Matriz

**Definição:** Se $A$ é uma matriz quadrada e $k$ é um número inteiro positivo, então a $k$-ésima potência de $A$ é definida como o produto
```math
A^k = \underbrace{A \cdot A \cdot A \cdot \dots \cdot A}_{k \text{ vezes}}
```

**Exemplo:** Para $A = \begin{bmatrix} 2 & -3 \\ -1 & 4 \end{bmatrix}$ e $k = 4$, têm-se que
```math
A^4 = \begin{bmatrix} 2 & -3 \\ -1 & 4 \end{bmatrix} \cdot \begin{bmatrix} 2 & -3 \\ -1 & 4 \end{bmatrix} \cdot \begin{bmatrix} 2 & -3 \\ -1 & 4 \end{bmatrix} \cdot \begin{bmatrix} 2 & -3 \\ -1 & 4 \end{bmatrix} = \begin{bmatrix} 7 & -18 \\ -6 & 19 \end{bmatrix} \cdot \begin{bmatrix} 7 & -18 \\ -6 & 19 \end{bmatrix} = \begin{bmatrix} 157 & -468 \\ -156 & 469 \end{bmatrix}
```

**Exercício:** Considere as matrizes $A = \begin{bmatrix} 4 & 5 \\ 0 & -3 \end{bmatrix}$ e $B = \begin{bmatrix} -2 & 0 \\ 0 & 1 \end{bmatrix}$.
a) Indique qual das propriedades abaixo é válida:
$(A + B)^2 = A^2 + 2AB + B^2$ ou $(A + B)^2 = A^2 + AB + BA + B^2$?
b) Investigue como determinar $B^{10}$ sem efetuar as multiplicações sucessivas. Qual conclusão obtivestes?

### Transposta de uma Matriz

**Definição:** Dada uma matriz $A = [a_{ij}]_{m \times n}$ podemos obter uma nova matriz permutando suas linhas por suas colunas de mesmo índice.
Tal matriz é denominada transposta de $A$ e é denotada por
```math
A^T = [a_{ji}]_{n \times m}
```

**Exemplo:** Para
```math
A = \begin{bmatrix} 2 & 1 \\ 4 & 2 \\ 5 & 3 \end{bmatrix}
```
temos que
```math
A^T = \begin{bmatrix} 2 & 4 & 5 \\ 1 & 2 & 3 \end{bmatrix}
```

**Propriedades da Transposta:**
**i)** Para qualquer matriz $A$ têm-se que $(A^T)^T = A$, ou seja, a transposta da transposta de uma matriz é igual à própria matriz.
**ii)** Se $A$ e $B$ são matrizes de mesma ordem tais que $A = B$ então $A^T = B^T$.
**iii)** Se $A$ e $B$ são matrizes de mesma ordem, então $(A + B)^T = A^T + B^T$.
**iv)** Se $A$ é uma matriz de qualquer ordem e $k \in \mathbb{R}$ então $(kA)^T = k A^T$.
**v)** Se $A$ é uma matriz de ordem $m \times n$ e $B$ é uma matriz de ordem $n \times p$, então
```math
(AB)^T = B^T A^T
```
(atenção para a ordem dos fatores)!

![Imagem Embutida 2](imagens/Revis%C3%A3o%20de%20Matrizes/slide_28_img_2.png)
![Imagem Embutida 3](imagens/Revis%C3%A3o%20de%20Matrizes/slide_28_img_3.png)

### Aplicação da Transposta em Imagens Digitais

Se $A$ é a matriz de a aquisição de uma imagem digital, então a transposta de $A$ realiza uma rotação de 90 graus para a esquerda, seguida de uma "inversão" vertical dessa imagem:

![Imagem Embutida 3](imagens/Revis%C3%A3o%20de%20Matrizes/slide_29_img_3.jpeg)
![Imagem Embutida 5](imagens/Revis%C3%A3o%20de%20Matrizes/slide_29_img_5.jpeg)
![Imagem Embutida 7](imagens/Revis%C3%A3o%20de%20Matrizes/slide_29_img_7.jpeg)

### Classificação quanto à Transposta

**Definição:** Uma matriz quadrada $A$ é simétrica se for igual à sua transposta, ou seja, se $A = A^T$.

**Exemplo:** A matriz $A = \begin{bmatrix} 1 & 5 & 9 \\ 5 & 3 & 8 \\ 9 & 8 & 7 \end{bmatrix}$ é simétrica, pois $A^T = \begin{bmatrix} 1 & 5 & 9 \\ 5 & 3 & 8 \\ 9 & 8 & 7 \end{bmatrix} = A$.

**Questão:** Se $A$ for simétrica, o que podemos concluir sobre seus elementos?
Se $A_{n \times n} = [a_{ij}]$ é uma matriz simétrica, então $A = A^T$ indica que
```math
a_{ij} = a_{ji}
```
e, com isso, obtemos que $a_{ij} = a_{ji}$ para todo $i, j \in \{1, 2, 3 \dots, n\}$.
Isso significa que todos os elementos de $A$ que estão dispostos simetricamente em relação a diagonal principal são iguais.

**Exemplo:** Mostre que o produto de uma matriz quadrada qualquer $A$ pela sua transposta $A^T$ é sempre uma matriz simétrica.
**Solução:** Se $A$ é uma matriz quadrada qualquer então, por propriedades da transposta:
```math
(A \cdot A^T)^T = (A^T)^T \cdot A^T = A \cdot A^T
```
Com isso, $A \cdot A^T$ é simétrica, pois coincide com sua transposta.

**Exemplo:** Mostre que se $A$ é uma matriz simétrica, então $A + A^T$ também é simétrica.
**Solução:** Se $A$ é simétrica, pela definição temos que
$A = A^T$.
Para verificar que $A + A^T$ também é simétrica, devemos mostrar que $A + A^T = (A + A^T)^T$.
Para mostrar uma igualdade, devemos sair de um lado e chegar no outro.
Saindo do lado esquerdo e usando propriedades, temos que
```math
(A + A^T)^T = A^T + (A^T)^T = A^T + A = A + A^T
```
Portanto, $A + A^T$ é simétrica.

**Definição:** Uma matriz quadrada $A$ é antissimétrica se $A^T = -A$.

**Exemplo:** A matriz $A = \begin{bmatrix} 0 & 3 & 4 \\ -3 & 0 & -6 \\ -4 & 6 & 0 \end{bmatrix}$ é antissimétrica, pois
```math
A^T = \begin{bmatrix} 0 & -3 & -4 \\ 3 & 0 & 6 \\ 4 & -6 & 0 \end{bmatrix} = - \begin{bmatrix} 0 & 3 & 4 \\ -3 & 0 & -6 \\ -4 & 6 & 0 \end{bmatrix} = -A
```

**Questão:** Se $A$ for antissimétrica, o que podemos concluir sobre seus elementos?
Se $A_{n \times n} = [a_{ij}]$ é uma matriz antissimétrica, então $A^T = -A$ indica que
```math
a_{ji} = -a_{ij}
```
e, com isso, obtemos que $a_{ji} = -a_{ij}$ para todo $i, j$.
Em particular, quando $i = j$ obtemos que $a_{ii} = -a_{ii}$, o que implica que $2a_{ii} = 0$, ou seja, $a_{ii} = 0$.
Isso significa que, em uma matriz antissimétrica, os elementos dispostos simetricamente em relação a diagonal principal são opostos e os elementos situados sobre a diagonal principal são todos nulos.

**Exemplo:** Mostre que se $A$ é uma matriz quadrada qualquer, então $A - A^T$ é sempre uma matriz antissimétrica.
**Solução:** Se $A$ uma matriz quadrada qualquer, devemos verificar que a transposta de $A - A^T$ é igual ao oposto de $A - A^T$. De fato, por propriedades, temos que
```math
(A - A^T)^T = A^T - (A^T)^T = A^T - A = -(A - A^T) = -A + A^T
```
Portanto, $A - A^T$ é sempre antissimétrica.

### Inversa de uma matriz

**Definição:** Uma matriz $A$ de ordem $n \times n$ é invertível (ou não-singular) quando existir uma matriz $B$ de ordem $n \times n$ tal que
```math
A \cdot B = B \cdot A = I_n
```
onde $I_n$ é a matriz identidade de ordem $n \times n$.
A matriz $B$ é dita a inversa de $A$ e é denotada por $B = A^{-1}$.
Se $A$ não tem inversa, dizemos que $A$ é não invertível (ou singular).
**Observação:** Somente matrizes quadradas (ordem $n \times n$) têm chances de ser inversível.

**Exemplo:** Sejam $A = \begin{bmatrix} -1 & 2 \\ -1 & 1 \end{bmatrix}$ e $B = \begin{bmatrix} 1 & -2 \\ 1 & -1 \end{bmatrix}$. Verifique se $B$ é a inversa de $A$.
**Solução:** Vamos verificar se a definição é satisfeita ou não. Como
```math
A \cdot B = \begin{bmatrix} -1 & 2 \\ -1 & 1 \end{bmatrix} \cdot \begin{bmatrix} 1 & -2 \\ 1 & -1 \end{bmatrix} = \begin{bmatrix} -1 \cdot 1 + 2 \cdot 1 & -1 \cdot (-2) + 2 \cdot (-1) \\ -1 \cdot 1 + 1 \cdot 1 & -1 \cdot (-2) + 1 \cdot (-1) \end{bmatrix} = \begin{bmatrix} 1 & 0 \\ 0 & 1 \end{bmatrix} = I
```
e
```math
B \cdot A = \begin{bmatrix} 1 & -2 \\ 1 & -1 \end{bmatrix} \cdot \begin{bmatrix} -1 & 2 \\ -1 & 1 \end{bmatrix} = \begin{bmatrix} 1 \cdot (-1) + (-2) \cdot (-1) & 1 \cdot 2 + (-2) \cdot 1 \\ 1 \cdot (-1) + (-1) \cdot (-1) & 1 \cdot 2 + (-1) \cdot 1 \end{bmatrix} = \begin{bmatrix} 1 & 0 \\ 0 & 1 \end{bmatrix} = I
```

Como verificamos que $A \cdot B = B \cdot A = I$, a definição está satisfeita e $B = A^{-1}$ é a inversa de $A$.

### Unicidade da matriz inversa

**Teorema:** Se $A_{n \times n}$ admite inversa, então sua inversa é única.
**Justificativa:** Suponhamos que $A$ admita inversa, denotada por $A^{-1}$. Logo
$A \cdot A^{-1} = A^{-1} \cdot A = I$.
Suponhamos, por absurdo, que $A$ admita outra inversa, digamos $C$, com $C \neq A^{-1}$ e
$A \cdot C = C \cdot A = I$.
Assim, temos que
```math
C = C \cdot I = C \cdot (A \cdot A^{-1}) = (C \cdot A) \cdot A^{-1} = I \cdot A^{-1} = A^{-1}
```
Portanto
$C = A^{-1}$,
o que é uma contradição, pois por hipótese, tínhamos que $C \neq A^{-1}$.
Portanto, $A$ admite uma única inversa.

### Determinação da inversa

**Exemplo:** Encontre a inversa da matriz $A = \begin{bmatrix} 2 & 1 \\ 5 & 3 \end{bmatrix}$.
**Solução:** Para encontrar a inversa de A, suponha que $A^{-1} = \begin{bmatrix} a & b \\ c & d \end{bmatrix}$ seja tal que $A \cdot A^{-1} = I$, isto é,
```math
\begin{bmatrix} 2 & 1 \\ 5 & 3 \end{bmatrix} \begin{bmatrix} a & b \\ c & d \end{bmatrix} = \begin{bmatrix} 1 & 0 \\ 0 & 1 \end{bmatrix}
```
Logo
```math
\begin{bmatrix} 2a + c & 2b + d \\ 5a + 3c & 5b + 3d \end{bmatrix} = \begin{bmatrix} 1 & 0 \\ 0 & 1 \end{bmatrix}
```
Da igualdade matricial, obtém-se os sistemas:
```math
\begin{cases} 2a + c = 1 \\ 5a + 3c = 0 \end{cases} \quad \text{e} \quad \begin{cases} 2b + d = 0 \\ 5b + 3d = 1 \end{cases}
```
Resolvendo os sistemas (como exercício) obtém-se que $a = 3$, $b = -1$, $c = -5$ e $d = 2$, ou seja,
```math
A^{-1} = \begin{bmatrix} 3 & -1 \\ -5 & 2 \end{bmatrix}
```

### Propriedades da Inversa

Sejam $A$ e $B$ matrizes quadradas de ordem $n \times n$. São válidas as seguintes propriedades:
**i)** Se $A$ é invertível, sua inversa $A^{-1}$ também é invertível e a inversa de $A^{-1}$ é $A$, ou seja,
```math
(A^{-1})^{-1} = A
```
**ii)** Se a matriz A é invertível, sua transposta $A^T$ também é invertível e sua inversa é
```math
(A^T)^{-1} = (A^{-1})^T
```
**iii)** Se $A$ e $B$ são matrizes invertíveis de mesma ordem, então o produto $AB$ é uma matriz invertível e a inversa de $AB$ é o produto $B^{-1} A^{-1}$, ou seja
```math
(AB)^{-1} = B^{-1} \cdot A^{-1}
```
**iv)** Se $A$ é invertível e $k \in \mathbb{R}$, com $k \neq 0$, então $kA$ também é invertível e sua inversa é
```math
(kA)^{-1} = \frac{1}{k} \cdot A^{-1}
```
**v)** Se $A$ é invertível e $k \in \mathbb{N}$, então
```math
(A^k)^{-1} = A^{-1} \cdot A^{-1} \cdot \dots \cdot A^{-1} = (A^{-1})^k
```
Você consegue demonstrar tais propriedades? Basta aplicar a definição de inversa!

### Determinante de uma matriz quadrada

**Definição:** O determinante é um número real associado a matrizes quadradas.
Se $A$ é uma matriz quadrada, denota-se seu determinante por $\det A$.

O cálculo do determinante de uma matriz quadrada $A_{n \times n} = [a_{ij}]$ é obtido por meio de operações (multiplicação, soma e subtração) efetuadas ordenadamente entre as entradas de $A$. Tais operações dependem da ordem de $A$, conforme descrito a seguir:
- Quando $n = 1$, têm-se que $A = [a_{11}]$ e, nesse caso, $\det(A) = a_{11}$.
- Quando $n = 2$, têm-se que $A = \begin{bmatrix} a_{11} & a_{12} \\ a_{21} & a_{22} \end{bmatrix}$ e, nesse caso, $\det(A) = a_{11}a_{22} - a_{12}a_{21}$.
Nota-se que, para $n = 2$, $\det(A)$ consiste na diferença entre o produto dos elementos situados na diagonal principal e a multiplicação dos elementos da diagonal secundária.

**Exemplo:** Obtenha o determinante de $A = \begin{bmatrix} -3 & 2 \\ 4 & -5 \end{bmatrix}$ e $A^T = \begin{bmatrix} -3 & 4 \\ 2 & -5 \end{bmatrix}$.
**Solução:** Têm-se que
$\det A = \det \begin{bmatrix} -3 & 2 \\ 4 & -5 \end{bmatrix} = -3 \cdot -5 - 2 \cdot 4 = 15 - 8 = 7$;
$\det A^T = \det \begin{bmatrix} -3 & 4 \\ 2 & -5 \end{bmatrix} = -3 \cdot -5 - 4 \cdot 2 = 15 - 8 = 7$.

### Cálculo do Determinante

- Quando $n = 3$, têm-se que
```math
A = \begin{bmatrix} a_{11} & a_{12} & a_{13} \\ a_{21} & a_{22} & a_{23} \\ a_{31} & a_{32} & a_{33} \end{bmatrix}
```
e, nesse caso, têm-se que
```math
\det(A) = a_{11}a_{22}a_{33} + a_{12}a_{23}a_{31} + a_{13}a_{21}a_{32} - a_{13}a_{22}a_{31} - a_{12}a_{21}a_{33} - a_{11}a_{23}a_{32}
```
Para $n = 3$, o $\det(A)$ pode ser facilmente obtido a partir da Regra de Sarrus, que consiste em reescrever a matriz $A$, repetindo suas duas primeiras colunas.
A seguir, efetua-se as multiplicações ordenadas entre os elementos situados nas diagonais "paralelas" à diagonal principal (mantendo o sinal do produto) e entre os elementos situados nas diagonais "paralelas" à diagonal secundária (trocando o sinal do produto), conforme representado nos esquemas abaixo:

![Imagem Embutida 3](imagens/Revis%C3%A3o%20de%20Matrizes/slide_38_img_3.png)
![Imagem Embutida 5](imagens/Revis%C3%A3o%20de%20Matrizes/slide_38_img_5.jpeg)

**Exemplo:** Sejam $A = \begin{bmatrix} -2 & 1 & 3 \\ 5 & 7 & -1 \\ 4 & -1 & -6 \end{bmatrix}$ e $B = \begin{bmatrix} 1 & -2 & 3 \\ -3 & 7 & -1 \\ 2 & -5 & -2 \end{bmatrix}$. Calcule o determinante de $A$, de $B$, de $A + B$ e de $A \cdot B$.
**Solução:** Pela Regra de Sarrus (com omissão da repetição das duas primeiras colunas, têm-se que
```math
\det A = \det \begin{bmatrix} -2 & 1 & 3 \\ 5 & 7 & -1 \\ 4 & -1 & -6 \end{bmatrix} = (-2) \cdot 7 \cdot (-6) + 1 \cdot (-1) \cdot 4 + 3 \cdot 5 \cdot (-1) - 4 \cdot 7 \cdot 3 - (-1) \cdot (-1) \cdot (-2) - (-6) \cdot 5 \cdot 1
```
```math
= 84 - 4 - 15 - 84 + 2 + 30 = 13
```

Pelo mesmo método,
```math
\det B = \det \begin{bmatrix} 1 & -2 & 3 \\ -3 & 7 & -1 \\ 2 & -5 & -2 \end{bmatrix} = 1 \cdot 7 \cdot (-2) + (-2) \cdot (-1) \cdot 2 + 3 \cdot (-3) \cdot (-5) - 2 \cdot 7 \cdot 3 - (-5) \cdot (-1) \cdot 1 - (-2) \cdot (-3) \cdot (-2)
```
```math
= -14 + 4 + 45 - 42 - 5 + 12 = 0
```

Como
```math
A + B = \begin{bmatrix} -2 & 1 & 3 \\ 5 & 7 & -1 \\ 4 & -1 & -6 \end{bmatrix} + \begin{bmatrix} 1 & -2 & 3 \\ -3 & 7 & -1 \\ 2 & -5 & -2 \end{bmatrix} = \begin{bmatrix} -1 & -1 & 6 \\ 2 & 14 & -2 \\ 6 & -6 & -8 \end{bmatrix}
```
têm-se que
```math
\det (A + B) = \det \begin{bmatrix} -1 & -1 & 6 \\ 2 & 14 & -2 \\ 6 & -6 & -8 \end{bmatrix} = (-1) \cdot 14 \cdot (-8) + (-1) \cdot (-2) \cdot 6 + 2 \cdot (-6) \cdot 6 - 6 \cdot 14 \cdot 6 - (-1) \cdot 2 \cdot (-8) - (-1) \cdot (-2) \cdot (-6)
```
```math
= 112 + 12 - 72 - 504 - 16 + 12 = -456
```
Note que $\det (A + B) \neq \det A + \det B$.

Ainda, como
```math
A \cdot B = \begin{bmatrix} -2 & 1 & 3 \\ 5 & 7 & -1 \\ 4 & -1 & -6 \end{bmatrix} \cdot \begin{bmatrix} 1 & -2 & 3 \\ -3 & 7 & -1 \\ 2 & -5 & -2 \end{bmatrix} = \begin{bmatrix} 1 & -4 & -13 \\ -18 & 44 & 10 \\ -5 & 15 & 25 \end{bmatrix}
```
têm-se que
```math
\det (A \cdot B) = \det \begin{bmatrix} 1 & -4 & -13 \\ -18 & 44 & 10 \\ -5 & 15 & 25 \end{bmatrix} = 1 \cdot 44 \cdot 25 + (-4) \cdot 10 \cdot (-5) + (-13) \cdot (-18) \cdot 15 - (-13) \cdot 44 \cdot (-5) - (-4) \cdot (-18) \cdot 25 - 1 \cdot 10 \cdot 15
```
```math
= 1100 + 200 + 3510 - 2860 - 1800 - 150 = 0
```
Nota-se que $\det (A \cdot B) = 0 = 13 \cdot 0 = \det A \cdot \det B$.

Quando $n \geq 4$, o cálculo do determinante de $A_{n \times n}$ é análogo. Porém, $\det(A)$ será uma soma de $n!$ parcelas, em que cada parcela é obtida por meio de uma multiplicação ordenada entre $n$ elementos situados em linhas e colunas distintas. Além disso, o sinal de cada parcela pode ser positivo ou negativo, conforme a diagonal formada pelos elementos multiplicados seja "paralela" à diagonal principal ou à diagonal secundária de $A$.
Nesses casos, uma forma de simplificar o cálculo do determinante de $A_{n \times n} = [a_{ij}]$ é utilizar o Desenvolvimento de Laplace, dado por
```math
\det(A) = \sum_{j=1}^{n} (-1)^{i+j} a_{ij} \det A_{ij}
```
em que $A_{ij}$ é a matriz de ordem $(n-1) \times (n-1)$, obtida pela eliminação da $i$-ésima linha e $j$-ésima coluna da matriz inicial $A$. Para aplicar o desenvolvimento de Laplace, deve-se fixar a $i$-ésima linha de $A$, a ser escolhida livremente.

**Exemplo:** Obtenha o determinante de
```math
A = \begin{bmatrix} 1 & 2 & -4 & 9 \\ -2 & 1 & 1 & 3 \\ 3 & 1 & -1 & 2 \\ 6 & -2 & 3 & -3 \end{bmatrix}
```
**Solução:** Aplicando o desenvolvimento de Laplace, tomando como base a primeira linha de $A$ e desenvolvendo por colunas, obtém-se que
```math
\det(A) = \sum_{j=1}^{4} (-1)^{1+j} a_{1j} \det A_{1j}
```
```math
= (-1)^{1+1} a_{11} \det A_{11} + (-1)^{1+2} a_{12} \det A_{12} + (-1)^{1+3} a_{13} \det A_{13} + (-1)^{1+4} a_{14} \det A_{14}
```
```math
= (-1)^2 \cdot 1 \cdot \det A_{11} + (-1)^3 \cdot 2 \cdot \det A_{12} + (-1)^4 \cdot (-4) \cdot \det A_{13} + (-1)^5 \cdot 9 \cdot \det A_{14}
```
```math
= 1 \cdot \det \begin{bmatrix} 1 & 1 & 3 \\ 1 & -1 & 2 \\ -2 & 3 & -3 \end{bmatrix} - 2 \cdot \det \begin{bmatrix} -2 & 1 & 3 \\ 3 & -1 & 2 \\ 6 & 3 & -3 \end{bmatrix} - 4 \cdot \det \begin{bmatrix} -2 & 1 & 3 \\ 3 & 1 & 2 \\ 6 & -2 & -3 \end{bmatrix} - 9 \cdot \det \begin{bmatrix} -2 & 1 & 1 \\ 3 & 1 & -1 \\ 6 & -2 & 3 \end{bmatrix}
```
```math
= 1 \cdot (1 \cdot (-1) \cdot (-3) + 1 \cdot 2 \cdot (-2) + 3 \cdot 1 \cdot 3 - 3 \cdot (-1) \cdot (-2) - 1 \cdot 1 \cdot (-3) - 2 \cdot 3 \cdot 1)
```
```math
- 2 \cdot (-2 \cdot (-1) \cdot (-3) + 1 \cdot 2 \cdot 6 + 3 \cdot 3 \cdot 3 - 3 \cdot (-1) \cdot 6 - 1 \cdot 3 \cdot (-3) - 2 \cdot 3 \cdot (-2))
```
```math
- 4 \cdot (-2 \cdot 1 \cdot (-3) + 1 \cdot 2 \cdot 6 + 3 \cdot 3 \cdot (-2) - 3 \cdot 1 \cdot 6 - 1 \cdot 3 \cdot (-3) - 2 \cdot (-2) \cdot (-2))
```
```math
- 9 \cdot (-2 \cdot 1 \cdot 3 + 1 \cdot (-1) \cdot 6 + 1 \cdot 3 \cdot (-2) - 1 \cdot 1 \cdot 6 - 1 \cdot 3 \cdot 3 - (-1) \cdot (-2) \cdot (-2))
```
```math
= 1 \cdot (-4) - 2 \cdot 52 - 4 \cdot (-20) - 9 \cdot (-28) = -4 - 104 + 80 + 252 = 224
```

**OBSERVAÇÃO:** Veja que, pelo Desenvolvimento de Laplace, o cálculo do determinante de uma matriz $4 \times 4$ é obtido pelo cálculo de quatro determinantes de matrizes de ordem $3 \times 3$. Percebe-se assim que, quanto maior for a ordem da matriz, mais trabalhoso será o cálculo do seu determinante.

### Propriedades de Determinantes

Seja $A$ uma matriz quadrada de ordem $n \times n$, com $n \geq 2$. São válidas as seguintes propriedades:
**i)** Se $k \in \mathbb{R}$ então $\det (k \cdot A) = k^n \cdot \det A$.
**ii)** Se $A^T$ é a matriz transposta de $A$, então $\det A^T = \det A$.
**iii)** Se $B$ é uma matriz quadrada de mesma ordem que $A$, então $\det (A \cdot B) = \det A \cdot \det(B)$.
**iv)** $A$ é uma matriz invertível se, e somente se, $\det A \neq 0$. Ainda, a inversa $A^{-1}$ é tal que $\det A^{-1} = \frac{1}{\det(A)}$.
**v)** Se $A$ possui alguma linha (ou coluna) inteiramente nula, então $\det A = 0$.
**vi)** Se $A$ possuir duas linhas (ou duas colunas) idênticas, então $\det A = 0$.
**vii)** Se $A$ possuir duas linhas (ou duas colunas) múltiplas entre si, então $\det A = 0$.
Você consegue demonstrar tais propriedades?

### Exercícios propostos:

1. Sabendo que $A = \begin{bmatrix} 4 & -5 \\ -7 & 9 \end{bmatrix}$, obtenha, se existir:
a) $2A^3 - 6A^T$
b) $3(A^T)^{-1}$
c) $I - 4(A^T)^{-1}$
d) $\det(2A^T - A^{-1})$

2. Encontre a matriz $A$ tal que $(3I - 2A^T)^{-1} = \begin{bmatrix} 3 & 2 \\ -5 & -4 \end{bmatrix}$.

3. Simplifique a expressão matricial $A B^{-1} A C^{-1} (D^{-1} C^{-1})^{-1} D^{-1}$.

4. Supondo que as matrizes $A, B$ e $C$ sejam quadradas e invertíveis, resolva para $D$ a equação matricial $C^T B^{-1} A^2 B C^{-1} D A^{-1} B^T C = C^T$.

5. Quais são todas as matrizes $Q$ de ordem $2 \times 2$ que satisfazem a equação
```math
(Q + 4Q^T)^{-1} = -\frac{1}{3} Q^{-1}
```

Descreva esse conjunto de matrizes explicitamente e justifique sua resposta.

6. Seja
```math
A = \begin{bmatrix} 3 & 2 & 1 & 5 \\ 1 & -4 & -2 & 3 \\ -4 & 3 & -5 & -2 \\ -1 & 7 & 3 & 1 \end{bmatrix}
```
a) Calcule:
i) $\det A$.
ii) $\det(2A^T) + \det(7A^{-1})$.

b) Determine $k \in \mathbb{R}$ para que $\det(kA^{-1}) = \det(3A^T)$.
