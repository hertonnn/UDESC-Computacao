# LRU, Caches Multinível e Coerência de Cache

## Revisão e Exemplos Iniciais

### Exemplo 1: Cache Associativa de 2 Vias
Considerando uma cache associativa com:
- 2 vias
- Blocos de 4 bytes
- Capacidade de 64 bytes

**Quantos blocos no total?**
64 / 4 = 16 blocos

**Quantos conjuntos no total?**
16 / 2 = 8 conjuntos

**Quantos bits para offset, endereço do conjunto e tag (considerando endereçamentos de 8 e 16 bits)?**
- lg 4 = 2 bits para offset
- lg 8 = 3 bits para endereço do conjunto
- 8 - 2 - 3 = 3 bits para tag com endereçamentos de 8 bits
- 16 - 2 - 3 = 11 bits para tag com endereçamentos de 16 bits

### Exemplo 2: Cache Associativa de 4 Vias
Considerando uma cache associativa com:
- 4 vias
- Blocos de 4 bytes
- Capacidade de 64 bytes

**Quantos blocos no total?**
64 / 4 = 16 blocos

**Quantos conjuntos no total?**
16 / 4 = 4 conjuntos

**Quantos bits para offset, endereço do conjunto e tag (considerando endereçamentos de 8 e 16 bits)?**
- lg 4 = 2 bits para offset
- lg 4 = 2 bits para endereço do conjunto
- 8 - 2 - 2 = 4 bits para tag com endereçamentos de 8 bits
- 16 - 2 - 2 = 12 bits para tag com endereçamentos de 16 bits

### Exemplo 3: Mapeamento de Byte em Cache de 2 Vias
![Mapeamento Exemplo 3](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.3%20-%20LRU%20Caches%20multinivel%20e%20Coerencia%20de%20Cache/slide_2_img_1.png)

![Resolução Exemplo 3](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.3%20-%20LRU%20Caches%20multinivel%20e%20Coerencia%20de%20Cache/slide_2_img_2.png)

Considerando uma cache associativa com:
- 2 vias
- Blocos de 4 bytes
- Cache com capacidade para armazenar 8 blocos no total

**Qual a capacidade para dados?**
8 × 4 = 32 bytes de capacidade para dados.

**Onde o byte no endereço 0000 1001₂ pode ser mapeado?**

*(Referencie as imagens acima para ilustrar o processo de mapeamento discutido no Exemplo 3, mostrando a alocação e escolha dos blocos a serem substituídos)*

## Estratégias de Substituição de Blocos

### Qual Bloco Substituir no Caso de um Miss?
No caso de um *miss*, se todos os blocos do conjunto estão ocupados, precisamos substituir um bloco. A questão central é: qual bloco?

Poderíamos selecionar aleatoriamente. Essa abordagem funciona, mas pode não ser uma boa ideia. Se dermos azar, podemos remover um bloco que está sendo usado o tempo todo na nossa cache.

Poderíamos pensar em lógicas sofisticadas para isso: bloco mais distante dos seus vizinhos, menos acessado, mais distante da instrução sendo executada, ou uma junção de todas essas métricas. Isso pode nos levar a decisões melhores. 

**Problemas?**
Isso vai custar muito tempo e hardware para tomar essa decisão. Precisamos então de uma solução que tenha um bom custo x benefício, que seja pelo menos melhor que uma seleção desinformada, e que custe pouco tempo e hardware.

### Algoritmo LRU: Least Recently Used
![LRU Bit de Uso](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.3%20-%20LRU%20Caches%20multinivel%20e%20Coerencia%20de%20Cache/slide_4_img_1.png)

LRU significa *Least recently used* (usado menos recentemente). A ideia é remover o bloco que teve o acesso mais antigo. É um esquema comumente encontrado em nossas CPUs.

No esquema de uma cache associativa de 2 vias, é relativamente simples de se implementar. 
**Exemplo:**
- Podemos manter um "bit de uso" em cada bloco do conjunto da cache.
- Toda vez que um bloco do conjunto é acessado, seu bit de uso é "setado" (ligado/1).
- O bit de uso do outro bloco é "resetado" (desligado/0).

Com os bits de uso em uma cache associativa de 2 vias com capacidade para 8 blocos, se precisarmos substituir um bloco do conjunto 1, uma escolha razoável é o segundo bloco do conjunto, pois ele possui o bit que indica que foi acessado menos recentemente.

Obviamente, seja qual a estratégia que implementarmos, não podemos garantir que efetuamos a melhor escolha. Não podemos prever o futuro. Mas técnicas mais informadas tendem a diminuir a chance de tomar uma decisão ruim.

