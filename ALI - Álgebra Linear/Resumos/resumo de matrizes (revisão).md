
Revisão de Matriz



1. Tipos Especiais de Matriz



**Matriz Linha:** É qualquer matriz que possua uma única linha ($m = 1$


**Matriz Coluna:** É qualquer matriz que possua uma única coluna ($n = 1$


**Matriz Nula:** É qualquer matriz cujos elementos são todos iguais a zero, isto


$$a_{ij} = 0, \quad \forall i, \forall j


Representada po


$$0 = [0]_{m \times n}


**Matriz Retangular:** É qualquer matriz cujo número de linhas é diferente do número de colunas, ou seja, em que $m \neq n


**Matriz Quadrada:** É qualquer matriz cujo número de linhas é igual ao número de colunas, ou seja, em que $m = n


*   A **diagonal principal** é caracterizada por elementos onde $i = j


*   A **diagonal secundária** é caracterizada por elementos onde $i + j = n + 1


**Matriz Diagonal:** É uma matriz quadrada ($m = n$) em que $a_{ij} = 0$ sempre que $i \neq j$, ou seja, todos os elementos que não estão na diagonal principal são sempre nulo


*   *Obs:* Em uma matriz diagonal é possível que algum (ou inclusive todos) elemento situado sobre a diagonal principal seja igual a zer


**Matriz Identidade:** É uma matriz diagonal cujos elementos da diagonal principal são todos iguais a $1$, isto


$$a_{ij} = 0 \text{ sempre que } i \neq j \quad \text{e} \quad a_{ij} = 1 \text{ sempre que } i = j


**Matriz Triangular Superior:** É uma matriz quadrada ($m = n$) em que todos os elementos situados abaixo da diagonal principal são nulos, ou sej


$$a_{ij} = 0 \text{ sempre que } i > j


*   *Obs:* É possível que algum (ou inclusive todos) elemento situado sobre ou acima da diagonal principal seja igual a zer


**Matriz Triangular Inferior:** É uma matriz quadrada ($m = n$) em que todos os elementos situados acima da diagonal principal são nulos, ou sej


$$a_{ij} = 0 \text{ sempre que } i < j


*   *Obs:* É possível que algum (ou inclusive todos) elemento situado sobre ou abaixo da diagonal principal seja igual a zer


---


2. Igualdade entre Matriz



as matrizes $A = [a_{ij}]_{m \times n}$ e $B = [b_{ij}]_{r \times s}$ são iguais se e somente se possuem o mesmo número de linhas e de colunas ($m = r$ e $n = s$) e se todos os seus elementos correspondentes forem respectivamente iguai


a_{ij} = b_{ij}, \quad \forall i, \forall j


---


3. Adição de Matriz



adição (ou soma) de duas matrizes $A$ e $B$ (ambas de mesma ordem $m \times n$) é outra matriz de ordem $m \times n$, denotada por $A + B$, cujos elementos são as somas dos elementos correspondentes (posição a posição) de $A$ e $B$, isto


A + B = [a_{ij}]_{m \times n} + [b_{ij}]_{m \times n} = [a_{ij} + b_{ij}]_{m \times n}



*Obs:* Somente é possível somar matrizes que possuam a mesma orde



# Propriedades da Adição de Matriz


**Comutatividade:** $A + B = B +


**Associatividade:** $(A + B) + C = A + (B + C


**Existência de Elemento Neutro Aditivo:** A matriz nula de ordem $m \times n$, denotada por $0 = [0]_{m \times n}$, é o elemento neutro da adição de matrizes, ou seja, é tal qu


$$A + 0 = A


---


4. Multiplicação por Escal



$A$ é uma matriz de ordem $m \times n$ e $k$ é um número real ($k \in \mathbb{R}$), definimos a multiplicação de $A$ pelo escalar $k$ como a matriz dada po


k \cdot A = k \cdot [a_{ij}]_{m \times n} = [k \cdot a_{ij}]_{m \times n}



Multiplica-se o escalar por todos os elementos da matri



# Propriedades da Multiplicação por Escal


**Distributividade em relação à soma de matrizes:** $k(A + B) = kA + k


**Distributividade em relação à soma de escalares:** $(k + t)A = kA + t


**Associatividade:** $k(tA) = (kt)


**Multiplicação pelo escalar zero:** A multiplicação de qualquer matriz pelo escalar zero resulta na matriz nul


$$0 \cdot A = 0


---


5. Multiplicação de Matriz



jam $A = [a_{ij}]_{m \times n}$ e $B = [b_{jk}]_{n \times p}$ matrizes de ordem $m \times n$ e $n \times p$, respectivamente. Definimos a multiplicação de $A$ por $B$ como a matriz $A \cdot B = [c_{ik}]_{m \times p}$, onde cada elemento $c_{ik}$ é obtido pela soma dos produtos dos elementos correspondentes da linha $i$ de $A$ pelos elementos da coluna $k$ de $B


c_{ik} = \sum_{j=1}^{n} a_{ij} b_{jk}



**Regra de Compatibilidade:** Só é possível efetuar o produto entre as matrizes se o número de colunas da primeira matriz for igual ao número de linhas da segunda matri


**Não comutatividade (em geral):** Para a multiplicação de matrizes, em geral temos qu


$$A \cdot B \neq B \cdot A



# Propriedades da Multiplicação entre Matriz


**Elemento Neutro Multiplicativo:** Se $I$ é a matriz identidade de ordem compatível, entã


$$I \cdot A = A = A \cdot I


**Multiplicação por Matriz Nula:


*   Se $A$ é uma matriz de ordem $m \times n$ e $O$ é uma matriz nula de ordem $n \times p$, entã


$$A \cdot O = O_{m \times p}


*   Se $O$ é uma matriz nula de ordem $m \times n$ e $A$ é uma matriz de ordem $n \times p$, entã


$$O \cdot A = O_{m \times p}


**Distributividade:** Se $A$ é uma matriz de ordem $m \times n$ e $B, C$ são ambas matrizes de ordem $n \times p$, entã


$$A \cdot (B + C) = A \cdot B + A \cdot C


**Associatividade:** Se $A$ é uma matriz de ordem $m \times n$, $B$ uma matriz de ordem $n \times p$ e $C$ uma matriz de ordem $p \times q$, entã


$$(A \cdot B) \cdot C = A \cdot (B \cdot C)


---


6. Potência de uma Matr



$A$ é uma matriz quadrada e $k$ é um número inteiro positivo ($k \in \mathbb{Z}^+$), então a $k$-ésima potência de $A$ é definida como o produt


A^k = \underbrace{A \cdot A \cdot A \cdots A}_{k \text{ vezes}}


---


7. Transposta de uma Matr



da uma matriz $A = [a_{ij}]_{m \times n}$, podemos obter uma nova matriz permutando suas linhas por suas colunas de mesmo índice. Tal matriz é denominada transposta de $A$ e é denotada por $A^T


A^T = [a_{ji}]_{n \times m}



# Propriedades da Transpos


**Dupla Transposição:** Para qualquer matriz $A$, tem-se qu


$$(A^T)^T = A


*(a transposta da transposta de uma matriz é igual à própria matriz


**Igualdade:** Se $A$ e $B$ são matrizes de mesma ordem tais que $A = B$, entã


$$A^T = B^T


**Transposta da Soma:** Se $A$ e $B$ são matrizes de mesma ordem, entã


$$(A + B)^T = A^T + B^T


**Transposta de Multiplicação por Escalar:** Se $A$ é uma matriz de qualquer ordem e $k \in \mathbb{R}$, entã


$$(kA)^T = kA^T


**Transposta do Produto:** Se $A$ é uma matriz de ordem $m \times n$ e $B$ é uma matriz de ordem $n \times p$, entã


$$(A \cdot B)^T = B^T \cdot A^T



# Classificação quanto à Transpos


**Matriz Simétrica:** Uma matriz quadrada $A$ é simétrica se for igual à sua transposta, ou seja, s


$$A = A^T


**Matriz Antissimétrica:** Uma matriz quadrada $A$ é antissimétrica s


$$A^T = -A


---


8. Matriz Inver



a matriz $A$ de ordem $n \times n$ é invertível (ou não-singular) quando existir uma matriz $B$ de ordem $n \times n$ tal qu


A \cdot B = B \cdot A = I_n


de $I_n$ é a matriz identidade de ordem $n \times n


A matriz $B$ é denominada a inversa de $A$ e é denotada por $B = A^{-1}


Se $A$ não tem inversa, dizemos que $A$ é não invertível (ou singular



# Propriedades da Inver


**Inversa da Inversa:** Se $A$ é invertível, sua inversa $A^{-1}$ também é invertível


$$(A^{-1})^{-1} = A


**Inversa da Transposta:** Se a matriz $A$ é invertível, sua transposta $A^T$ também é invertível


$$(A^T)^{-1} = (A^{-1})^T


**Inversa do Produto:** Se $A$ e $B$ são matrizes invertíveis de mesma ordem, então o produto $A \cdot B$ é uma matriz invertível


$$(A \cdot B)^{-1} = B^{-1} \cdot A^{-1}


**Inversa do Produto por Escalar:** Se $A$ é invertível e $k \in \mathbb{R}$ com $k \neq 0$, então $k \cdot A$ também é invertível


$$(k \cdot A)^{-1} = \frac{1}{k} A^{-1}


**Inversa de Potência:** Se $A$ é invertível e $k \in \mathbb{Z}^+$, entã


$$(A^k)^{-1} = (A^{-1})^k = \underbrace{A^{-1} \cdot A^{-1} \cdots A^{-1}}_{k \text{ vezes}}


---


9. Determinante de uma Matriz Quadra



a matriz $A$ de ordem $n \times n$ possui um valor numérico associado denominado determinant



# Regra de Sarr


nsiste em reescrever a matriz $A$ (normalmente de ordem $3 \times 3$), repetindo suas duas primeiras colunas à direita. A segui


Efetua-se as multiplicações ordenadas entre os elementos situados nas diagonais "paralelas" à diagonal principal (mantendo o sinal do produto


Efetua-se as multiplicações ordenadas entre os elementos situados nas diagonais "paralelas" à diagonal secundária (invertendo/trocando o sinal do produto


Soma-se todos os resultados obtido



# Propriedades de Determinant


ja $A$ uma matriz quadrada de ordem $n \times n$, com $n \geq 2


**Multiplicação por Escalar:** Se $k \in \mathbb{R}$, entã


$$\det(k \cdot A) = k^n \cdot \det(A)


**Transposta:** Se $A^T$ é a matriz transposta de $A$, entã


$$\det(A^T) = \det(A)


**Produto de Matrizes (Teorema de Cauchy-Binet):** Se $B$ é uma matriz quadrada de mesma ordem que $A$, entã


$$\det(A \cdot B) = \det(A) \cdot \det(B)


**Invertibilidade:** $A$ é uma matriz invertível se e somente s


$$\det(A) \neq 0


Ainda, a inversa $A^{-1}$ é tal qu


$$\det(A^{-1}) = \frac{1}{\det(A)}


**Linha ou Coluna Nula:** Se $A$ possui alguma linha ou coluna inteiramente nula, entã


$$\det(A) = 0


**Linhas ou Colunas Idênticas:** Se $A$ possuir duas linhas ou duas colunas idênticas, entã


$$\det(A) = 0


**Linhas ou Colunas Proporcionais/Múltiplas:** Se $A$ possuir duas linhas ou duas colunas múltiplas entre si, entã


$$\det(A) = 0

