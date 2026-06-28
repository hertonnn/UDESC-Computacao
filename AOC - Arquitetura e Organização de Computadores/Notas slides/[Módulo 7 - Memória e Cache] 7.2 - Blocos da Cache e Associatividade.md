# [Módulo 7 - Memória e Cache] 7.2 - Blocos da Cache e Associatividade

## Cache com Blocos de Uma Palavra

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_2_img_1.png)

Ao montarmos uma cache com mapeamento direto, cada posição (bloco) da cache armazena exatamente uma palavra. Nossa cache se beneficia da **Localidade Temporal**: carregamos o dado para a cache, e se no futuro (próximo) ele for necessário novamente, ele já está na cache (desde que ninguém o tire de lá).

Quanto à **Localidade Espacial**, ao carregarmos o dado em um endereço, é provável que seus vizinhos também sejam úteis. No entanto, isso não é explorado na cache com mapeamento de palavras. A única vantagem da localidade espacial, nesse caso, é que vizinhos não concorrem pela mesma posição na cache. Como podemos tirar vantagem da localidade espacial?

## Mapeamento por Blocos

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_4_img_1.png)

Vamos dividir a memória em blocos de $n$ bytes. Essa divisão vai ser utilizada para realizar o mapeamento da cache. Um exemplo: considerando que cada endereço da memória suporta 1 byte, e cada bloco possui 8 bytes. Como obter o endereço de bloco?

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_5_img_1.png)

O endereço do bloco pode ser obtido por meio da divisão inteira:
$$\text{Bloco} = \frac{\text{Endereço}}{\text{Tamanho do Bloco}}$$
Em binário é ainda mais fácil se tudo for múltiplo de 2: basta usarmos os bits certos do endereço.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_6_img_1.png)

Quando o processador solicita o dado em determinado endereço, ele verifica o endereço do bloco. O processador utiliza os bits mais baixos do bloco para procurar na cache, enquanto os bits mais altos do bloco são comparados com a *tag*.

### Comportamento em Caso de Hit

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_7_img_1.png)

Em caso de *hit*, o bloco está na cache. Mas o processador não solicitou um bloco inteiro, mas sim o dado em um endereço de memória específico. 

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_8_img_1.png)

Os bits que foram descartados para se obter o endereço do bloco podem ser usados para se obter um "deslocamento dentro do bloco" (o chamado *Offset*).

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_9_img_1.png)

Por exemplo, se a CPU solicita $0000 1011_2$:
- O dado está no bloco $00001_2$
- Deslocado $011_2$ dentro desse bloco.

### Comportamento em Caso de Miss

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_10_img_1.png)

Em caso de *miss*, buscamos todo o bloco da memória e carregamos para a cache.

## Vantagens e Desvantagens do Tamanho do Bloco

Aumentar o tamanho do bloco possui algumas consequências:

**Vantagens:**
- Aumentamos a localidade espacial: carregamos o dado e seus vizinhos em caso de *miss*.

**Desvantagens:**
- Aumentamos a competição na cache, pois o tamanho total da cache não muda. 
  - O pior caso seria uma cache de apenas um bloco. Se precisarmos de qualquer dado que esteja fora desse bloco, precisamos jogar toda a cache fora para carregar um bloco completo que está em outro lugar.
  - Isso diminui a localidade temporal: é mais provável que um dado que foi utilizado no passado, mas que está "longe" dos últimos carregados, seja substituído.
- A penalidade de falta (*miss penalty*) se torna maior, já que precisamos carregar mais dados da memória principal.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_15_img_1.png)

Precisamos, portanto, de um equilíbrio: blocos muito pequenos diminuem a localidade espacial, enquanto blocos muito grandes diminuem a localidade temporal.

## Leituras versus Escritas

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_16_img_1.png)

Ler um dado com a memória cache é relativamente simples:
- Em caso de *hit*, lemos o dado.
- Em caso de *miss*, carregamos o dado para a cache (enquanto isso, o pipeline pode entrar em *stall*) e depois lemos o dado.

Mas, em caso de escritas, as coisas não são tão simples. Por exemplo, na instrução `sw $t0, 4($t1)`, qual a dificuldade considerando os múltiplos níveis de memória?

### Tratando Escritas na Memória

Quando uma instrução escrever algo, vamos escrever apenas na cache (lembre-se que, numa hierarquia real, a CPU se comunica apenas com o nível de memória mais alto). 
Agora, para o mesmo endereço de memória, temos dois dados diferentes:
- Um na cache (atualizado).
- Um na memória de nível mais baixo (desatualizado).
A memória fica, dessa forma, inconsistente.

