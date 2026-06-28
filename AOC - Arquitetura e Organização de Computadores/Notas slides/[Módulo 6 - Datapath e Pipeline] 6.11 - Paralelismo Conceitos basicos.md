# Paralelismo: Conceitos Básicos

### O Paralelismo no Processador MIPS

No modelo de processador MIPS que estudamos ao longo da disciplina, implementamos de forma bem-sucedida um paralelismo a **nível de instrução** (Instruction-Level Parallelism - ILP).

Através da arquitetura de *pipeline*, demonstramos que múltiplas instruções são executadas “ao mesmo tempo na CPU”, desde que estejam em estágios operacionais diferentes (`IF`, `ID`, `EX`, `MEM`, `WB`).

Porém, essa abordagem possui limites claros inerentes ao design clássico:
- Somente **uma** instrução é enviada ao pipeline a cada ciclo de relógio (clock).
- Somente **uma** instrução pode ser efetivamente completada (*retired*) a cada ciclo de clock.
- O ganho real de desempenho do sistema está na drástica redução do tempo total (duração) de cada ciclo de clock de toda a máquina, possibilitada pela divisão do caminho de dados em etapas curtas.
- Adicionalmente, as instruções operam de forma singular em apenas **um dado por vez** (elas fazem a operação aritmética e armazenam um único resultado em um registrador específico).

#### SISD
Devido a essa limitação, a nossa CPU MIPS pipelinizada clássica é um exemplo claro de uma arquitetura **SISD** (*Single Instruction, Single Data*).
Isso significa: Uma instrução para operar um dado. São processadores que, internamente, executam a busca de apenas uma instrução por vez, e essa instrução é capaz de operar matematicamente em apenas uma variável ou dado atômico de cada vez.

---

### Multiprocessadores e Paralelismo de Tarefas

Um **multiprocessador** é um computador cujo cérebro (chip) é composto de múltiplos processadores completos encapsulados.
Nossas máquinas pessoais atuais (família x86-64) são os exemplos mais onipresentes de multiprocessadores integrados. A indústria tecnológica as chama comercialmente de **microprocessadores multicore** (multinúcleo).

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.11%20-%20Paralelismo%20Conceitos%20basicos/slide_2_img_1.png)

Como exemplo prático, processadores modernos como o Intel i9-9900k são na verdade um chip multiprocessador composto de 8 processadores (8 cores) que compartilham o acesso aos recursos do sistema.

Em um sistema multiprocessado moderno, cada processador pode executar uma thread ou tarefa computacional totalmente independente da outra. Temos aí o **Paralelismo a nível de tarefa/processo** (*Task-Level Parallelism*).

Entretanto, do ponto de vista do software:
- Se você escrever um código ou programa da forma clássica puramente sequencial (um laço `while` iterando um vetor, por exemplo), o sistema operacional irá alocá-lo para executar usando somente **um** dos *N* processadores disponíveis.
- Saber estruturar, projetar e criar programas que executam explicitamente em paralelo já não é opcional na computação moderna. É necessário o uso de chamadas de sistemas como `fork` ou bibliotecas como o Pthreads (*POSIX Threads*).

**Atenção em Python (O GIL):**
Ao utilizar Python, o desenvolvedor precisa sempre considerar o fator *GIL* (*Global Interpreter Lock*). Ele garante que (quase) todo código em Python só pode ser interpretado e executado pelo interpretador padrão se estiver com o cadeado "em controle". Devido ao GIL, utilizar multithreading convencional em Python frequentemente resulta no uso efetivo de apenas **uma** CPU, pois as threads travam umas às outras. A solução em Python para o paralelismo computacional real é dividir a carga de trabalho entre múltiplos processos instanciados separadamente (via módulos como `concurrent.futures.ProcessPoolExecutor` ou a API de mais baixo nível `multiprocessing`), e não utilizar múltiplas *threads*.

---

### A Taxonomia de Flynn e Tipos de Arquitetura

Para classificar arquiteturas paralelas de forma genérica, utilizamos o modelo conhecido como **Taxonomia de Flynn**.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.11%20-%20Paralelismo%20Conceitos%20basicos/slide_4_img_1.png)