### LRU para Caches com Mais Vias
Em uma cache associativa de 2 vias podemos manter um bit para cada bloco do conjunto. Mas e como fazer para uma cache associativa de 4 vias? 8 vias? 12 vias?

Para um número suficientemente grande de vias, as coisas se complicam. Precisamos manter muitos bits, e técnicas de atualização mais complicadas para saber quem é o bloco acessado menos recentemente no conjunto. Por isso, mesmo caches simples com apenas 4 vias comumente implementam alguma aproximação do LRU.

**Aproximação simples para o LRU para uma cache associativa de n vias, onde n > 2:**
- Manter um bit de uso para cada bloco.
- Quando um bloco é acessado:
  - O seu bit de uso é setado.
  - Os bits de uso de todos os demais blocos do conjunto são resetados.
- Com isso, sabemos qual o bloco usado mais recentemente.
  - Mas não sabemos exatamente qual o bloco usado menos recentemente.
  - Sabemos apenas que os demais não são a pior escolha possível.
  - Nesse caso podemos escolher aleatoriamente entre esses blocos.

Existem também técnicas mais sofisticadas (mais caras e mais complexas):
- Manter uma estrutura de árvore para decidir qual o bloco mais antigo.
- Utiliza mais bits, mas leva a uma aproximação melhor do LRU.

![Gráfico de Miss Rate vs Cache Size LRU e Random](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.3%20-%20LRU%20Caches%20multinivel%20e%20Coerencia%20de%20Cache/slide_6_img_1.png)

![Gráfico Associatividade LRU](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.3%20-%20LRU%20Caches%20multinivel%20e%20Coerencia%20de%20Cache/slide_6_img_2.png)

**LRU para associatividades "grandes"**
Quando o nível de associatividade e o tamanho da cache são grandes o suficiente, o desempenho do LRU se aproxima de uma escolha aleatória. Nesses casos, muitas vezes não vale a pena o custo de complexidade de se implementar um LRU, e uma escolha aleatória se torna um melhor custo x benefício.

## Caches Multinível
Processadores atuais utilizam múltiplos níveis de cache.

![Estrutura de Caches Multinível](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.3%20-%20LRU%20Caches%20multinivel%20e%20Coerencia%20de%20Cache/slide_7_img_1.png)

**Níveis mais altos (L1, L2...), mais próximos da CPU:**
- Focam na redução do tempo de acesso e redução do custo do *miss* (*miss penalty*).
- Geralmente de acesso exclusivo para cada núcleo.
- Comumente segmentadas entre cache de instrução e cache de dados. (Arquitetura Harvard).
- São caches menores.
- Como alcançam esse foco?
  - Para reduzir o custo do *miss*: Reduzir o tamanho do bloco.
  - Para reduzir o tempo de acesso: Reduzir associatividade; utilizar caches não bloqueantes (ex: enquanto a cache de dados gera um *miss*, a cache de instruções pode continuar operando); a cache fica fisicamente mais próxima do núcleo; caches individuais por núcleo ou compartilhadas entre poucos núcleos.

**Níveis mais baixos (L3, etc...), mais distantes da CPU:**
- Focam na redução da probabilidade de *miss*.
- São caches maiores.
- Comumente compartilhadas entre os múltiplos núcleos.
  - Evitar dados duplicados entre núcleos para otimizar o uso do espaço na cache.
- Como alcançam esse foco?
  - Maior associatividade (visando localidade temporal).
  - Tamanhos de bloco maiores (visando localidade espacial).
  - Caches maiores.
  - Cache compartilhadas entre múltiplos núcleos.
  - Contar com o compilador e com o programador para organizarem as instruções corretamente.

### Exemplo de Hierarquia: Core i7-4960X
![Die do Core i7-4960X](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.3%20-%20LRU%20Caches%20multinivel%20e%20Coerencia%20de%20Cache/slide_8_img_1.png)

![Especificações de Cache Core i7](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.3%20-%20LRU%20Caches%20multinivel%20e%20Coerencia%20de%20Cache/slide_8_img_2.png)

O exemplo clássico demonstra:
- Em caso de *miss* na L1, faz a carga a partir da L2.
- Em caso de *miss* na L2, faz a carga a partir da L3.
- Sempre de forma hierárquica, sem pular níveis.

## Problemas de Coerência de Cache

CPUs modernas geram problemas modernos.
Considere uma CPU de dois núcleos (cores):
- Uma cache L1 exclusiva para cada núcleo.
- Uma cache L2 compartilhada entre os núcleos.
- Caches com política *write-back*.
  - **Write-Through:** Sempre propagar escritas para os níveis mais baixos de memória.
  - **Write-back:** O dado é atualizado nos níveis mais baixos apenas quando o dado na cache é substituído.

