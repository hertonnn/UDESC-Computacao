# Algoritmos Gulosos


## Conceito de Algoritmos Gulosos

Os algoritmos gulosos ou gananciosos (*Greedy Algorithms*) escolhem a melhor opção local a cada nova escolha disponível. Ou seja, a cada iteração ou passo do processo, eles escolhem o caminho mais "apetitoso" (o ótimo local).

A cada escolha, o algoritmo toma a decisão que parece ser a ótima apenas naquele momento específico. A premissa central dessa abordagem é acreditar que o conjunto sucessivo das soluções ótimas locais levará, eventualmente, a uma solução ótima global.

## Estratégia Gulosa em Jogos


Num jogo como o xadrez, uma estratégia puramente gulosa para uma Inteligência Artificial seria muito fácil de vencer. Isso ocorre pois, sem a visão de longo prazo e sem o planejamento das jogadas futuras, é extremamente difícil gerar uma jogada verdadeiramente ótima global a cada passo, limitando-se a avaliar peças disponíveis para captura no instante atual.

No entanto, em um jogo como *Scrabble* (palavras cruzadas com vários jogadores), a estratégia gulosa de jogar a palavra que rende a maior pontuação imediatamente possível geralmente se prova como a melhor abordagem.

## Problema Clássico: Algoritmo do Troco Mínimo


Dado um valor $V$, o objetivo é retornar a quantidade mínima de notas e moedas que correspondam exatamente a esse valor $V$. Considera-se que temos quantidades infinitas de moedas e notas disponíveis para o troco.

Sistema monetário utilizado:
*   **Valores das moedas**: 0.01, 0.05, 0.10, 0.25, 0.50 e 1.00.
*   **Valores das notas**: 2.00, 5.00, 10.00, 20.00, 50.00, 100.00 e 200.00.

### Execução do Algoritmo do Troco (Abordagem Gulosa)

A lógica gulosa consiste em sempre tentar subtrair do montante restante o maior valor de nota ou moeda possível que não ultrapasse esse montante.


*   **Passo 1:** Valor inicial alvo: **187,00**. A maior nota possível é 100. Restante após utilizar uma nota de 100: **87,00**.


*   **Passo 2:** Restante atual: 87,00. A maior nota possível é 50. Restante após utilizar uma nota de 50: **37,00**.


*   **Passo 3:** Restante atual: 37,00. A maior nota possível é 20. Restante após utilizar uma nota de 20: **17,00**.


*   **Passo Final:** Restante atual: 17,00. O algoritmo continua selecionando (nota de 10, nota de 5, nota de 2) até o restante ser **0,00**.

## Limitações do Algoritmo Guloso: Ótimo Local vs Global


O Algoritmo Guloso funciona perfeitamente bem para o nosso sistema monetário atual, retornando a quantidade mínima de moedas (ótimo global). Mas isso não é uma regra geral para qualquer sistema.

Suponha um sistema monetário alternativo com moedas nos seguintes valores restritos: **1, 7 e 10**.

Para devolver um troco de **15**, o algoritmo guloso tomaria a seguinte decisão:
1. Pega a maior possível (10). Restam 5.
2. Como não pode pegar 7, pega 1 cinco vezes.
*   **Resultado Guloso:** Entrega 10, 1, 1, 1, 1, 1. (Ficou preso num **ótimo local**, totalizando 6 moedas).

Sendo que a distribuição mais eficiente possível seria:
*   **Resultado Ótimo Global:** Entrega 7, 7 e 1. (Totalizando apenas 3 moedas).

### Problemas de Otimização e Mínimos Locais


![Imagem Embutida 4](./imagens/Algoritmos%20Gulosos/slide_10_img_4.png)

Algoritmos Gulosos podem ser frequentemente utilizados como aproximações rápidas para resolver problemas de otimização complexos.
Entretanto, como visto no exemplo acima, eles correm o alto risco de "cair" num mínimo ou máximo local e não conseguir escapar para encontrar o ponto ótimo global. Em suma, o algoritmo retornará uma solução válida, mas não garante que seja a melhor solução (não é ótima).

### Aplicação: O Problema do Caixeiro Viajante


![Imagem Embutida 4](./imagens/Algoritmos%20Gulosos/slide_11_img_4.png)

Em problemas de alta complexidade fatorial, como o roteamento do Caixeiro Viajante (encontrar a menor rota fechada que visite todas as cidades), os algoritmos gulosos geralmente encontram soluções que são visivelmente subótimas se aplicados sem heurísticas extras.

### Aplicação: O Problema da Mochila


![Imagem Embutida 4](./imagens/Algoritmos%20Gulosos/slide_12_img_4.png)

No problema da mochila, o objetivo é carregar o maior número de itens possível (ou maximizar o valor dos itens) limitando-se pelo peso ou volume máximo suportado pela mochila. Dependendo da variação do problema (ex: Mochila Fracionária vs Mochila Booleana/0-1), a estratégia gulosa pode funcionar perfeitamente ou falhar e entregar um valor subótimo.

## A Importância da Modelagem de Problemas


![Imagem Embutida 4](./imagens/Algoritmos%20Gulosos/slide_13_img_4.png)

A forma como um problema é modelado pode impedir ou facilitar que abordagens simples (como um algoritmo guloso) sejam utilizadas. O projetista precisa sempre avaliar o problema original e tentar encontrar uma modelagem computacional mais simples, se ela existir.

**Exemplo: Navegação no Jogo Crab**

*   **Movimentação por pixel:**
    *   Tudo no ambiente é mapeado e navegável. O sistema só precisa considerar se houve colisões.
    *   Permite uma exploração livre e extremamente detalhada do espaço contínuo.
    *   A desvantagem é o altíssimo custo de processamento para calcular a movimentação e colisão a cada frame/pixel.
*   **Movimentação entre checkpoints (Grafos):**
    *   A movimentação se dá de forma discreta entre "quadrados" (nós) do cenário.
    *   A rota pode ser calculada com algoritmos otimizados somente verificando o menor caminho entre os nós estabelecidos. Pode-se seguir em linha reta (interpolar) apenas entre os nós que estão diretamente conectados.
    *   Esta modelagem reduz massivamente a complexidade, viabilizando o uso de algoritmos gulosos ou como A* para navegação eficiente.
