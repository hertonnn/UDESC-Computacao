# Arquiteturas e Abstrações

### Níveis de Abstração de um Computador

O estudo de sistemas computacionais é comumente dividido em "níveis de abstração", conforme proposto por Null e Lobur (2014). A disciplina de Arquitetura e Organização de Computadores (AOC) foca primordialmente na interface entre hardware e software, englobando a Arquitetura do Conjunto de Instruções (ISA), a microarquitetura, os datapathes e o nível de lógica digital. Entender esses níveis é essencial para compreender como os softwares de alto nível dependem diretamente das engrenagens lógicas e elétricas que estamos trabalhando.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.10%20-%20Arquiteturas%20e%20Abstracoes/slide_1_img_1.png)

---

### A Arquitetura de Von Neumann

A famosa **Arquitetura de Von Neumann** foi originalmente idealizada por **John W. Mauchly** e **J. Presper Eckert** enquanto trabalhavam no lendário projeto do ENIAC. A ideia da nova arquitetura seria empregada de forma pioneira no sucessor do ENIAC, chamado EDVAC. O projeto ocorreu durante a Segunda Guerra Mundial e, devido ao caráter ultrassecreto, os verdadeiros inventores não puderam publicar ou divulgar abertamente suas ideias.

**John Von Neumann**, um brilhante matemático húngaro que trabalhava como consultor em itens periféricos do projeto ENIAC, publicou e popularizou de forma abrangente as propostas arquitetônicas do EDVAC criadas por Mauchly e Eckert. Von Neumann foi um "publicitário" e compilador tão competente dessas ideias matemáticas e organizacionais que a História acabou batizando a arquitetura com o seu nome.

A arquitetura se tornou historicamente revolucionária pelo conceito de **"programa armazenado"**. Embora pareça algo trivial na atualidade, os primeiros programas de computadores (como no próprio ENIAC inicial) eram totalmente implementados fisicamente via cabos (*hardwired*). Caso fosse necessário mudar o software ou algoritmo, era preciso que operadores humanos reconfigurassem fisicamente o circuito da máquina com cabos e chaves.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.10%20-%20Arquiteturas%20e%20Abstracoes/slide_2_img_1.png)
![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.10%20-%20Arquiteturas%20e%20Abstracoes/slide_2_img_2.png)

#### O Ciclo de Von Neumann

Nesta arquitetura, os programas são executados seguindo um fluxo estrito conhecido como **Ciclo de busca-decodificação-execução**:
1. A CPU **busca** a próxima instrução da memória principal utilizando um registrador especial chamado de Contador de Programa (PC).
2. A instrução carregada é **decodificada** pelo controle da máquina, transformando-se em sinais que a ALU (*Arithmetic Logic Unit*) possa entender.
3. Os operandos lógicos necessários (valores em registradores ou vindos da memória) são carregados para a operação.
4. A ALU **executa** a operação matemática ou lógica e o resultado é armazenado, seja em um registrador, seja de volta na memória principal.

#### O Modelo Estrito e o Gargalo

Uma máquina puramente Von Neumann possui os seguintes componentes:
- Uma **CPU central**, contendo unidade de controle, ALU, registradores internos e o Contador de Programa (PC).
- Um sistema de E/S.
- E, o mais crucial: **Uma única memória principal** que armazena, concorrentemente, o código do programa (instruções) e os dados do programa.
- Há um **único caminho (lógico ou físico)** conectando a CPU até a memória principal. A máquina é capaz de executar instruções apenas sequencialmente.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.10%20-%20Arquiteturas%20e%20Abstracoes/slide_3_img_1.png)

A nossa CPU MIPS desenvolvida ao longo da disciplina segue a arquitetura de Von Neumann de maneira estrita? **Não exatamente.**

