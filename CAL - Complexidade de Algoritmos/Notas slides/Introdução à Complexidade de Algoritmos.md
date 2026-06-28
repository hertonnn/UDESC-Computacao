# Introdução à Complexidade de Algoritmos

## Conteúdo Programático

A disciplina abrange os seguintes tópicos fundamentais:
- Crescimento assintótico de funções.
- Somatórios.
- Análise de complexidade de algoritmos.
- Algoritmos iterativos e recursivos.
- Estratégias de Divisão e conquista.
- Algoritmos gulosos.
- Programação Dinâmica.
- Problemas tratáveis e intratáveis.
- Classes de problemas: P, NP, NP-Completo e NP-Difícil.
- Aproximações e Heurísticas.


## Definição de Algoritmo


Um algoritmo é, por definição, um conjunto de instruções bem definidas que especificam uma sequência específica de operações para cada entrada fornecida, terminando obrigatoriamente com uma saída.

Um algoritmo resolve um determinado problema quando, para qualquer entrada válida, ele é capaz de produzir uma saída correta. No entanto, o simples fato de um algoritmo resolver um problema matemático ou lógico não significa que ele seja aceitável ou viável na prática. Em cenários reais, o **espaço** (memória) e o **tempo** (processamento) requeridos são fatores de extrema importância para determinar sua viabilidade.

### Exemplo Prático de Eficiência

Um algoritmo considerado imediato (ou "ingênuo") pode estar muito longe de resolver o problema de forma eficiente, consumindo recursos excessivos em termos de tempo ou memória computacional.

![Exemplo de Caminhos 2](./imagens/Complexidade%20de%20Algoritmos-Intro/slide_4_img_4.jpeg)

## O Impacto do Poder Computacional


O rápido avanço da tecnologia e do hardware pode, inicialmente, parecer ofuscar a importância da análise da complexidade de tempo de um algoritmo. Poder-se-ia pensar que máquinas mais rápidas compensam o uso de algoritmos ineficientes. 

Porém, na prática, ocorre exatamente o contrário. Com máquinas mais poderosas, surgem demandas por problemas ainda maiores e mais complexos a serem resolvidos (como o processamento de volumes massivos de dados ou a execução de simulações físicas hiper-realistas). Portanto, a complexidade do problema e do algoritmo utilizado deve ser rigorosamente levada em consideração em qualquer projeto. Um problema difícil de ser resolvido do ponto de vista computacional pode atrasar significativamente a entrega de um projeto, independentemente do hardware utilizado.

## Revisão Matemática Aplicada a Algoritmos

Muitas vezes, a otimização de um algoritmo passa diretamente por uma abordagem matemática que evita processamento desnecessário.

Considere o seguinte problema básico: *Faça um algoritmo que, dado um número inteiro inicial, some-o aos $n$ números seguintes.*


Conhecendo alguns recursos simples da matemática, como fórmulas fechadas para séries e progressões, podemos melhorar os nossos algoritmos drasticamente, substituindo laços de repetição (loops, que crescem linearmente com a entrada) por cálculos algébricos diretos (que resolvem o problema em tempo constante, ou $O(1)$).

Por exemplo, a soma aritmética de uma sequência de termos pode ser calculada através do seguinte somatório:

$$ \sum_{i=0}^{n} a_i = \frac{(a_0 + a_n)(n + 1)}{2} $$


## Sistema de Avaliações

O formato de avaliação da disciplina é composto da seguinte maneira:
- **Prova 1:** 40% da Nota Final. *(O conteúdo da prova será similar ao conteúdo cobrado na Lista de Exercícios).*
- **Trabalho Final:** 35% da Nota Final.
- **Atividades Extras:** 25% da Nota Final. *(As atividades extras precisam ser entregues no prazo estabelecido pelo professor e atingir um nível de qualidade mínimo exigido).*


## Referências Bibliográficas


A bibliografia recomendada e utilizada como base para a disciplina inclui:
- Serpa, Matheus, S. et al. *Análise de Algoritmos*. Disponível em: Minha Biblioteca, Grupo A, 2021.
- Dasgupta, Sanjoy, et al. *Algoritmos*. Disponível em: Minha Biblioteca, Grupo A, 2009.
- Cormen, Thomas. *Algoritmos - Teoria e Prática*. Disponível em: Minha Biblioteca, (3ª edição). Grupo GEN, 2012.
