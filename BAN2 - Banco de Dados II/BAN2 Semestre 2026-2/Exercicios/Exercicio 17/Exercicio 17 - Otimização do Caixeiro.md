## UDESC – Universidade do Estado de Santa Catarina

### DCC – Departamento de Ciências da Computação

### Disciplina de Banco de Dados II (BAN-II)

#### Prof.: Fabiano Baldo, Dr. Eng.

## Exercício 17

### Otimização do Problema do Caixeiro Viajante

Descrição: Resolver o problema do Caixeiro Viajante usando a heurística construtiva do Vizinho Mais Próximo seguido de uma heurística de Refinamento Exchange/Swap:

1 - Ler arquivo de entrada contendo as cidades;

2 - Calcular matriz de distância Euclidiana;

3 - Implementar a heurística construtiva do Vizinho Mais Próximo;

4 - Implementar a heurística de refinamento Exchange/Swap usando como base a solução gerada no passo 3;

5 - Fazer testes com os arquivos de entrada disponíveis.

Linguagem de programação: Livre!


# Solução

Foi utilizado o [material da UFPR](https://docs.ufpr.br/~volmir/PO_II/A_7_TSP.pdf) sobre o Problema do Caixeiro Viajante.

Otimização usada foi a **Heurística de melhoria Algoritmo 2-opt**:

No algoritmo 2-opt, elimina-se 2 arestas não adjacentes, reconecta-as usando duas
outras arestas (formando um ciclo) e verifica-se se houve melhora. Este processo é
repetido para todos os pares de arestas. A melhor troca (o novo ciclo com menor
custo) é então realizada.

a) Remover 2 arestas da solução H obtendo uma solução H’.

b) Construir todas as soluções viáveis contendo H’.

c) Escolher a melhor soluções dentre as encontradas e guardar.

d) Escolher outro conjunto de 2 arestas ainda não selecionado e retornar ao
passo “a”, caso contrário, pare.



| Nome Arquivo | Custo Inicial | Custo otimizado |
| :--- | :--- | :--- |
| a280.tsp | 3148.11 | 2827.18 |
| berlin52.tsp | 8980.91 | 7990.15 |
| bier127.tsp | 135751.77 | 126508.11 |
