## Tópicos e Problemas

### Anotação 1: Fatoração $A=LU$

**Objetivo:** Resolver os sistemas lineares a seguir utilizando o método de fatoração $A=LU$.

(a)

$$
\begin{cases}2x_{1}+x_{2}&=-5\\
6x_{1}+4x_{2}+2x_{3}&=-6\\
2x_{3}+x_{4}&=9\\
-x_{2}-2x_{3}+x_{4}&=-8\end{cases}
$$

(b)

$$
\begin{cases}2x_{1}+x_{2}&=-2\\
6x_{1}+4x_{2}+2x_{3}&=0\\
2x_{3}+x_{4}&=6\\
-x_{2}-2x_{3}+x_{4}&=-4\end{cases}
$$

---

### Anotação 2: Métodos Iterativos (Jacobi e Gauss-Seidel)

**Objetivo:** Analisar o erro relativo entre os métodos iterativos. Sabendo que o vetor inicial $X^{(0)}=(1,1,1)$ está próximo da solução, deve-se mostrar que a aproximação $X^{(3)}=(x_{1}^{(3)},x_{2}^{(3)},x_{3}^{(3)})$ obtida pelo método de Jacobi possui um erro relativo aproximadamente 10 vezes maior que o cometido pelo método de Gauss-Seidel. É necessário permutar as equações do sistema abaixo para garantir a convergência dos métodos:

$$
\begin{cases}x_{1}+9x_{2}+x_{3}&=10\\
-4x_{2}+8x_{3}&=10\\
10x_{1}+x_{3}&=10\end{cases}
$$

---

### Anotação 3: Interpolação pelo Método de Lagrange

**Objetivo:** Dada a função $f(x)=\cos(\frac{\pi x}{2})$, avaliar qual dos polinômios a seguir fornece a aproximação $p(1/2)\approx f(1/2)=\sqrt{2}/2$ com o menor erro absoluto utilizando o método de Lagrange:

- (a) O polinômio $p(x)$ que interpola $f$ nos pontos $x_{1}=-1$, $x_{2}=0$ e $x_{3}=1$.
- (b) O polinômio $q(x)$ que interpola $f$ nos pontos $x_{1}=0$, $x_{2}=1$ e $x_{3}=2$.

---

### Anotação 4: Diferenças Divididas

**Objetivo:** Utilizar diferenças divididas para encontrar o polinômio interpolador $p(x)$ que modela o desempenho de um processador em função do tempo superaquecido. Em seguida, estimar a frequência do processador caso ele fique superaquecido por **50%** do tempo.

| % de tempo superaquecido | Frequência (MHz) |
| :--- | :--- |
| 0 | 3500 |
| 10 | 3400 |
| 60 | 2500 |
| 90 | 1500 |

---

## Resoluções

### Solução da Anotação 1

Através das operações elementares $L_{2}\rightarrow L_{2}+3L_{1}$ e $L_{4}\rightarrow L_{4}-L_{2}$, obtém-se as seguintes matrizes para a fatoração $A=LU$:

$$
L=\begin{bmatrix}1&0&0&0\\
3&1&0&0\\
0&0&1&0\\
0&-1&0&1\end{bmatrix} \quad \text{e} \quad U=\begin{bmatrix}2&1&0&0\\
0&1&2&0\\
0&0&2&1\\
0&0&0&1\end{bmatrix}
$$

Como $A$ é a matriz de coeficientes de ambos os sistemas, a mesma fatoração é utilizada. Para a resolução, primeiro resolve-se o sistema $LY=B$ e, com a solução $Y$, resolve-se $UX=Y$.

- **Para o sistema (a):**

$$
Y=\begin{bmatrix}-5\\
9\\
9\\
1\end{bmatrix}, \quad X=\begin{bmatrix}-3\\
1\\
4\\
1\end{bmatrix}
$$

- **Para o sistema (b):**

$$
Y=\begin{bmatrix}-2\\
6\\
6\\
2\end{bmatrix}, \quad X=\begin{bmatrix}-2\\
2\\
2\\
2\end{bmatrix}
$$

---

### Solução da Anotação 2

A matriz original não é estritamente diagonal dominante (na primeira linha tem-se $|1|<|9|+|1|$) e, portanto, não há garantia inicial de convergência para os métodos iterativos. Permutando as linhas, obtém-se o sistema equivalente com garantia de convergência:

$$
\begin{cases}10x_{1}+x_{3}&=10\\
x_{1}+9x_{2}+x_{3}&=10\\
-4x_{2}+8x_{3}&=10\end{cases} \Leftrightarrow \begin{bmatrix}10&0&1\\
1&9&1\\
0&-4&8\end{bmatrix} \cdot \begin{bmatrix}x_{1}\\
x_{2}\\
x_{3}\end{bmatrix} = \begin{bmatrix}10\\
10\\
10\end{bmatrix}
$$

**Equações de Iteração:**

- **Método de Jacobi:**

$$
\begin{cases}x_{1}^{(k)}&=(10-x_{3}^{(k-1)})/10\\
x_{2}^{(k)}&=(10-x_{1}^{(k-1)}-x_{3}^{(k-1)})/9\\
x_{3}^{(k)}&=(10+4x_{2}^{(k-1)})/8\end{cases}
$$