Nós possuímos internamente *duas* memórias fisicamente separadas: uma **Memória de Instruções** e uma **Memória de Dados**.
Se tivéssemos implementado um modelo Von Neumann rigoroso com apenas uma memória, isso inevitavelmente geraria o que chamamos de **Gargalo de Von Neumann** (*Von Neumann bottleneck*).
No datapath com Pipeline do MIPS, esse problema ficaria evidente: teríamos o estágio `IF` tentando ler uma instrução e o estágio `MEM` tentando acessar ou escrever um dado no exato mesmo ciclo de clock, na exata mesma memória. Isso geraria um **Hazard Estrutural** massivo e irreversível no sistema de memória, e nos obrigaria a injetar severas bolhas (stalls) que aniquilariam os ganhos de performance do paralelismo do pipeline.

---

### A Arquitetura Harvard

Para contornar os problemas da via única da memória em processadores rápidos, introduzimos a **Arquitetura Harvard**. Nela, temos memórias e barramentos separados especificamente para dados e instruções (como ocorre no datapath clássico MIPS que estudamos).

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.10%20-%20Arquiteturas%20e%20Abstracoes/slide_4_img_1.png)

- **Arquitetura Harvard Pura**: Segue estritamente a total separação entre as hierarquias de instrução e dados. É um modelo altamente predominante na indústria de **Microcontroladores**. Um microcontrolador é um "computador completo" embutido em um único chip, que inclui seus próprios processadores, unidades lógicas, áreas independentes de armazenamento de dados (SRAM) e de instruções (Memória Flash), controladores de I/O, timers, etc.

- **Arquitetura Harvard Modificada**: Esse modelo relaxa a separação física radical entre a memória de dados e a de instruções no limite final do sistema. É aqui que se enquadra a esmagadora maioria dos computadores pessoais modernos (família x86-64).
  - **Nos níveis de memória próximos à CPU**: O sistema age como uma Arquitetura Harvard. Temos memórias cache L1 dedicadas e separadas fisicamente dentro do núcleo da CPU para lidar apenas com Instruções (L1i) e apenas com Dados (L1d), permitindo a vazão de paralelismo.
  - **Nos níveis de memória distantes da CPU (Memória Principal RAM)**: O sistema age como uma máquina de Von Neumann tradicional. Os blocos de dados e de código compartilham o mesmo espaço físico na placa-mãe e são acessados pelo mesmo controlador principal e pelo mesmo barramento exterior. Embora as máquinas possuam RAM em "múltiplos canais" (Dual-Channel, Quad-Channel), logicamente a CPU ainda requisita uma única via de informação unificada para abastecer ambas as pontes da cache (uma de cada vez para um mesmo canal).

*(No sistema operacional Linux, você pode executar o comando `lscpu` no terminal para verificar informações detalhadas sobre as caches unificadas ou separadas da sua CPU atual).*

---

### Arquiteturas Paralelas e Multicore

Em sistemas contemporâneos que vão do computador pessoal até fazendas de supercomputadores, aplicam-se modelos de paralelismo massivo em diversos níveis hierárquicos:
- Pipelining (nível de instrução).
- Processadores superescalares (despacho múltiplo de instruções).
- **Processadores Multicore** (múltiplos núcleos executando threads de hardware).
- Multiprocessadores, Grids (heterogêneo), Clusters (homogêneo).

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.10%20-%20Arquiteturas%20e%20Abstracoes/slide_5_img_1.png)

Focando no paradigma **Multicore**, temos vários processadores de silício (núcleos completos com ALU e controle) integrados nativamente no mesmo pacote (chip). Em computadores pessoais de mesa, todos esses processadores acessam a mesma memória principal por meio de barramentos sistêmicos compartilhados. Trata-se de uma máquina com modelo **UMA** (*Uniform Memory Access*), o que significa que o tempo para qualquer core acessar qualquer posição de RAM é teoricamente o mesmo e uniforme.

