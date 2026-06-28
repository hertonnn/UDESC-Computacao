# Complexidade de Algoritmos: Conceitos Básicos

## Conteúdo

*   Complexidade e Desempenho.

## Complexidade

A **complexidade** é o esforço computacional necessário para executar um algoritmo sobre uma entrada de tamanho $n$.

Existem vários aspectos a considerar em relação à complexidade de um algoritmo:

*   **Medida Empírica**: Consiste em medir experimentalmente o tempo de um algoritmo em uma máquina. Porém, é uma medida fortemente dependente do programa e do hardware (máquina).
*   **Análise Matemática**: É uma alternativa independente da implementação. Permite antecipar o cálculo da complexidade ainda na fase de projeto do algoritmo, sendo a **Notação Big $\mathcal{O}$** a principal forma de expressá-la.

A complexidade não pode ser descrita simplesmente por um número absoluto, pois a quantidade de trabalho varia dependendo do tamanho e formato da entrada.

## Critérios de Complexidade

O tempo requerido por um algoritmo pode ser medido pelo número de execuções de algumas operações. Costuma-se escolher uma **operação fundamental**. O número de vezes que ela é executada expressa a quantidade de trabalho do algoritmo.

*   **Exemplo:** Num algoritmo de ordenação, a operação fundamental seria a comparação entre elementos. (Podendo ser necessária mais de uma).

## Pior Caso, Melhor Caso e Caso Médio

O número de operações pode depender não apenas do tamanho, mas também do estado da entrada (ex: entrada já parcialmente ordenada para um algoritmo de ordenação).

*   Em geral, o foco das análises é o **pior caso**.
*   Também podemos analisar o **melhor caso** e o **caso médio**.
*   **Exemplo**: Numa busca em um vetor de $n$ elementos, qual seria o melhor, o pior e o caso médio?

## Comportamento Assintótico

![Imagem Embutida 4](./imagens/A02%20-%20CAL/slide_8_img_4.png)

Dependendo do valor de $n$, um algoritmo poderá realizar muito mais operações que outro. Um caso de extremo interesse é quando $n$ assume um valor grande. Nessas condições, termos de menor grau e constantes multiplicativas contribuem muito pouco para o tempo total. O mais importante é focar no termo dominante, como por exemplo diferenciar $g(n) = n^2$ de $f(n) = n$.

![Imagem Embutida 4](./imagens/A02%20-%20CAL/slide_9_img_4.png)

Por exemplo, a função $n^2 + 10n$ possui o mesmo crescimento assintótico que apenas $n^2$.

Uma **Cota Assintótica Superior (CAS)** é uma função que cresce mais rapidamente do que outra, permanecendo acima dela a partir de um certo ponto:

$\exists n_0 \in \mathbb{N}$
$\forall n \ge n_0 : f(n) \le g(n)$

Ou seja, para um $n$ suficientemente grande, a função $g(n)$ sempre domina $f(n)$.

## Notação Big $\mathcal{O}$

A notação $\mathcal{O}$ descreve o **pior caso** de tempo de execução do algoritmo, expressando-o em termos de uma função que representa o seu crescimento assintótico. Ela define uma cota assintótica superior ignorando as constantes matemáticas.

*   **Exemplo**: A função $g(n) = n^2$ cresce mais rapidamente do que a função $f(n) = n$.
*   Dizemos que a função linear $f(n)$ é $\mathcal{O}(g(n))$. Em outras palavras, $f(n)$ "é pequena para" $g(n)$.
*   Matematicamente: $f(n) = \mathcal{O}(g(n))$.

![Imagem Embutida 3](./imagens/A02%20-%20CAL/slide_11_img_3.png)

![Imagem Embutida 4](./imagens/A02%20-%20CAL/slide_11_img_4.png)

*(Exemplos de crescimento de funções via Geogebra)*

### Exemplos de Complexidade com Notação $\mathcal{O}$

*   **Complexidade Constante:** $\mathcal{O}(1) + \mathcal{O}(1) = \mathcal{O}(1)$