Para contornar isso, existem algumas estratégias:

#### Write-Through

Uma maneira simples de corrigir a inconsistência é sempre propagar as escritas para os níveis mais baixos de memória. Esse esquema é chamado de **Write-Through**.

Entretanto, esse esquema apresenta problemas: nossa cache, que serviria para acelerar acessos, acabaria penalizada, pois toda escrita deve ser propagada para os níveis mais lentos. Precisamos esperar os níveis mais lentos terminarem a operação, o que acaba sendo o mesmo (ou pior) que não ter uma cache. Como podemos melhorar isso?

#### Write-Back

No esquema **Write-Back**, escrevemos apenas na cache. O dado é atualizado nos níveis mais baixos de memória *apenas quando o dado na cache é substituído*.

Esse método é utilizado na maioria das CPUs atuais. Em alguns cenários, esquemas *write-through* podem ser mais eficientes. Existem ainda outros métodos, como o *no write allocate* (que escreve na memória, mas não na cache). A CPU comumente utiliza *write-back*, mas deixa o Sistema Operacional modificar o sistema de escrita de setores da memória específicos quando for conveniente.

O *Write-Back* é mais complexo de tratar. Pode se tornar um pesadelo especialmente considerando máquinas com múltiplas CPUs, onde cada CPU tem uma cópia do dado em sua própria cache (ex.: L1). Se outra CPU requisita o mesmo dado e simplesmente o carregar da memória, estaremos carregando uma versão desatualizada!

## Associatividade da Cache

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_22_img_1.png)

Na cache diretamente mapeada, cada bloco da memória pode ser "encaixado" em apenas uma posição na cache. Se essa posição já estiver ocupada, precisamos substituir seu conteúdo, mesmo que hajam várias outras posições livres na cache que poderíamos utilizar (isso se chama *colisão de endereço*). A solução para isso é a associatividade da cache.

### Cache Totalmente Associativa

Uma cache totalmente associativa pode carregar um bloco da memória para **qualquer bloco livre** da cache. Se a cache estiver totalmente cheia, podemos escolher o bloco "menos útil" para substituir.

**Vantagens:**
- Redução de *misses*: Maior flexibilidade, podendo escolher os blocos menos úteis para substituir na cache.

**Desvantagens:**
- Quando a CPU solicita um endereço, precisamos procurar na cache toda, pois o endereço não vai para um bloco específico da cache.
- Uma abordagem comum é colocar comparadores paralelos no hardware, o que implica um maior custo de energia, espaço e complexidade. Mesmo assim, perde-se um pouco de tempo.

### Cache Associativa por Conjunto

A cache associativa por conjunto é um meio termo entre o modelo totalmente associativo e o diretamente mapeado. A cache é separada em conjuntos, onde cada conjunto suporta até $n$ blocos (formando uma cache associativa de $n$ vias).

Os blocos da memória são mapeados para os conjuntos: o bloco da memória pode estar dentro de *qualquer* bloco do conjunto. Quando a CPU precisa de um dado no endereço $X$, o conjunto que precisa ser pesquisado é fixo; agora, é necessário pesquisar apenas em todos os blocos do respectivo conjunto.

#### Exemplos de Associatividade

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_26_img_1.png)

O diagrama mostra as associatividades possíveis em uma cache de 8 blocos: Diretamente Mapeada, Associativa de 2 Vias, Associativa de 4 Vias e Totalmente Associativa.

#### Exemplo Passo a Passo

Temos os seguintes parâmetros:
- Blocos de 4 bytes
- Cache associativa de 2 vias
- Cache com capacidade para armazenar 8 blocos no total ($8 \times 4 = 32$ bytes de capacidade para dados)

**Pergunta:** Onde o byte no endereço $0000 1001_2$ pode ser mapeado?

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_28_img_1.png)
![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_28_img_2.png)

1. Sendo o bloco de 4 bytes, os 2 bits menos significativos são o **offset**.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_29_img_1.png)
![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_29_img_2.png)

2. Tendo 8 blocos e 2 vias, a cache possui **4 conjuntos**. Isso exige 2 bits para o endereço do conjunto na cache.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_30_img_1.png)
![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_30_img_2.png)

3. O byte requisitado está no bloco $000010_2$. Separando o endereço:
   - 2 bits de offset
   - 6 bits de endereço do bloco, sendo divididos em:
     - 2 bits de mapeamento para o endereço do conjunto
     - 4 bits para a Tag

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_31_img_1.png)
![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_31_img_2.png)

4. Como temos 4 conjuntos e precisamos de 2 bits para os endereçar, olhamos para os 2 bits menos significativos do bloco (que no nosso endereço são $10$). Assim, sabemos que o dado está no **conjunto $10_2$**.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_32_img_1.png)
![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_32_img_2.png)