#### MIMD (*Multiple Instruction, Multiple Data*)
- Caracterizado por processar **múltiplas instruções e múltiplos dados** simultaneamente.
- Sistemas Multiprocessadores podem ser categorizados como MIMD, já que possuem *N* processadores de núcleo, cada um podendo buscar e operar uma instrução atômica completamente diferente da outra (*Multiple Instruction* — Paralelismo a nível de instrução) sobre dados vindos de endereços de memória também diferentes (*Multiple Data* — Paralelismo a nível de dados).

#### MISD (*Multiple Instruction, Single Data*)
- Caracterizado por processar **múltiplas instruções operando em um fluxo de dado único**.
- Um modelo teórico de instrução que executaria simultaneamente múltiplas operações (como soma, divisão e raiz) sobre uma mesma e única variável. Não existem computadores puramente baseados em MISD em larga escala atualmente na indústria.

#### SIMD (*Single Instruction, Multiple Data*)
- Caracterizado por processar **uma instrução operando concorrentemente em múltiplos dados**.
- Por exemplo, você emite uma única instrução para a CPU (como um *add* imediato), mas em vez de somar dois valores isolados, ela automaticamente repete e aplica essa soma em múltiplos registradores e em múltiplos dados de forma perfeitamente paralela no mesmo ciclo do clock. Esse modelo é extremamente comum e crucial dentro dos *cores* dos nossos processadores atuais.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.11%20-%20Paralelismo%20Conceitos%20basicos/slide_3_img_1.png)

---

### Adicionando Capacidades SIMD

Imagine como poderíamos adicionar capacidades operacionais SIMD em nosso datapath do processador MIPS acadêmico. Em algoritmos da vida real (gráficos, engenharia, processamento de imagem), é comum termos que carregar múltiplos endereços de memória contíguos em registradores de variáveis, realizar uma soma, e depois armazenar e descarregar os resultados.

Veja um algoritmo simples sequencial de processamento linear com as instruções normais (somando 1 a um vetor de inteiros):
```assembly
lw $s0, 0($t0)
lw $s1, 4($t0)
lw $s2, 8($t0)
lw $s3, 12($t0)

addi $s0, $s0, 1
addi $s1, $s1, 1
addi $s2, $s2, 1
addi $s3, $s3, 1

sw $s0, 0($t0)
sw $s1, 4($t0)
sw $s2, 8($t0)
sw $s3, 12($t0)
```
Se formos operar dados densos (ex: operando de "4 em 4"), seriam necessárias 12 instruções individuais descendo pelo pipeline MIPS. 

**Uma Primeira Ideia para o Hardware**
Poderíamos modificar o MIPS criando uma instrução estendida com sufixo `s` (para denotar SIMD), instruindo que ela já carregue ou opere múltiplos registradores:
```assembly
lws $s0, $s1, $s2, $s3, 0($t0)
addis $s0, $s1, $s2, $s3, $s0, $s1, $s2, $s3, 1
sws $s0, $s1, $s2, $s3, 0($t0)
```
**O Problema Arquitetural Inegociável:**
As instruções na linguagem de máquina do MIPS possuem exatamente um limite físico inquebrável de **32 bits**.
Se tentássemos criar o bitcode para essa primeira ideia de `lws` com 4 registradores de destino, nós esgotaríamos o espaço da instrução: 
`(6 bits de opcode) + (5 x 5 bits para os números dos 5 registradores envolvidos) + (16 bits de imediato de offset)` = Total de **47 bits** necessários. Isso quebra a estrutura rígida de decodificação da máquina RISC.

#### A Solução: Criando Registradores "Grandes"
A alternativa genial da indústria para escapar do limite de tamanho da instrução em arquiteturas é criar e adicionar **registradores "grandes e largos"** na nossa CPU.

Em vez de declarar na instrução 4 registradores MIPS pequenos de 32 bits, nós declaramos um único registrador especializado, com capacidade física paralela para **128 bits** (o que comporta perfeitamente os quatro inteiros contíguos de 32 bits).
Exemplo:
Registradores longos chamados `xmm0`, `xmm1` ... `xmm7`.
A nova instrução seria apenas:
```assembly
lws xmm0, 0($t0)
```
E isso carregará do barramento de memória, em um único pulso ou rajada, 128 bits contínuos (16 bytes em bloco) a partir do ponteiro `$t0`, inserindo-os confortavelmente no super-registrador `xmm0`. O tamanho da instrução Assembly não sofre nenhum impacto grave e fica dentro do teto de 32 bits: `(6 bits opcode) + (5 bits registrador xmm) + (5 bits registrador ponteiro) + (16 bits de imediato)` = **32 bits cravados**.

