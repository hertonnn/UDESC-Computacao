# Microcontroladores

## Diferenças Entre Computadores e Microcontroladores

Quando pensamos em um computador, ou em um processador, a primeira imagem que pode vir a nossa mente é um computador de mesa (desktop) ou notebook. Esses dispositivos geralmente possuem:
- Múltiplos processadores, operando em frequências absurdas.
- 8GiB, 16GiB, 32GiB... de memória principal.
- Terabytes de memória para armazenamento.
- Capacidade de executar centenas de tarefas ao mesmo tempo, com um sistema operacional gigantesco e interfaces gráficas.

Mas você realmente espera ter um processador i7 com 16GiB de memória no seu micro-ondas?
A vasta maioria dos aparelhos eletrônicos que usamos no nosso dia a dia precisa realizar algum processamento. Por questões de energia, custo e de projeto, não faz sentido utilizarmos os processadores que utilizamos em nossos desktops para realizar essas tarefas.

### Dispositivos do Cotidiano e Sistemas Embarcados
Quais dispositivos do seu dia a dia podem precisar de algum processamento?
- Micro-ondas, Geladeira, Smartv
- Carro: Controlar o motor (injeção eletrônica), controle dos freios (ABS), controle de estabilidade, controle de iluminação, alarme, central multimídia
- Sistemas de alarme, Mouse, Headphone

Esses dispositivos geralmente compartilham algumas características:
- Não podem ter seus programas alterados pelo usuário.
- Executam um único programa.
- Não possuem sistema operacional.
- São otimizados para a tarefa para as quais eles foram desenvolvidos.
- Baixo custo e baixo consumo de energia.
- Recursos limitados (pouca memória, poucos dispositivos de Entrada/Saída).

Claro que existem exceções: você não espera que o sistema de controle de um avião de grande porte seja de baixo custo, nem que seja simples; TVs atuais possibilitam a atualização do programa que está rodando internamente nelas.

Comumente chamamos esse tipo de dispositivo de **sistema embarcado**: sistemas com o processamento dedicado a executar uma tarefa específica.

## Criando Sistemas Embarcados

### Soluções Puramente via Hardware
**ASIC (Application-Specific Integrated Circuit)**
- Podemos criar um circuito específico para o problema em questão, onde o próprio programa está embutido nas portas lógicas do circuito (parecido com o que fizemos com a unidade de controle *hardwired* do MIPS).
- **Problemas/Aplicabilidade:** 
  - Custa muito caro projetar e produzir um circuito personalizado para determinado equipamento.
  - Um erro no projeto vai exigir que todos os equipamentos sejam substituídos.
  - É viável quando o equipamento é vendido larga em escala (e.g., switches de rede, controles de freios ABS).
  - Uma das principais vantagens é que um circuito especializado para determinada tarefa tende a ser consideravelmente mais rápido do que um "circuito genérico".

**FPGA (Field Programmable Gate Array)**
- "Matrizes" de elementos de processamento.
- Podemos implementar nossas funções lógicas diretamente no hardware, resultando em um hardware reprogramável.

### Microcontroladores
Uma forma que envolve software e hardware para se criar esses sistemas é através do uso de microcontroladores. 

Um microcontrolador é um sistema computacional simples completo em um chip. Em um único chip comumente temos:
- Processador.
- Memória de trabalho (memória principal).
- Memória de armazenamento.
- Controladores e pinos para dispositivos de entrada e saída (ex: PWMs para controlar motores elétricos, Conversores analógico/digital).

Eles são baratos e possuem baixo consumo de energia.

## Estudo de Caso: PIC 16F628A

![PIC 16F628A](./imagens/%5BM%C3%B3dulo%208%20-%20Microcontroladores%5D%208.0%20-%20Microcontroladores/slide_4_img_1.png)

Características do PIC 16F628A:
- **Tamanho da palavra:** 14 bits para instruções, 8 bits para dados.
- **Tamanho das suas memórias:** 
  - 2048 palavras para instruções.
  - 224 palavras de dados em armazenamento não permanente.
  - 128 palavras de dados em armazenamento permanente.
- Arquitetura Harvard e instruções RISC.

**Capacidade de Instruções:**
A memória com capacidade para 2048 instruções de 14 bits equivale a:
`2048 × 14 / 8 = 3584 bytes = 3,5 KiB`