5. O mapeamento é feito para *algum dos blocos* do conjunto $10_2$ (por exemplo, o segundo bloco desse conjunto).

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_33_img_1.png)
![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_33_img_2.png)

6. Também necessitamos do **bit verificador** (Valid Bit).

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_34_img_1.png)
![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_34_img_2.png)

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_35_img_1.png)

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_36_img_1.png)

*(O ganho obtido no esquema associativo reflete as melhoras em miss rate em função da diminuição de conflitos na cache.)*

## Endereçamento com Associatividade

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_37_img_1.png)

Considere que a memória principal é endereçada utilizando $j$ bits. Ao solicitar um endereço de memória:
- Com blocos de tamanho $k$ (número de endereços por bloco), os últimos $\lg k$ bits são utilizados para se descobrir o deslocamento no bloco (*offset*).
- Tendo $n$ conjuntos na memória, $\lg n$ bits após os bits de deslocamento (*offset*) são utilizados para se descobrir o conjunto da cache (Índice na cache).
- Os demais bits fazem parte do campo Tag.

### Exemplo em Máquina de 64 bits

Considere uma máquina onde a memória é endereçada utilizando 64 bits. Considere ainda blocos de tamanho 16, e uma cache associativa de 4 vias com 8 conjuntos.
**Pergunta:** Quais e quantos bits são utilizados para o offset, o conjunto da cache, e a Tag?

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_39_img_1.png)

**Respostas:**
- $\lg 16 = 4$ bits para o *offset*.
- Tendo 8 conjuntos, $\lg 8 = 3$ bits para o índice na cache (conjunto).
- Como a memória é de 64 bits, temos $64 - 4 - 3 = 57$ bits dedicados para a Tag. 

## Detalhes da Cache Associativa de $n$ Vias

Quando o processador solicita um endereço $X$:
- Os bits que representam o índice em $X$ são usados para encontrar o conjunto.
- Os campos *tag* de todos os blocos do conjunto são analisados para verificar em qual bloco do conjunto o dado se encontra.
  - Essa é uma busca em paralelo para economizar tempo.
  - É necessário também verificar os bits de validade de cada bloco.
  - Se a busca não encontrar o dado em nenhum bloco, ocorre um *miss*.
- Em caso de *hit*, o campo de *offset* de $X$ é usado para se obter o deslocamento dentro do bloco.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.2%20-%20Blocos%20da%20Cache%20e%20Associatividade/slide_41_img_1.png)

### Tempo e Hardware Extras

Os comparadores e multiplexadores da cache associativa tomam tempo extra. Em uma cache diretamente mapeada, podemos nos livrar de pelo menos o multiplexador e a porta OR que verifica o *hit*.

A cache associativa de $n$ vias também precisa de hardware extra. No exemplo de 4 vias, precisamos de 4 comparadores em paralelo. Para $n$ vias, precisamos de $n$ comparadores e também de um multiplexador mais complexo. Menor associatividade significa menos hardware, o que também pode a tornar um pouco mais rápida (por exemplo, multiplexadores mais simples). No entanto, aumentamos os *misses*.

## Exercícios

1. Considere três caches, todas contendo 4 blocos, que comportam uma palavra cada. Considere ainda que uma cache é totalmente associativa, outra é associativa de 2 vias, e outra diretamente mapeada. Assumindo que as caches estão inicialmente vazias, quantos *misses* geramos em cada uma delas se requisitarmos os seguintes endereços (nesta ordem): $0000000_2$, $0000100_2$, $0000000_2$, $0000011_2$, e $0000100_2$.
2. Considerando uma estrutura de dados baseada em *arrays* e outra baseada em listas encadeadas, associando ainda sua resposta com os conceitos de cache, discuta sobre:
   - Qual estrutura é mais eficiente quando analisamos a quantidade de memória principal ocupada?
   - Qual das estruturas é mais "rápida"?
3. Execute o comando `likwid-topology -c -g` em seu computador e verifique o tamanho, as associatividades e o número de conjuntos (*sets*) nos diferentes níveis de memória cache de seu computador.

## Referências

- D. Patterson; J. Henessy. Organização e Projeto de Computadores: Interface Hardware/Software. 5ª Edição. Elsevier Brasil, 2017.
- J. Henessy; D. Patterson. Arquitetura de computadores: Uma abordagem quantitativa. 6ª Edição. 2017.
- STALLINGS, William. Arquitetura e organização de computadores. 8. ed. São Paulo: Pearson Education do Brasil, 2010.