**Lidando com os limites de mapeamento:**
Se temos 5 bits reservados na linguagem de máquina para apontar para o endereço do registrador interno, o limite combinatório são no máximo 32 possíveis endereços (`2^5`). Em um processador que já tem seus endereços clássicos todos ocupados (`$zero`, `$t0...$t9`, `$s0...$s7`), como referenciar os registradores largos `xmm`?
A solução da arquitetura é que o próprio *opcode* dessa nova família de instruções `s` notifica internamente a Unidade de Controle para ativar e usar um **outro banco físico de registradores** desconectado do grupo primitivo. O índice de 0 a 7 agora aponta internamente para o banco *SIMD Register File*.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.11%20-%20Paralelismo%20Conceitos%20basicos/slide_6_img_1.png)

#### Operando Dados Vetorizados (addis)

Quando chamamos:
```assembly
addis xmm0, xmm0, 10
```
O registrador `xmm0` que tem seus 128 bits preenchidos com 4 vetores lógicos é segmentado (*sliced*). A CPU vai processar simultaneamente os dados ali dispostos "em pedaços" uniformes de 32 bits. Os primeiros 32 bits sofrem soma com `10`, os próximos 32 sofrem com `10`, e assim sucessivamente. O resultado consolidado volta fracionado de 32 em 32 bits para dentro do mesmo `xmm0`.
Mas há um detalhe importantíssimo sobre os requisitos físicos: Para que a instrução de fato execute cálculos perfeitamente em paralelo nesse estágio sem gerar filas (stalls), é mandatório o uso de **adicionar mais Hardware na placa**.

**O que precisamos modificar/adicionar na CPU MIPS fisicamente?**
1. O novo **Banco de Registradores SIMD** longo.
2. Precisaremos de nada menos que **4 ALUs** replicadas e distribuídas lado a lado no estágio lógico. Uma ALU independente ficará responsável de cuidar dos bits 0~31, a segunda ALU dos bits 32~63, a terceira e a quarta sucessivamente. Caso não tivéssemos essa redundância de hardware, criaríamos uma fila onde uma única e estressada ALU tentaria executar o cálculo dos quatro inteiros de forma repetitiva através de loops forçados consumindo múltiplos ciclos de relógio, arruinando a ideia central.

---

### O SIMD no Mundo Real e o SSE

A estratégia teórica detalhada acima é exatamente a fundação arquitetural que impulsiona os atuais processadores. Na arquitetura das CPUs baseadas em x86-64, essa capacidade computacional em forma de conjunto é o chamado **SSE (*Streaming SIMD Extensions*)**.

Se você executar o utilitário `lscpu` em sua máquina Linux, muito possivelmente vai visualizar nas *flags* do processador suporte nativo ao conjunto de operações `sse, sse2, sse3, sse4_1`, etc. Isso ilustra o fato vital: se olharmos para um único processador individual (core) de um multiprocessador complexo moderno, encontraremos lá dentro embutido um formidável processador interno com grandes capacidades de paralelismo por meio das extensões SIMD.

**Características do SSE do x86-64:**
- Na sua fundação clássica, usa 8 registradores monolíticos largos de 128 bits de tamanho (`xmm0`, `xmm1`, até `xmm7`).
- O modo em que a fatia de 128 bits é sub-dividida pela ALU obedece totalmente à função que o programador ou o compilador decide utilizar. Dependendo do fluxo, podemos agrupar e operar matematicamente em paralelo:
  - 2 dados em precisão dupla (*double* de 64 bits).
  - 2 inteiros estendidos (*longs* de 64 bits).
  - 4 dados de precisão flutuante convencional (*floats* de 32 bits).
  - 4 inteiros (*ints* normais de 32 bits), entre outros layouts customizados (como bytes de pacotes multimídia e cor).
- **Restrição crônica de alinhamento**: Para manter o fluxo elétrico de memória rápido e perfeito, grande parte das operações rígidas SSE da arquitetura exige que o bloco vetorial que você quer carregar esteja iniciando em um **endereço de memória obrigatoriamente múltiplo de 16**. Esse processo exige uma alocação especial do sistema.

