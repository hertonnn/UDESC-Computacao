# Módulo 5 - MIPS e Assembly
## 5.1 - Conjuntos de Instruções e Linguagem de Máquina
Para nos comunicarmos com o processador, precisamos falar a sua língua. Alguns exemplos de conjuntos de instruções incluem o x86 e o AMD64 (x64) presentes nos computadores pessoais, o ARM utilizado em smartphones, e o MIPS ou o PIC instruction SET, que são comuns em microcontroladores. O conjunto de instruções está diretamente relacionado com a forma como o hardware é construído, pois ele define como o hardware interpreta as instruções, o quão complexa é essa interpretação, a quantidade de instruções disponíveis para o programador e como essas instruções são armazenadas e solicitadas da memória.

### O Arquitetura MIPS32
Neste material, focaremos no MIPS de 32 bits (MIPS32), que é amplamente discutido na obra de Patterson e Henessy (2014). MIPS significa *Microprocessor without Interlocked Pipeline Stages*. Essa arquitetura foi desenvolvida por vários pesquisadores, incluindo Patterson e Henessy, que inclusive ganharam o Turing Award de 2017 por suas contribuições. As ideias do MIPS criadas na década de 1980 possibilitaram a criação de processadores extremamente eficientes, como os encontrados nos smartphones modernos. Hoje em dia, diversos processadores ainda utilizam a arquitetura MIPS atual. O conjunto de instruções do MIPS é relativamente simples, o que significa que aprender essa arquitetura tornará a migração para outros conjuntos de instruções uma tarefa quase fácil.

### Introdução aos Registradores
![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.1%20-%20Conjuntos%20de%20Instrucoes%20MIPS%20e%20Registradores/slide_2_img_1.png)

A grande maioria das arquiteturas modernas, como x86-64, MIPS e ARM, operam exclusivamente dentro da Unidade Central de Processamento (CPU). Para que isso ocorra, precisamos carregar os dados diretamente para os registradores da CPU. Os registradores são pequenas porções de memória localizadas na própria CPU que utilizamos para realizar as operações matemáticas e lógicas. Esses registradores são visíveis ao programador, pelo menos quando estamos programando em baixo nível (Assembly). Vale ressaltar que também existem registradores internos que não são visíveis ou acessíveis ao programador. Os registradores geralmente são construídos utilizando flip-flops. O diagrama acima exibe um exemplo de um Circuito Integrado construído com 8 flip-flops, o que forma uma memória capaz de armazenar 8 bits (baseado em Tanenbaum, 2007).

### Características dos Registradores
Os registradores representam os dispositivos de memória mais rápidos que estão disponíveis em todo o computador. No entanto, enquanto temos uma abundância relativa de memória principal (RAM), os registradores são recursos muito escassos. Na arquitetura MIPS, por exemplo, contamos com apenas 32 registradores, onde cada um possui 32 bits de tamanho. Para efeito de comparação, um processador x86 clássico possui apenas 8 registradores de uso geral disponíveis para nossos programas, enquanto a versão de 64 bits (x86-64) expande esse número para 16 registradores. Microcontroladores como o PIC 16F62 possuem apenas um único registrador de uso geral, conhecido como registrador W. Além disso, cada registrador na arquitetura precisa ter um endereço específico. Sabendo que o MIPS possui 32 registradores, podemos calcular quantos bits são necessários para endereçar todos eles.

### Endereçamento e Nomenclatura em Assembly
![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.1%20-%20Conjuntos%20de%20Instrucoes%20MIPS%20e%20Registradores/slide_3_img_1.png)

Para endereçar os 32 registradores do MIPS, são necessários exatamente 5 bits, pois 2 elevado a 5 é igual a 32. Inicialmente, o foco será nos registradores de uso geral que vão do número 8 ao 15 (conhecidos como registradores não salvos temporários) e do número 16 ao 23 (conhecidos como registradores salvos). A máquina física entende exclusivamente zeros e uns, ou seja, a Linguagem de Máquina. É muito difícil para um humano enxergar que o valor binário `10001` em uma instrução se refere ao registrador de número 17. Por esse motivo, nós programamos em linguagem de montagem, que é o Assembly. No Assembly, nós nos referenciamos aos registradores e às operações usando nomes legíveis. Os nomes dos registradores na linguagem Assembly do MIPS sempre começam com o símbolo cifrão (`$`). Por exemplo, o registrador `$s0` corresponde ao registrador de número 16 em decimal, ou `10000` em binário. O papel do montador, também conhecido como *Assembler*, é simplesmente traduzir de um nome como `$s0` diretamente para o binário `10000` em linguagem de máquina.