- **Método de Gauss-Seidel** (utiliza os valores calculados na mesma iteração):

$$
\begin{cases}x_{1}^{(k)}&=(10-x_{3}^{(k-1)})/10\\
x_{2}^{(k)}&=(10-x_{1}^{(k)}-x_{3}^{(k-1)})/9\\
x_{3}^{(k)}&=(10+4x_{2}^{(k)})/8\end{cases}
$$

**Iterações do Método de Jacobi:**

| $k$ | 0 | 1 | 2 | 3 |
| :--- | :--- | :--- | :--- | :--- |
| $x_{1}^{(k)}$ | 1.0000 | 0.9000 | 0.8250 | 0.8306 |
| $x_{2}^{(k)}$ | 1.0000 | 0.8889 | 0.8167 | 0.8312 |
| $x_{3}^{(k)}$ | 1.0000 | 1.7500 | 1.6944 | 1.6583 |

**Iterações do Método de Gauss-Seidel:**

| $k$ | 0 | 1 | 2 | 3 |
| :--- | :--- | :--- | :--- | :--- |
| $x_{1}^{(k)}$ | 1.0000 | 0.9000 | 0.8300 | 0.8335 |
| $x_{2}^{(k)}$ | 1.0000 | 0.9000 | 0.8300 | 0.8335 |
| $x_{3}^{(k)}$ | 1.0000 | 1.7000 | 1.6650 | 1.6668 |

**Estimativas de Erro na 3ª Iteração:**

- **Método de Jacobi:**
    - Erro Absoluto: $\|X^{(3)}-X^{(2)}\| = \max\{|0.8306-0.8250|, |0.8312-0.8167|, |1.6583-1.6944|\} = 0.0361$.
    - Erro Relativo: $0.0361 / 1.6583 = 0.0218$.
- **Método de Gauss-Seidel:**
    - Erro Absoluto: $\|X^{(3)}-X^{(2)}\| = \max\{|0.8335-0.8300|, |0.8335-0.8300|, |1.6668-1.6650|\} = 0.0035$.
    - Erro Relativo: $0.0035 / 1.6668 = 0.0021$.

---

### Solução da Anotação 3

**(a)** Considerando $x_{1}=-1$, $x_{2}=0$, $x_{3}=1$ e $y_{1}=0$, $y_{2}=1$, $y_{3}=0$:

$$
p(x)=0L_{1}(x)+1L_{2}(x)+0L_{3}(x)=\frac{(x+1)(x-1)}{(0+1)(0-1)}=1-x^{2}
$$

O erro absoluto em $x=1/2$ é $\epsilon_{abs}=|f(1/2)-p(1/2)|\approx|0.7071-0.7500|=0.0429$.

**(b)** Considerando $x_{1}=0$, $x_{2}=1$, $x_{3}=2$ e $y_{1}=1$, $y_{2}=0$, $y_{3}=-1$:

$$
q(x)=1L_{1}(x)+0L_{2}(x)-1L_{3}(x)=\frac{(x-1)(x-2)}{(-1)(-2)}-\frac{(x-0)(x-1)}{(2-0)(2-1)}
$$

$$
q(x)=\frac{1}{2}(x-1)(x-2)-\frac{1}{2}x(x-1)=1-x
$$

O erro absoluto em $x=1/2$ é $\epsilon_{abs}=|f(1/2)-q(1/2)|\approx|0.7071-0.5000|=0.2071$.

**Conclusão:** O valor de $f(1/2)$ está mais próximo de $p(1/2)$ do que de $q(1/2)$.

---

### Solução da Anotação 4

A partir dos pontos fornecidos, obtém-se as seguintes diferenças divididas:

- $f[x_{0}] = 3500$, para $x_{0}=0$.
- $f[x_{1}] = 3400$, para $x_{1}=10$. A diferença dividida é $f[x_{0},x_{1}] = -10$.
- $f[x_{2}] = 2500$, para $x_{2}=60$. As diferenças são $f[x_{1},x_{2}] = -18$ e $f[x_{0},x_{1},x_{2}] = -\frac{2}{15} \approx -0.1333$.
- $f[x_{3}] = 1500$, para $x_{3}=90$. As diferenças são $f[x_{2},x_{3}] = -\frac{100}{3} \approx -33.3333$, $f[x_{1},x_{2},x_{3}] = -\frac{23}{120} \approx -0.1917$ e a diferença final é $f[x_{0},x_{1},x_{2},x_{3}] = -\frac{7}{10800} \approx -0.0006$.

O polinômio interpolador é:

$$
p(x)=3500-10x-0.1333x(x-10)-0.0006x(x-10)(x-60)
$$

$$
p(x)=-0.0006x^{3}-0.0913x^{2}-9.027x+3500
$$

Estimando a frequência do processador para 50% de tempo superaquecido:

$$
p(50)=3500-10\cdot50-0.1333\cdot50\cdot40-0.0006\cdot50\cdot40\cdot(-10)=2745.4
$$