**Máquinas Multicore são de Von Neumann?**
Com múltiplos núcleos executando diferentes fluxos de instruções paralelamente, muitos puristas classicam que o modelo clássico de fluxo estrito e sequencial de Von Neumann foi quebrado (pois o processamento global já não é puramente serial).
Outros autores defendem que as CPUs modernas ainda pertencem à classe de Von Neumann, pois cada "core" individual age como uma máquina Von Neumann encapsulada que simplesmente coopera via sistema operacional. Como sugerido por Null e Lobur (2014), podemos enxergar uma CPU moderna como uma máquina de Von Neumann que apresenta fortes aspectos de "non-Von Neumannness" (*aspectos que fogem de Von Neumann*).

**Mix and Match (A Mistura Moderna)**
Uma CPU x86-64 atual pode ser vista, portanto:
- Como uma **Arquitetura Harvard** em seus níveis de cache, mas uma **Arquitetura Von Neumann** em relação à RAM unificada principal.
- Como uma máquina Von Neumann com capacidades massivas de paralelismo extra.

---

### RISC versus CISC

Os termos **RISC** e **CISC** frequentemente se referem, popularmente, a tipos distintos de arquiteturas computacionais. No rigor técnico, eles definem o "estilo" predominante do formato da linguagem de máquina e do conjunto de instruções (*Instruction Set Architecture*).

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.10%20-%20Arquiteturas%20e%20Abstracoes/slide_7_img_1.png)

#### CISC (Complex Instruction Set Computer)
Geralmente é caracterizado por:
- Conter um número massivo (muito grande) de instruções variadas e altamente especializadas.
- O formato e o tamanho das instruções binárias são altamente variáveis em bytes. (Em contrapartida, no MIPS32 que estudamos de forma clássica, todas as instruções ocupam invariavelmente 32-bits de espaço na memória).
- Possui instruções **complexas**, com alta densidade, que são capazes de executar múltiplos passos em uma única e grande operação da ISA. Por exemplo, uma única instrução Assembly pode conter operandos que dizem para a CPU: buscar um dado na memória profunda, somá-lo na ALU com outro dado em memória, e depois guardar o resultado direto de volta na memória, tudo de uma vez, sem instruções explícitas de `Load/Store`.
- **Exemplo Clássico**: A família x86 e x86-64 dos processadores de desktop e notebooks da Intel e AMD.

#### RISC (Reduced Instruction Set Computer)
Geralmente é caracterizado por:
- Possuir um conjunto (Instruction Set) enxuto, simplificado e altamente ortogonal. As instruções isoladas são menos "poderosas".
- O grande objetivo do RISC é simplificar radicalmente o design do hardware (datapath e unidade de controle lógicas) e, com isso, tornar possível que o ciclo de relógio corra muito mais rápido, operando comandos fluidamente e com latência mais previsível.
- Contém muito poucos formatos diferentes de instrução (no nosso modelo acadêmico MIPS, apenas Tipo-R, Tipo-I e Tipo-J).
- Utiliza **tamanho fixo** da palavra de instrução para facilitar o *fetch* (busca).
- Opera rigorosamente no modelo `Load/Store` (Load-Store Architecture): as operações matemáticas e lógicas ocorrem unicamente entre registradores. O acesso à memória só ocorre de maneira explícita, via instruções dedicadas para leitura (`lw`) ou escrita (`sw`).
- **Exemplo Clássico**: Processadores de celulares e tablets (Arquitetura ARMv8, Apple Silicon), Microcontroladores, e o processador didático e embarcado **MIPS** utilizado na disciplina.

> **Atenção à Tabela Comparativa:**
> É importante analisar as diferenças acadêmicas de forma crítica. As distinções entre RISC e CISC citadas em manuais *não são regras absolutas em pedra*, mas sim tendências e filosofias historicamente comumente encontradas em cada mercado de processadores.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.10%20-%20Arquiteturas%20e%20Abstracoes/slide_8_img_1.png)

---

### A Complexidade do Pipeline no Mundo Moderno

