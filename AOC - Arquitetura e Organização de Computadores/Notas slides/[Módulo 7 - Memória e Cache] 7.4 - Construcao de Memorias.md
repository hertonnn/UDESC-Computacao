# Construção de Memórias

## Memória de Acesso Aleatório (RAM)

![Tipos de Memória](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.4%20-%20Construcao%20de%20Memorias/slide_1_img_1.png)

![Exemplo Memória](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.4%20-%20Construcao%20de%20Memorias/slide_1_img_2.png)

A Memória de Acesso Aleatório - *Random Access Memory* (RAM) permite o acesso direto de qualquer palavra na memória. Diferente de uma fita por exemplo, onde para acessar a palavra n, precisamos percorrer todas as n-1 posições.

Comumente chamamos a memória principal de nossos PCs de "memória RAM". Não é o termo ideal, já que a vasta maioria das memórias que usamos em nossos computadores é do tipo RAM.

### Static RAM (SRAM)

![Circuito SRAM Flip-Flop](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.4%20-%20Construcao%20de%20Memorias/slide_2_img_1.png)

![Circuito Interno SRAM 2](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.4%20-%20Construcao%20de%20Memorias/slide_2_img_2.png)

A Memória Estática de Acesso Aleatório (SRAM) utiliza portas lógicas para armazenar os bits (Flip-flops). Ela consegue manter os dados enquanto o circuito está alimentado.
Comumente utilizada na construção de memórias cache e registradores. Exemplo: Intel Core i9-9900K 16 MiB de Cache L3.

### Dynamic RAM (DRAM)

![Esquema DRAM Capacitor](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.4%20-%20Construcao%20de%20Memorias/slide_3_img_1.png)

A Memória Dinâmica de Acesso Aleatório (DRAM) armazena carga em capacitores. O capacitor pode ser interpretador como:
- 1 quando carregado
- 0 quando descarregado

Mantém os dados enquanto alimentada, porém:
- Capacitores perdem a carga com o tempo, e são necessárias recargas (*refresh*) periódicas (e.g., a cada 64 ms).
- Ler um capacitor remove sua carga.
- Perdemos o dado se não regravar após uma leitura.

A memória é denominada dinâmica por sua tendência em perder a carga em seus capacitores, mesmo com a memória continuamente energizada. A DRAM é comumente utilizada na memória principal dos PCs.

### SRAM Versus DRAM
- A SRAM comumente é mais rápida que a DRAM.
- A DRAM possui um circuito mais simples e menor, gerando memórias mais densas e baratas.

## Memórias Somente Leitura (ROM) e Variantes

A Memória Somente Leitura (ROM - *Read-Only Memory*) permite a leitura, mas não a escrita. É uma memória não volátil, ou seja, não precisa estar constantemente alimentada. A memória é construída com o dado de forma *hardwired* (gravado diretamente no hardware). Isso acarreta um elevado custo de fabricação inicial, independente de quantas memórias vamos construir:
- Precisamos programar as máquinas e criar máscaras para fabricar as memórias.
- Não há espaço para erro.

### Programmable ROM (PROM)

![Chip PROM/EPROM](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.4%20-%20Construcao%20de%20Memorias/slide_4_img_1.png)

A ROM Programável (PROM) é o mesmo que uma ROM, mas pode ser gravada uma vez. Comumente usamos equipamentos específicos que "queimam" os circuitos internos da memória para efetuar a gravação.

### Erasable Programmable Read-Only Memory (EPROM)
A EPROM é uma PROM "apagável". Pode ser lida ou escrita, mas antes de uma escrita precisa ser completamente apagada. Usamos radiação ultravioleta em uma janela de quartzo do chip por alguns minutos para realizar esse apagamento.

### Electrically Erasable Programmable Read-Only Memory (EEPROM)
A EEPROM é uma PROM "apagável por eletricidade". Podemos ler e escrever qualquer palavra individual nela. A escrita demora mais tempo que a leitura.

## Organização e Arranjo de Memórias

### Exemplo de Arranjo em Matriz

![Exemplo de Arranjo Matriz DRAM](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.4%20-%20Construcao%20de%20Memorias/slide_5_img_1.png)

![Matriz 2048x2048](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.4%20-%20Construcao%20de%20Memorias/slide_5_img_2.png)

As memórias DRAM (e ROM, EPROM, ...) são comumente arranjadas em matrizes. Considere uma DRAM de 16 Mib (2 MiB) onde a leitura/escrita é feita em conjuntos de 4 bits. No exemplo podemos ter uma matriz de 2048 x 2048, onde cada elemento armazena 4 bits (outros arranjos também são possíveis).

**Quantos bits são necessários para endereçar uma linha dessa matriz? E para as colunas?**
11 bits, pois 2¹¹ = 2048, ou melhor: lg 2048 = 11.

