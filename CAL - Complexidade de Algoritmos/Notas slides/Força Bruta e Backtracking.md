# Força Bruta e Backtracking

## Força Bruta


A Força Bruta é a abordagem mais direta para resolver um problema. Ela se baseia na tentativa de encontrar uma solução simplesmente testando **todas** as possibilidades. É um método que depende fortemente do poder computacional e não da inteligência na modelagem do algoritmo.

### Exemplos de Algoritmos de Força Bruta


- Busca Sequencial
- Multiplicação de Matrizes
- Bubble Sort

### Problema do Caixeiro Viajante


![Imagem Embutida 4](./imagens/For%C3%A7a%20Bruta%20-%20BackTracking/slide_4_img_4.png)

O **Problema do Caixeiro Viajante** é um exemplo clássico que pode ser abordado via Força Bruta. O objetivo é passar por cada cidade uma única vez e voltar à origem, considerando o custo mínimo. 


![Imagem Embutida 4](./imagens/For%C3%A7a%20Bruta%20-%20BackTracking/slide_5_img_4.png)

Por exemplo, um caminho possível testado pode ser `[1, 2, 3, 4, 5, 1]`, resultando em um Custo 22. Testar todos esses caminhos é um exemplo de Força Bruta.

## Técnicas para Reduzir a Busca Exaustiva


Existem muitos problemas que são difíceis de resolver, nos quais é muito difícil propor um algoritmo eficiente. Para esses casos, existem duas técnicas principais de projeto de algoritmo cujo objetivo é tentar **diminuir o espaço de busca** (embora no pior caso, elas ainda enfrentem a explosão exponencial da busca exaustiva).


Para melhorar a busca exaustiva, as duas técnicas são:
1. **Backtracking:** Recuar e Retroceder
2. **Branch-and-bound:** Ramificar e limitar

Ambas são baseadas na construção de uma **árvore de estados**, onde os nós refletem uma escolha feita em direção a uma solução.

### Backtracking


![Imagem Embutida 4](./imagens/For%C3%A7a%20Bruta%20-%20BackTracking/slide_8_img_4.png)

No algoritmo de Backtracking:
- Dado um estado inicial, a cada passo em direção à solução cria-se um novo nó.
- O algoritmo **retrocede** sempre que a sequência de passos não atingiu uma solução viável.
- O retrocesso também ocorre quando se deseja continuar procurando por uma solução melhor.

#### Exemplo de Backtracking


![Imagem Embutida 4](./imagens/For%C3%A7a%20Bruta%20-%20BackTracking/slide_9_img_4.png)

![Imagem Embutida 5](./imagens/For%C3%A7a%20Bruta%20-%20BackTracking/slide_9_img_5.png)

Iniciando no nó 1, são possíveis 3 passos: de 1 para 2, de 1 para 5 ou de 1 para 4.


![Imagem Embutida 4](./imagens/For%C3%A7a%20Bruta%20-%20BackTracking/slide_10_img_4.png)

![Imagem Embutida 5](./imagens/For%C3%A7a%20Bruta%20-%20BackTracking/slide_10_img_5.png)

**Exercício:** Encontre uma solução a partir do nó `[1,4]` e um caminho na árvore que não leve a uma solução.

## Problemas de Decisão e Otimização


Um problema pode ter a sua versão de otimização e a sua versão de decisão:
- **Decisão:** Podemos colorir um grafo com $k$ cores? (A resposta é um booleano: Sim ou Não).
- **Otimização:** Qual o menor número de cores $k$ necessário para colorir um grafo?

O backtracking é mais indicado e eficiente para resolver problemas de **decisão**.

### Problema de Coloração em Grafos


![Imagem Embutida 4](./imagens/For%C3%A7a%20Bruta%20-%20BackTracking/slide_12_img_4.png)

![Imagem Embutida 5](./imagens/For%C3%A7a%20Bruta%20-%20BackTracking/slide_12_img_5.png)

Supondo um grafo com 4 nós. Se testarmos todas as possibilidades de coloração, teremos a árvore a seguir. O cálculo total de possibilidades gera:

$$1 + 3 + 3^2 + 3^3 + 3^4 = \frac{3^5 - 1}{3 - 1} = \frac{k^{V+1} - 1}{k - 1}$$

A complexidade final fica na ordem de $O(k^V)$ (ou $O(2^n)$).


![Imagem Embutida 4](./imagens/For%C3%A7a%20Bruta%20-%20BackTracking/slide_13_img_4.png)

![Imagem Embutida 5](./imagens/For%C3%A7a%20Bruta%20-%20BackTracking/slide_13_img_5.png)

As imagens demonstram a árvore de estados com o teste de todas as possibilidades.


![Imagem Embutida 4](./imagens/For%C3%A7a%20Bruta%20-%20BackTracking/slide_14_img_4.png)

![Imagem Embutida 5](./imagens/For%C3%A7a%20Bruta%20-%20BackTracking/slide_14_img_5.png)


No problema de coloração com Backtracking, podemos eliminar as opções não viáveis logo de início (podando os ramos com marcação na árvore). O algoritmo pode terminar assim que encontrar uma solução válida, sem precisar visitar todos os nós da árvore.

### Exercício Avaliativo


Listar outros 3 problemas que podem ser resolvidos por backtracking. Para cada um:
1. Apresentar o que cada nó e/ou aresta da árvore representa.
2. Mostrar a árvore gerada para resolver um problema pequeno.
*(Nota: Este exercício é avaliativo).*

## Backtracking em Jogos


Algoritmos backtracking podem ser utilizados para resolver vários jogos, os quais são caracterizados pela necessidade de explorar uma faixa de possibilidades a cada ponto de escolha. O Backtracking simplifica os dados: a cada nível de recursão considera-se uma escolha, e o histórico de quais escolhas foram feitas é mantido diretamente na **pilha de execução**.

### Jogos Solitários


![Imagem Embutida 4](./imagens/For%C3%A7a%20Bruta%20-%20BackTracking/slide_17_img_4.png)

![Imagem Embutida 5](./imagens/For%C3%A7a%20Bruta%20-%20BackTracking/slide_17_img_5.jpeg)

Nesses jogos, o Backtracking testa todas as possibilidades até a vitória.
Exemplos: Labirinto, Torre de Hanoi, Sudoku, Resta 1, Arranjo, entre outros.

### Jogos de Duplas


Em jogos de duplas, o algoritmo backtracking é utilizado para gerar todas as possíveis jogadas do computador e da pessoa. O objetivo é seguir pelas jogadas que deixem o oponente com **menos opções**.


![Imagem Embutida 4](./imagens/For%C3%A7a%20Bruta%20-%20BackTracking/slide_19_img_4.jpeg)

Claude Shannon observou que a maioria dos jogos de 2 jogadores tem a mesma forma básica, onde cada nível da árvore representa a jogada de um dos jogadores.

### Exemplo: O Jogo Nim


![Imagem Embutida 4](./imagens/For%C3%A7a%20Bruta%20-%20BackTracking/slide_20_img_4.png)

O jogo *Nim* consiste numa pilha de moedas. Cada jogador pode pegar até 3 moedas em seu turno. Aquele que ficar com a última moeda perde.


![Imagem Embutida 4](./imagens/For%C3%A7a%20Bruta%20-%20BackTracking/slide_21_img_4.png)

**Exercício Prático:** 
Implemente um jogo *Nim* que permita ao jogador jogar contra o PC.
1. Analise a árvore de recursão, mostre o parâmetro e o retorno em cada nó.
2. Descubra como o computador sabe a melhor jogada a se fazer.