Nós construímos em aulas práticas um Pipeline conceitual para a máquina RISC MIPS (com seus 5 estágios simples e diretos). Agora imagine construir isso fisicamente no formato nativo CISC da arquitetura x86-64 do seu computador. Os obstáculos seriam colossais:
- Devido às instruções de tamanho livre e variável, a etapa de Busca (`IF`) já tem extrema dificuldade de prever onde corta e começa a próxima instrução sem decodificá-la primeiro.
- Existe uma infinidade enorme de formatos não ortogonais, demandando lógicas booleanas assustadoras para a Unidade de Controle combinacional.
- Diversas instruções podem exigir acesso cruzado ou não-alinhado de dados à memória principal ao mesmo tempo, estagnando o pipeline incontrolavelmente.

Para agravar, processadores "Core i7" de verdade têm componentes insanamente profundos como:
- **Despacho múltiplo dinâmico** (*Dynamic Multiple Issue*): A CPU despacha até 4, 6 ou 8 instruções de percursos diferentes no mesmo mísero ciclo de clock para as variadas ALUs contidas no Core.
- **Multithreading simultâneo** (*SMT* / apelidado comercialmente de Hyper-Threading pela Intel): Um núcleo divide seus recursos para parecer e atuar paralelamente como duas ou mais CPUs virtuais perante o sistema operacional.
- Instruções de operações matemáticas com pontos flutuantes (`FPU`) ou extensões vetoriais (`AVX`) que requerem tempo (ciclos de relógio) longos e irregulares no estágio de execução (*EX*).
- **Buffers circulares de reordenação de instruções**: A CPU pode puxar e executar as instruções em uma ordem cronologicamente caótica ou aleatória daquela escrita pelo programador de software (*Out-of-Order Execution*), para fugir de paradas e otimizar tempo ocioso das ALUs, consertando as dependências lógicas na saída.
- Redes neurais embutidas e memórias gigantes utilizadas unicamente como Tabelas Históricas para a predição dinâmica probabilística do próximo branch de código antes que ele chegue no estágio de verificação de pulo.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.10%20-%20Arquiteturas%20e%20Abstracoes/slide_9_img_1.png)
![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.10%20-%20Arquiteturas%20e%20Abstracoes/slide_9_img_2.png)

#### A "Casca" CISC

Então, como a arquitetura do seu processador de mesa (CISC) consegue suportar e se beneficiar da velocidade extrema dos super-pipelines (que originalmente brilharam no paradigma RISC)?

Em arquiteturas CISC baseadas no x86 introduzidas a partir do *Intel Pentium Pro* (1997), a solução brilhante da indústria foi criar uma fronteira de hardware especializada. O silício embutido passou a **traduzir nativamente e em tempo real** as instruções CISC pesadas que chegam da memória RAM e fatiá-las em blocos primários simplificados conhecidos como **micro-ops** (que agem de forma intrínseca exatamente como um código de máquina RISC primitivo e ortogonal).

As intrincadas redes lógicas de alta eficiência de hardware nos níveis mais profundos do pipeline, das ALUs ao registrador, operam pura e violentamente em micro-ops parecidos com RISC.

Portanto, em essência, o modelo do **seu processador é essencialmente uma "casca" pesada de compatibilidade CISC que encobre e alimenta internamente os motores velozes de um verdadeiro processador superescalar de filosofia RISC**. Pense em quanta área valiosa, eletricidade e transistores da engenharia do chip são dedicados ("jogados fora") em conversores brutos só para manter viva essa compatibilidade e traduzir incessantemente o conjunto de software CISC em instruções RISC dinamicamente.

---

### Referências

- D. Patterson; J. Henessy. *Organização e Projeto de Computadores: Interface Hardware/Software*. 5ª Edição. Elsevier Brasil, 2017.
- Null L., Lobur J. *The Essentials of Computer Organization and Architecture*. Jones & Bartlett Publishers, 2014.
- STALLINGS, William. *Arquitetura e organização de computadores*. 10. ed. São Paulo: Pearson Education do Brasil, 2018.
- J. Henessy; D. Patterson. *Arquitetura de computadores: Uma abordagem quantitativa*. 6ª Edição. Elsevier Brasil, 2014.