![Esquema Multiplexação de Endereços](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.4%20-%20Construcao%20de%20Memorias/slide_6_img_1.png)

![Sinais de Controle de Memória](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.4%20-%20Construcao%20de%20Memorias/slide_6_img_2.png)

![Esquema Detalhado de Matriz de Memória](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.4%20-%20Construcao%20de%20Memorias/slide_6_img_3.png)

Temos 11 linhas para o endereço, e não 22. Como? 
Enviando o endereço da linha, e depois o da coluna. São duas etapas que salvam pinos de endereço no chip. Para indicar se estamos passando o endereço de linha ou coluna, utilizamos os sinais:
- **RAS:** Row Address Select
- **CAS:** Column Address Select

Além disso, os sinais *Write Enable* (WE) e *Output Enable* (OE) indicam se os dados são para leitura ou escrita no endereço especificado.

## Transistores e Células de Memória Flash

![Esquema Transistor Floating Gate](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.4%20-%20Construcao%20de%20Memorias/slide_7_img_1.png)

![NAND Flash Arranjo](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.4%20-%20Construcao%20de%20Memorias/slide_7_img_2.png)

O microchip da Memória Flash é construído de forma que uma seção de memória é rapidamente apagada em um único "flash". Um dos arranjos mais comuns é o NAND flash:
- Comportamento similar a portas NAND.
- Outras configurações, como NOR flash, também são possíveis.

A memória flash utiliza transistores com *floating gate* (porta flutuante).
- Tipicamente são utilizados 32 ou 64 transistores em série (para armazenar 32 ou 64 bits).
- Os transistores em uma mesma linha não podem ser lidos em paralelo.
- Para apagar os transistores, a linha inteira (com 32 ou 64) é apagada.

### Operação da Flash NAND

![Operação Flash NAND 1](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.4%20-%20Construcao%20de%20Memorias/slide_8_img_1.png)

![Operação Flash NAND 2](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.4%20-%20Construcao%20de%20Memorias/slide_8_img_2.png)

No exemplo de arranjo com 8 transistores, o *Bit line* lê "0 lógico" quando todos os transistores possibilitam a passagem de corrente (comportamento de uma porta NAND).

Para ler o bit na *Word line* 1:
- Mantemos as (outras) *Word lines* 0, 2, 3,... 7 com uma tensão positiva, para que a corrente possa fluir.
- Mantemos a *Word line* 1 com 0 volts.
- Agora a corrente vai fluir ou não dependendo do estado do *floating gate* da *Word line* 1.
- Como todos os transistores permitem a passagem de corrente, exceto o 1 que depende do estado do *floating gate*, a linha de bit vai ter 0 ou 1 dependendo do estado da *Word line* 1.

Múltiplas linhas são unidas para formar as *words*.

A explicação sobre a Flash NAND é apenas uma simplificação sobre o funcionamento real da memória flash. Operações para apagar e escrever são um pouco mais complexas e o *floating gate* se desgasta com o tempo. Com nossa tecnologia atual, as memórias flash comumente têm uma durabilidade limitada.

![Pendrive e SSD](./imagens/%5BM%C3%B3dulo%207%20-%20Mem%C3%B3ria%20e%20Cache%5D%207.4%20-%20Construcao%20de%20Memorias/slide_9_img_1.png)

Memórias flash são comumente utilizadas na construção de pendrives (*flashdrives*) e Dispositivos de Estado Sólido (*Solid-State Drive* – SSD). Em ambos dispositivos o arranjo NAND é o mais comum.

## Exercícios e Referências

### Exercícios
1. Nossos PCs usam uma combinação de SRAM, DRAM e Discos Rígidos/SSDs como memórias. Microcontroladores utilizam outra combinação. Pesquise sobre os microcontroladores PIC (fabricados pela Microchip) e verifique quais tecnologias de memória são utilizadas para armazenar o programa, memória principal e armazenamento permanente. Quais vantagens e desvantagens?
2. Quais das memórias discutidas são RAM? Quais não são?
3. Pesquise sobre o funcionamento básico de Discos Rígidos (HDs) convencionais.

### Referências
- Stallings, W. Arquitetura e organização de computadores. 10ª ed. São Paulo: Pearson Education do Brasil, 2016.
- Micheloni, R.; Crippa, L.; Marelli, A. Inside NAND Flash Memories. 2010.
- Tanenbaum, A. Bos, H. Sistemas Operacionais Modernos. 4ª ed. 2016.
- Novotný, R.; Kadlec, J.; Kuchta, R. Nand flash memory organization and operations. Journal of Information Technology & Software Engineering. 2015.
- Ronald Tocci, Neal Widmer, Greg Moss. Digital Systems. 12 ed. Pearson Education. 2016.