Como essas CPUs podem ver versões diferentes de um mesmo dado?
1. A CPU (Core) 1 solicita um dado da L1.
2. L1 (do Core 1) não têm o dado (*miss*) e solicita da L2.
3. O dado é copiado da L2 para a L1 da CPU 1.
4. A CPU 1 modifica esse dado.
   - O dado é escrito em sua L1, mas não na L2.
   - Lembre! Write-back: o dado só vai ser atualizado no outro nível quando o bloco for substituído.
5. A CPU (Core) 2 solicita o mesmo dado da sua L1.
   - L1 (do Core 2) não tem o dado.
   - O dado é copiado da L2 para a L1 da CPU 2.
   - O dado da L2 está desatualizado!

### Protocolo de Snooping para Resolução
Como resolver a coerência de cache?
Usar *write-through* não é eficiente, então utiliza-se o Protocolo de Snooping, popular nos processadores atuais.

Quando uma CPU escreve em um bloco da sua cache, envia um sinal para todas as demais CPUs via *broadcast* para "sujar a cache".
- As demais CPUs e níveis de cache desligam o bit de validade do bloco, caso elas possuam esse mesmo bloco.
- Se duas CPUs tentam escrever ao mesmo tempo, uma delas "ganha a corrida" e envia o *broadcast* antes que a outra.

Quando as outras CPUs precisarem do dado, o bit de validade estará desligado. Isso efetivamente força que a CPU faça uma nova cópia desse dado.
Agora a cópia é mais complexa: pode vir da cache do vizinho, ou podemos forçar que a CPU que possui a cópia mais recente escreva no nível de baixo para que a CPU vizinha possa enxergar esse dado. Isso depende de como implementamos o hardware do processador.

## Exercício de Falso Compartilhamento

Considere que temos blocos de 4 palavras e o bloco a seguir na Memória Principal (MP):

| Endereço na MP | Dado |
| :--- | :--- |
| `0000 0000₂` | Dado 1 |
| `0000 0001₂` | Dado 2 |
| `0000 0010₂` | Dado 3 |
| `0000 0011₂` | Dado 4 |

Se fizermos um programa que executa em paralelo em duas CPUs com a seguinte lógica:

**CPU 1:**
```assembly
Carregue 0000 0000 para reg1
Carregue 0000 0001 para reg2
reg3 = reg1 + reg2
salve reg3 em 0000 0000
```

**CPU 2:**
```assembly
Carregue 0000 0010 para reg1
Carregue 0000 0011 para reg2
reg3 = reg1 + reg2
salve reg3 em 0000 0010
```

**Perguntas:**
1. Esses programas compartilham algum dado em algum momento?
2. Há risco de uma CPU invalidar os dados da outra?
3. Esse programa "paralelo" executa 2x mais rápido do que se fizéssemos tudo sequencialmente em uma única CPU?
4. Para reduzir a probabilidade de falso compartilhamento, o que podemos fazer com o tamanho de blocos na cache?

**Respostas:**
1 e 2. Os programas **não** compartilham dados (enquanto a CPU 1 está trabalhando com os dados 1 e 2, a CPU 2 trabalha com os dados 3 e 4). No entanto, note que todos os dados estão no **mesmo bloco**. Quando invalidamos algo na cache (via snooping, por exemplo), invalidamos o bloco inteiro, e não só um pedaço do bloco. Esse problema é chamado de **falso compartilhamento**.
3. Esse programa provavelmente vai executar mais lento do que se fizéssemos uma versão que utiliza uma única CPU, pois na versão atual, uma CPU atrapalha a outra devido à constante invalidação do bloco compartilhado entre elas.
4. Para reduzir a probabilidade de falso compartilhamento, podemos reduzir o tamanho dos blocos. Blocos menores reduzem a chance de compartilhamento de variáveis (dados independentes mapeando para a mesma linha de cache). Quando você criar um programa, deve também levar em consideração o tamanho dos blocos para evitar essa situação.

## Custo Energético e Referências
![Gráficos de Consumo de Energia MIPS vs ARM](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.3%20-%20LRU%20Caches%20multinivel%20e%20Coerencia%20de%20Cache/slide_11_img_1.png)

![Gráfico Adicional de Energia](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.3%20-%20LRU%20Caches%20multinivel%20e%20Coerencia%20de%20Cache/slide_11_img_2.png)

**Referências:**
- D. Patterson; J. Henessy. Organização e Projeto de Computadores: a Interface Hardware/Software. 5ª Edição. Elsevier Brasil, 2017.
- J. Henessy; D. Patterson. Computer Architecture: A Quantitative Approach. 6ª Edição. 2019.
- STALLINGS, William. Arquitetura e organização de computadores. 10. ed. São Paulo: Pearson Education do Brasil, 2018.