### Tamanho da Palavra (Word Size)
O tamanho "natural" dos dados com o qual um determinado processador lida é denominado *word* (ou palavra). O tamanho da palavra (word) da arquitetura MIPS32 é de exatamente 32 bits. Isso significa que, no MIPS32, os registradores suportam dados de 32 bits, e as operações da CPU geralmente também processam informações em blocos de 32 bits. Diferentes processadores de mercado possuem palavras de tamanhos variados. O processador x86-64, curiosamente, possui uma palavra original de 16 bits. Mesmo que essa arquitetura suporte registradores de 32 bits (no x86) e 64 bits (no x64), a definição de sua palavra de dados ainda remete ao seu tamanho original histórico de 16 bits. Nessa arquitetura, define-se *byte* (8 bits), *word* (16 bits), *dword* (Double Word - 32 bits) e *qword* (Quad Word - 64 bits). Em contraste, os microcontroladores PIC da família 16F62x possuem uma palavra de apenas 8 bits.

### Anatomia e Formato das Instruções
![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.1%20-%20Conjuntos%20de%20Instrucoes%20MIPS%20e%20Registradores/slide_4_img_1.png)
![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.1%20-%20Conjuntos%20de%20Instrucoes%20MIPS%20e%20Registradores/slide_4_img_2.png)

Todas as instruções na arquitetura MIPS ocupam exatamente 32 bits de espaço. Essa consistência de tamanho fixo facilita imensamente o projeto de hardware do processador. A arquitetura x86, por exemplo, possui instruções de tamanhos variados. Essa variação a torna mais flexível para programação, mas faz com que o hardware decodificador se torne muito mais complexo e, muitas vezes, mais lento. A imagem fornece um exemplo de uma instrução em linguagem de máquina no MIPS, composta inteiramente por uma sequência de 32 bits (0s e 1s). É extremamente difícil para um humano interpretar e criar um programa utilizando diretamente esses bits de máquina. Esse é um dos principais motivos pelos quais programamos em Assembly. O montador (*assembler*) é a ferramenta que consegue traduzir diretamente o código Assembly para a linguagem de máquina e vice-versa. Isso é diferente de um compilador, que precisa fazer toda uma "reinterpretação lógica do código" fonte para transformá-lo em uma série de instruções na linguagem de máquina.

### Campos das Instruções Tipo-R
No código Assembly, nós utilizamos atalhos e nomes fáceis de lembrar, chamados de mnemônicos, ao invés de escrevermos os bits diretamente para representar uma instrução da máquina. Para entendermos como a CPU interpreta de fato a instrução e como podemos transformar o código em Assembly para a linguagem de máquina (e vice-versa), precisamos começar a entender profundamente a arquitetura MIPS. Cada instrução MIPS possui campos internos com larguras pré-definidas em bits. Quais campos exatos são utilizados e o que eles significam depende do formato da instrução em questão.

Nas instruções do formato Tipo-R, os bits são divididos da seguinte maneira:
- **op**: é o código básico da instrução, tradicionalmente chamado de *opcode*.
- **rs**: representa o registrador do primeiro operando (fonte).
- **rt**: representa o registrador do segundo operando (fonte).
- **rd**: representa o registrador de destino, onde o resultado será salvo.
- **shamt**: significa *Shift Amount*, que indica a quantidade de bits a serem deslocados.
- **funct**: define a variante específica da operação que está sendo realizada.

### Limitações e Exemplos do Tipo-R
![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.1%20-%20Conjuntos%20de%20Instrucoes%20MIPS%20e%20Registradores/slide_5_img_1.png)
![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.1%20-%20Conjuntos%20de%20Instrucoes%20MIPS%20e%20Registradores/slide_5_img_2.png)