![Imagem Embutida 4](./imagens/A02%20-%20CAL/slide_13_img_4.png)

*   **Multiplicação de Termos Lineares:**
    *   $\mathcal{O}(n)$
    *   $n \cdot n = \mathcal{O}(n^2)$
    *   $\mathcal{O}(n^3)$
*   **Variáveis Diferentes:**
    *   $n \cdot m = \mathcal{O}(n \cdot m)$

![Imagem Embutida 3](./imagens/A02%20-%20CAL/slide_15_img_3.png)

*   **Soma de Termos (Dominância):**
    *   Entre $\mathcal{O}(n^2)$ e $\mathcal{O}(n^3)$, temos que: $n^2 + n^3 = \mathcal{O}(n^3)$. O maior termo sempre domina.

## Análise de Algoritmos na Notação $\mathcal{O}$

![Imagem Embutida 4](./imagens/A02%20-%20CAL/slide_16_img_4.png)

Ao analisar a complexidade de um trecho de código, siga os seguintes passos:
1. Expresse a quantidade de operações em relação a $n$.
2. Crie uma função matemática `número de operações X tempo`.
3. Encontre o $\mathcal{O}$: A classe de funções que melhor descreve o crescimento assintótico é a complexidade real do algoritmo.

**Exemplo de Laços Aninhados:**
Considerando laços onde `i` e `j` iteram até `n`:
```text
i = 0    j = 0..n-1     (n operações)
i = 1    j = 0..n-1     (n operações)
...
i = n    j = 0..n-1     (n operações)
```
Teremos que $n$ é somado $n$ vezes: $(n + n + \dots + n) = n \cdot n = n^2$.
Logo, a complexidade é **$\mathcal{O}(n^2)$**.

### Simplificando Algoritmos

Para poder simplificar o algoritmo e diminuir sua complexidade, é vital entender sua operação lógica e como os dados estão dispostos.

Supondo que os dados de entrada formem o vetor `[a, b]` e a execução bruta resulte no seguinte polinômio:
$a \cdot a + a \cdot b + b \cdot a + b \cdot b$

Fatorando e evidenciando, podemos reduzir as multiplicações e somas redundantes:
$a(a+b) + b(a+b)$

*(A reflexão principal é: como alterar a lógica baseada na fatoração matemática para construir um algoritmo de menor complexidade computacional?)*

## Caso Médio ($\theta$)

![Imagem Embutida 4](./imagens/A02%20-%20CAL/slide_19_img_4.png)

Para analisar o caso médio de um algoritmo de busca, questionamos: Qual a probabilidade do elemento procurado estar em cada uma das posições do vetor?

Assumindo uma **distribuição uniforme**, o número de comparações é dado pelo somatório:

$$ \sum_{i=1}^{n} c_i \cdot p_i $$

*   **$c_i$**: Número de comparações necessárias para encontrar o elemento na posição $i$.
*   **$p_i$**: Probabilidade do elemento estar, de fato, na posição $i$.

Desenvolvendo o cálculo para um vetor de tamanho $n$:

$$1 \cdot \frac{1}{n} + 2 \cdot \frac{1}{n} + 3 \cdot \frac{1}{n} + \dots + (n-1) \cdot \frac{1}{n} + n \cdot \frac{1}{n}$$

Podemos colocar o fator da probabilidade ($\frac{1}{n}$) em evidência:

$$= \frac{1}{n} \cdot (1 + 2 + \dots + (n-1) + n)$$

Sabendo que a soma de uma Progressão Aritmética (PA) simples de $1$ a $n$ resulta em $\frac{n \cdot (n+1)}{2}$, substituímos na fórmula:

$$= \frac{1}{n} \cdot \frac{n \cdot (n+1)}{2}$$

Cancelando os termos de $n$, o resultado final de operações em caso médio é:

$$= \frac{n+1}{2}$$

Dessa forma, provamos que, apesar das simplificações matemáticas constantes (como dividir por 2), o crescimento da função de caso médio continua dependendo linearmente de $n$, o que significa que o Caso Médio também pertence à classe assintótica **$\mathcal{O}(n)$**.
