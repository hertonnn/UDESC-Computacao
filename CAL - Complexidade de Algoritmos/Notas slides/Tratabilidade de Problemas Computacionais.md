# Tratabilidade de Problemas Computacionais

## Objetivo
* Compreender as classes de problemas:
  * P, NP e NP-Difícil 
* Diferenciar problemas de decisão e otimização
* Entender a relação entre problemas NP e NP-Difícil


## Tratáveis e Intratáveis
* **Problemas tratáveis:**
  * Podem ser resolvidos por algoritmos deterministas que executam em tempo polinomial.
  * Hierarquia de complexidade típica: $1 < \log n < n < n \log n < n^k$
* **Problemas intratáveis:**
  * Não se conhecem algoritmos deterministas que resolvam em tempo polinomial.
  * Complexidades típicas: $2^n < n!$
* Classificamos os problemas com base na eficiência de solução.


## Categorias de Problemas
* **Problemas de Otimização:**
  * Encontrar a solução mais otimizada.
  * *Exemplos:* Menor número de cores na coloração de grafos; Caminho de menor custo no caixeiro viajante.
* **Problemas de Decisão:**
  * Tem resposta Sim ou Não.
  * *Exemplos:* É possível colorir o grafo com $k$ cores? Existe um caminho de custo menor ou igual a $x$?


## Classes de Problemas: P
* **P:**
  * Problemas resolvíveis em tempo polinomial.
  * *Exemplos:* 
    * pesquisa num vetor, 
    * merge-sort,
    * busca binária.


## Classes de Problemas: NP
* **NP:**
  * Problemas que podem ser resolvidos por algoritmos não deterministas em tempo polinomial.
  * Ou, cuja solução pode ser verificada em tempo polinomial.
* *Exemplo:* Dado um grafo, existe um clique de tamanho pelo menos $k$?
  * Pertence a NP, pois se alguém propõe um conjunto de vértices como solução, podemos verificar se estão todos conectados entre si em tempo polinomial.


## A Questão P vs NP
* Certamente $P \subseteq NP$.
* Mas $P = NP$? 
* É uma questão em aberto.
* Indício: Nunca um problema NP foi resolvido em tempo polinomial.
* Caso um problema NP seja resolvido por um algoritmo polinomial, então todos os demais também poderão. 


## Classes de Problemas: NP-Difícil (NP-Hard)
* **NP-Difícil (NP-Hard):**
  * São problemas tão difíceis quanto qualquer problema em NP.
  * Todos os problemas NP podem ser reduzidos a todos os problemas NP-Difíceis.
  * Nem todo problema NP-Difícil está em NP, pois podem não ter verificação em tempo polinomial.


*(Diagramas das Classes de Problemas)*


## Projeto de Algoritmos
* Um projetista de algoritmos deve entender os rudimentos da teoria da NP-Completude.
  * Determinar que um problema é NP-Completo dá uma boa evidência da sua intratabilidade.
  * Então, seria melhor empregar seu tempo num algoritmo de aproximação.
* Ou resolvendo um caso especial tratável.


## Reduções
* Serve para mostrar o quanto um problema é difícil.
  * Se os algoritmos forem polinomiais, então $A$ é um problema mais fácil ou tão difícil quanto $B$.
* **Fluxo da Redução ($A \le B$):**
  1. Instância do Problema A.
  2. Algoritmo de Redução em tempo polinomial.
  3. Instância do Problema B.
  4. Algoritmo que Resolve B.
  5. Solução do Problema B.
  6. Transforma a solução B numa solução A.
  7. Solução para A.


### Propriedades das Reduções
* Se A é polinomialmente redutível a B ($A \le B$), então A não é mais difícil do que B.
* Se B está na classe P:
  * Então A também está.
* Se A não está na classe P:
  * Então B também não está.


### Exemplo de Redução
* Um problema $Q$ pode ser reduzido a outro problema $Q'$ se:
  * qualquer instância de $Q$ pode ser facilmente reformulada como uma instância de $Q'$.
  * cuja solução dá uma solução para a instância de $Q$.
* Por exemplo, resolver $ax + b = 0$ pode ser transformada para $0x^2 + ax + b = 0$.
* Logo, resolver equações lineares não é mais difícil do que resolver equações quadráticas.


## Problema de Satisfatibilidade Booleana - SAT
* O problema consiste em encontrar valores que satisfaçam uma fórmula booleana.
  * *Exemplo:* `A && (B || C)`
* Primeiro problema identificado como NP-Completo.
  * Logo, todos os problemas NP são no máximo tão difíceis quanto SAT.

![Imagem Embutida 5](./imagens/Tratabilidade%20de%20Problemas%20Computacionais/slide_15_img_5.jpeg)

## Clique é NP-Completo
* Podemos reduzir um problema 3-SAT-CNF para Clique.
* A fórmula deve estar na forma normal conjuntiva.

![Imagem Embutida 5](./imagens/Tratabilidade%20de%20Problemas%20Computacionais/slide_16_img_5.jpeg)

### Redução 3-SAT para Clique
* Podemos reduzir um problema 3-SAT para Clique.
* Logo, $\text{3-SAT} \le \text{CLIQUE}$.
* Exemplo de lógica de satisfação onde se $x_3 = \text{true}$ e $x_2 = \text{false}$, $\Phi = \text{true}$ (como $x_1$ está fora, tanto faz o seu valor).


## Exercício: Cobertura de Vértices
* Mostre que o problema da cobertura de vértices (Vertex Cover) é NP-Difícil.
  * Podemos reduzir CLIQUE para VERTEX-COVER.
* Passos:
  1. Faça um grafo $G$ com um clique.
  2. Faça um grafo $G'$ que seja o complemento de grafo.
  3. Encontre uma relação entre os nós que formam o clique em $G$ e os nós que formam a melhor cobertura em $G'$.


## Referências
* Cormen, T. (2012). *Algoritmos - Teoria e Prática* (3rd ed.). Grupo GEN.
* Serpa, M. S., Rodrigues, T. N., & Alves, Í. C. et al. (2021). *Análise de Algoritmos*. Grupo A.
* Cormen, T. (2013). *Desmistificando Algoritmos*. Grupo GEN.