O que aconteceria no MIPS se tivéssemos mais de 32 registradores disponíveis no hardware? O problema é que os campos rs, rt e rd da instrução precisariam de mais bits para conseguir endereçá-los. Para que a instrução continuasse com 32 bits de tamanho fixo, precisaríamos sacrificar o tamanho de outros campos, ou então seríamos forçados a criar instruções que ocupassem mais do que 32 bits.

Um exemplo clássico de uma instrução do Tipo-R em Assembly seria:
```assembly
add reg1, reg2, reg3
```
Esta instrução solicita ao processador que some o valor do `reg2` com o valor do `reg3` e armazene o resultado final no `reg1`. Em código real para o MIPS, escreveríamos:
```assembly
add $t0, $s1, $s2
```
A linha de código traduz-se em linguagem de máquina preenchendo o opcode de soma, colocando `$s1` no campo de registrador fonte *rs*, `$s2` no campo de registrador fonte *rt*, e `$t0` no campo do registrador destino *rd*.

### Instruções Tipo-I e Constantes
![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.1%20-%20Conjuntos%20de%20Instrucoes%20MIPS%20e%20Registradores/slide_6_img_1.png)
![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.1%20-%20Conjuntos%20de%20Instrucoes%20MIPS%20e%20Registradores/slide_6_img_2.png)

As instruções do Tipo-R são fundamentais para lidarmos diretamente com dados que já estão nos registradores. Mas o que fazer se precisarmos carregar um valor constante fixo para dentro de um registrador? Por exemplo, se quisermos colocar o valor `2855` decimal diretamente no registrador `$s0`. Poderíamos, em teoria, utilizar um *opcode* diferente para especificar que os campos *rs* ou *rt* estão se referindo ao valor propriamente dito que queremos carregar, e não ao endereço de um registrador. O problema com essa abordagem no Tipo-R é que possuímos apenas 5 bits disponíveis nesses campos. Portanto, a maior constante positiva que poderíamos especificar seria `31` em decimal. Se considerarmos trabalhar com valores que possuem sinal utilizando a notação de complemento a dois, nosso intervalo numérico ficaria limitadíssimo, variando apenas entre -16 e +15.

Para resolver esse problema, usamos as instruções do formato Tipo-I (Tipo-Imediato). As instruções do Tipo-I servem para, dentre outras coisas, carregar valores constantes, que são denominados de valores imediatos, e também para realizar acessos e leituras à memória.
No formato Tipo-I, nós não temos os campos *rd*, *shamt* e *funct*. Esses três campos são unidos e viram um único campo grande de 16 bits de extensão, que é justamente onde nós colocamos o nosso valor constante (imediato). Com esses 16 bits, agora podemos inserir constantes que variam em torno de +/- 2^15 utilizando o sistema de complemento a dois. Os campos *op* e *rs* continuam possuindo exatamente os mesmos significados que tinham no Tipo-R. Porém, no Tipo-I, o campo *rt* é modificado: ele especifica o registrador de destino ou o registrador de fonte, dependendo exclusivamente de qual instrução está sendo executada.

Um exemplo prático de uma instrução do Tipo-I é a adição imediata:
```assembly
addi reg1, reg2, imediato
```
Essa instrução pede à CPU que some o valor atual do `reg2` com o valor numérico literal `imediato`, e armazene o resultado em `reg1`. Um código Assembly real seria:
```assembly
addi $s1, $s2, 100
```
Isso efetua a soma do conteúdo em `$s2` com o número 100 e guarda tudo no registrador `$s1`.

### Referências Bibliográficas
As informações apresentadas baseiam-se em literatura acadêmica da área. Incluem o clássico "Organização e Projeto de Computadores: Interface Hardware/Software" (5ª Edição) de D. Patterson e J. Henessy. Também apoiam-se no livro "Organização estruturada de computadores" (5ª Edição) de Andrew S. Tanenbaum e em "Digital Design and Computer Architecture" (2ª Edição) de Harris e Harris. Para praticar, recomenda-se o uso dos simuladores MARS.