Seu programa não pode ter mais de 2048 instruções em linguagem de máquina. Por isso, programar em *Assembly* pode não ser opcional, já que algumas poucas instruções extras que um compilador pode injetar podem inviabilizar um projeto. No entanto, a maioria dos microcontroladores possui compiladores para linguagem C.

![Formato de Instruções PIC 16F](./imagens/%5BM%C3%B3dulo%208%20-%20Microcontroladores%5D%208.0%20-%20Microcontroladores/slide_5_img_1.png)

**Capacidade de Dados:**
Possui 224 palavras de dados em armazenamento não permanente (memória principal de trabalho). Como cada palavra de dados possui 1 byte, ele tem exatamente 224 bytes de memória principal. 

A imagem acima apresenta o formato das instruções da família PIC 16F.

## Aplicações de Tempo Real e Previsibilidade
A utilização de microcontroladores (e também ASICs e FPGAs) é comum em sistemas de tempo real.
- Nesses sistemas, o tempo máximo para se obter uma resposta é pré-definido.
- Não podemos demorar mais que esse tempo máximo, caso contrário a resposta será menos efetiva, ou será inútil.
- Ex: em um sistema de freios ABS, de nada adianta o sistema calcular a pressão no freio 1 segundo depois que o usuário pisar no pedal.

Nos computadores pessoais, com sistemas operacionais convencionais multitarefas, é difícil calcular com exatidão tempo de pior caso que uma aplicação vai demorar para responder, pois:
- Temos várias aplicações competindo pela CPU.
- Temos invalidações de cache.
- Temos rotinas do Sistema Operacional.

### Ciclos de Clock por Instrução (CPI)
CPI: Quantos ciclos de clock são necessários em média para se completar uma instrução?
- Em nossa CPU MIPS, se não houvessem *stalls* no pipeline, nosso CPI seria 1, pois a cada ciclo de clock, uma instrução é completada. Um CPI de 1 é o melhor caso possível em uma CPU sem redundância de unidades funcionais.
- Nossas CPUs x86 são superescalares, ou seja, possuem várias unidades funcionais replicadas internamente em cada CPU (Core), como múltiplas ALUs. Com isso o CPI pode ser menor que 1.

## Exercícios

1. Qual o CPI do PIC 16F628A?
2. Como utilizar o CPI para criar um sistema onde sabemos o tempo de resposta no pior caso?
3. Uma das plataformas de desenvolvimento baseada em microcontroladores é o Arduino:
   - Quais os microcontroladores comumente encontrados nas plataformas Arduino?
   - Quais suas características (memória, arquitetura, tamanho de palavra, profundidade de pipeline)?
4. Traduza o código MIPS abaixo para instrução do PIC 16F628A:
   ```assembly
   addi $t1, $t2, 5
   add $t3, $t1, $t4
   ```
5. Com relação ao microcontrolador ATMega328P:
   - Qual a arquitetura? (Harvard ou Von Neumann)
   - Quanto de memória ele possui em cada uma de suas memórias?
   - Quantos registradores ele possui? Qual o tamanho dos registradores?
   - Qual o tamanho da palavra de dados? E de instruções?

## O Mercado de Microcontroladores

Os microcontroladores discutidos em aula são apenas alguns exemplos populares. O mercado de microcontroladores é gigantesco e não temos somente dois fabricantes com alguns poucos modelos concorrendo pelo mercado, como no x86.

**Alguns fabricantes:**
- **NXP** (Divisão da Motorola): ARM (NXP), adquiriu a Freescale Semiconductor.
- **Microchip**:
  - PIC10 e PIC12: instruções de 12-bits.
  - PIC16: instruções de 14-bits.
  - PIC18: instruções de 16-bits.
  - PIC24 e dsPIC: instruções de 24-bits.
- **Atmel** (Adquirida pela Microchip em 2016): Atmega (Arquitetura AVR).
- **Texas Instruments**.

## Referências
- D. Patterson; J. Henessy. Organização e Projeto de Computadores: a Interface Hardware/Software. 5ª Edição. Elsevier Brasil, 2017.
- D. Patterson; J. Henessy. Computer Organization and Design: The Hardware/Software Interface. 5ª Edição. 2014.
- J. Henessy; D. Patterson. Arquitetura de computadores: Uma abordagem quantitativa. 6ª Edição. 2017.
- STALLINGS, William. Arquitetura e organização de computadores. 8. ed. São Paulo: Pearson Education do Brasil, 2010.