---

### Exemplo Prático SSE na Linguagem C

Para criar instâncias de dados corretas para SSE na linguagem C clássica:

```c
float* vetor;
int ret = posix_memalign((void**)&vetor, 16, TAM_VETOR * sizeof(float));
```
- `posix_memalign` é uma função especial de biblioteca que aloca memória dinâmica (`malloc`) de maneira rigorosamente forçada (alinhada em bases de `16` bytes) retornando a cabeça do vetor seguro com o limite arquitetônico requerido. Em caso de sucesso a função retorna `0` ou `EINVAL`/`ENOMEM` para códigos de erro via `errno.h`.

Para conseguir lidar com os recursos SSE na sintaxe regular do compilador GCC ou Clang utilizamos o include intrínseco:
```c
#include <emmintrin.h>
```
O tipo de dados obscuro associado a ele é a *struct* mapeada **`__m128`**. Ele sinaliza uma diretiva pura para o compilador reservando uma entidade monolítica e primitiva de exatos 128 bits. Durante o tempo de geração do código assemble (e logo no hardware real), a variável `__m128` será inegavelmente carregada para o banco especializado de registradores `xmm` físicos do núcleo.

No exemplo abaixo nós usamos o vetor longo pré-alocado e criamos ponteiros mapeadores:

```c
#define TAM_VETOR 1073741824

// Usando intrinsecs SSE para paralelismo vetorizado de baixo nível.
void sse(float* a, int tamanho) {
    // Como os registradores guardam 4 floats de 32 bits de cada vez (4x32=128 bits),
    // o loop só precisa rodar 1/4 do tamanho total do array
    int numBlocos = tamanho / 4;
    
    // Convertemos (casting forçado) o ponteiro para tratar os floats soltos de RAM
    // como sendo blocos unificados nativos de 128 bits
    __m128* ptr = (__m128*)a;
    
    for (int i = 0; i < numBlocos; ++i, ++ptr) {
        // A função mágica aqui é convertida numa instrução assembly SIMD bruta
        // que calcula e armazena simultaneamente 4 raízes quadradas.
        _mm_store_ps((float*)ptr, _mm_sqrt_ps(*ptr));
    }
}
```

O código deve ser compilado passando parâmetros precisos que ativam e instruem o uso de arquitetura estendida, por exemplo: `gcc sse.c -o sse -lm -O3 -msse2`.

#### Observações Estratégicas Finais
Lembre-se do paradoxo do processamento atual: a brutal rotina `_mm_sqrt_ps` baseada em instruções SIMD vista no bloco C é totalmente executada por apenas **uma única CPU do sistema multicore**. Apenas um núcleo de processamento acordou e engajou seus sub-níveis de ALUs vetorizadas do pipeline para rodar a repetição. 

Se o seu computador é alimentado com um Core i7 possuindo 6 processadores físicos integrados, nesse exato instante 5 processadores permanecem "dormindo" totalmente alheios a esse laço e sem processar nada relevante (a respeito unicamente deste código C).

Considerando que as raízes quadradas de posições soltas em um vetor extenso não têm dependências matemáticas prévias entre as linhas de dados, temos em mãos o que chamamos de problema independentemente e trivialmente paralelizável. 
Poderíamos unir o paralelismo vetorial SIMD com paralelismo real baseados em escalonamento em múltiplas threads *Pthreads* delegando fatias fracionadas do vetor matriz principal com cada ponteiro de thread para todos os múltiplos núcleos ociosos das caches. Multiplicar os limites dos multiplicadores físicos e virtuais de um sistema se torna o domínio fascinante ensinado futuramente nas disciplinas avançadas de *Sistemas Operacionais* e *Processamento Paralelo*.

---

### Referências

- D. Patterson; J. Henessy. *Organização e Projeto de Computadores: Interface Hardware/Software*. 5ª Edição. Elsevier Brasil, 2017.
- J. Henessy; D. Patterson. *Arquitetura de computadores: Uma abordagem quantitativa*. 6ª Edição, 2017.
- STALLINGS, William. *Arquitetura e organização de computadores*. 10. ed. São Paulo: Pearson Education do Brasil, 2018.
- Guias de Intrinsics Intel (Intel Intrinsics Guide) e documentação Microsoft para SIMD.
