# Exceções, Interrupções e I/O

Eventos inesperados, de forma similar a branches e jumps, podem mudar o fluxo normal de execução do programa. Na arquitetura MIPS, temos as seguintes definições:

- **Exceção**: Algum evento interno inesperado que ocorreu dentro do processador. Um exemplo comum é o *overflow* aritmético.
- **Interrupção**: Algum evento inesperado gerado externamente. Um exemplo é quando o usuário digita algo no teclado.

Em muitas arquiteturas, como no x86, o termo "interrupção" é utilizado de maneira generalizada para definir tanto exceções quanto interrupções. O MIPS, por outro lado, faz o contrário:

- Tudo é classificado como uma **exceção**.
- A **interrupção** é apenas um tipo especial de exceção, que foi gerada externamente. Na prática, tratam-se apenas de terminologias diferentes. Vamos utilizar a terminologia do MIPS, alinhada à literatura base da disciplina.

---

### Tratando uma Exceção: Sistema Operacional

Vamos considerar o caso de um overflow aritmético:
```assembly
add $1, $2, $1
```
Se o resultado da soma não couber nos 32 bits disponíveis em `$1`, uma exceção será disparada. Os passos básicos para o tratamento são:

1. **Salvar o endereço da instrução que causou a exceção**: O endereço de PC atual é salvo em um registrador especial chamado **EPC** (*Exception PC*).
2. **Salvar algum código informando a causa da exceção**: Isso é feito no registrador **`cause`** no MIPS. Por exemplo, o código `1` em `cause` pode indicar um overflow, enquanto `2` significa instrução inválida.
3. **Transferir a execução para o Sistema Operacional (S.O.)**: As rotinas do kernel para o tratamento básico de exceções no MIPS iniciam no endereço fixo `0x80000180`.

O S.O. verifica o conteúdo do registrador `cause` para definir o que houve. A partir disso, o S.O. tem a opção de tratar a exceção e retornar a execução do programa a partir do ponto salvo em `EPC`, ou simplesmente abortar e terminar o programa. Caso o S.O. opte por terminar o programa, o `EPC` ainda pode servir como uma informação valiosa para o debug.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.9%20-%20Excecoes%20Interrupcoes%20e%20IO/slide_2_img_1.png)

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.9%20-%20Excecoes%20Interrupcoes%20e%20IO/slide_2_img_2.png)

---

### Tratando uma Exceção: Interrupções Vetorizadas

Outra forma de tratar exceções é eliminar a dependência do registrador `cause` e transferir o controle diretamente para um endereço específico (vetor), dependendo da fonte da exceção.

**Vantagens e Desvantagens das interrupções vetorizadas:**
- **[-] Precisamos de mais hardware**: A tabela de desvios precisa ser armazenada em algum lugar (geralmente uma região de memória dedicada).
- **[-] Menor flexibilidade**: Se um novo tipo de exceção precisar ser tratado pelo nosso hardware, precisamos criar uma nova entrada na tabela ou realizar alguma adaptação complexa (*enjambre*).
- **[+] Tratamento mais rápido**: Agora o S.O. não precisa ler o registrador `cause` para interpretar o código e só então definir o que fazer. O fluxo do programa já é automaticamente redirecionado para o endereço de tratamento específico correspondente àquela exceção.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.9%20-%20Excecoes%20Interrupcoes%20e%20IO/slide_3_img_1.png)

A arquitetura **x86** utiliza amplamente interrupções vetorizadas. Já a arquitetura **MIPS** utiliza o registrador `cause` como padrão. O único cenário que é tratado como uma interrupção vetorizada no MIPS é a **Falta de Páginas** (*Page Fault*), pois é um evento tão comum em sistemas com memória virtual que vale a pena otimizar esse tratamento específico através da vetorização (o conceito de falta de páginas é aprofundado na disciplina de Sistemas Operacionais).

---

### Tratando Exceções no Pipeline

Uma exceção no pipeline é tratada fundamentalmente como um **hazard de controle**.

Se a exceção foi causada internamente, devemos parar a execução imediatamente:
- Salvamos as informações cruciais (como PC em `EPC` e a causa em `cause`).
- Descartamos as instruções anteriores que já estão descendo no pipeline e que poderiam modificar o estado da máquina de forma indevida.
- Redirecionamos a execução para o S.O. ou para uma rotina de tratamento (no caso do MIPS, para `0x80000180`).

Note que as ações são muito similares às tomadas em um desvio condicional (*branch*) onde a previsão de desvio estava incorreta (um *flush* no pipeline). A diferença fundamental é que precisamos salvar algumas informações de estado, e o endereço alvo do desvio é um endereço de hardware fixo (`0x80000180`).

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.9%20-%20Excecoes%20Interrupcoes%20e%20IO/slide_4_img_1.png)

É importante notar que o hardware, devido à natureza do pipeline, frequentemente acaba salvando `PC + 4` no registrador `EPC`. O Sistema Operacional deve levar esse deslocamento em consideração ao tratar uma exceção em um processador MIPS para não pular a instrução incorreta ou entrar em *loop* infinito. A própria unidade de detecção de hazard pode ser adaptada para cuidar do redirecionamento para `0x80000180`.

---

### Comunicando-se com Dispositivos e Espaço de E/S

> **Atenção:** Os conceitos a seguir tomam como base o livro de Sistemas Operacionais Modernos (Tanenbaum), que possui um foco maior em S.O. e utiliza um estilo de instruções mais similar à arquitetura x86.

Todo dispositivo de Entrada/Saída (E/S) é composto por pelo menos dois componentes lógicos e físicos:
- **Parte mecânica**: O dispositivo físico em si (e.g., HD, teclado, leitor de disco).
- **Parte eletrônica (Controladora)**: Possui pelo menos alguns registradores para indicar o que o componente está fazendo ou o que precisa fazer. Por exemplo, um registrador de 8 bits em uma impressora simples, onde a CPU escreve o próximo caractere que a impressora deve imprimir.

**Espaço de E/S**
Controladores especializados (que podem ser encontrados na placa mãe ou embutidos dentro da própria CPU) podem atribuir um número único para cada registrador de cada dispositivo de E/S conectado. Esse número único é chamado de **Número de Porta de E/S**.

Dessa forma, é possível desenvolver instruções específicas para a CPU que recebem um número de Porta de E/S e o valor a ser escrito ou lido.
Exemplos utilizando instruções estilo x86:
- `in REG, PORTA`: Lê o conteúdo da porta especificada e armazena em um registrador `REG` da CPU.
- `out PORTA, REG`: Escreve o conteúdo do registrador `REG` da CPU para a porta especificada.
Em ambos os casos, `PORTA` é o identificador de um registrador interno de um dispositivo de E/S qualquer.

---

### E/S Mapeada em Memória

Outra abordagem para a comunicação é o controlador do sistema atribuir um **endereço de memória** regular para cada registrador de E/S.

Ao realizar uma operação de leitura ou escrita (*load* ou *store*) nesse endereço específico, o controlador detecta que o alvo é um dispositivo, intercepta o acesso e redireciona os dados diretamente para o registrador correspondente no hardware.
Nesse processo, nada é realmente lido ou escrito na memória principal (RAM) da máquina; o endereço é apenas um "atalho" ou "ponteiro falso" utilizado pelo sistema de E/S.
Chamamos essa técnica de **E/S mapeada em memória** (*Memory-Mapped I/O*).

- Agora as próprias instruções `lw` (*load word*) e `sw` (*store word*) podem ser usadas de forma transparente tanto para acessar a memória normal quanto para nos comunicarmos com dispositivos de E/S.
- Precisamos "apenas" de um controlador de memória capaz de interceptar os sinais do barramento vindos da CPU e roteá-los para o local correto dependendo do bloco de endereços acessado.

O **MIPS** utiliza primariamente o esquema de E/S mapeada em memória. Esse modelo é também amplamente utilizado na indústria de microcontroladores (como nas famílias PIC e ATMega).
Já a arquitetura **x86** utiliza ambas as técnicas (ela possui o espaço próprio `in/out` onde há uma área de memória reservada entre `[0 - (64K-1)]` específica para portas de E/S, mas hardwares modernos como placas de vídeo usam E/S mapeada na memória principal).

---

### Enviando Sinais ao Processador (E/S Baseada em Interrupção)

Um dispositivo de E/S pode, de forma proativa, enviar um sinal ao processador informando que algo aconteceu. Chamamos isso de **E/S baseada em interrupção**.

Para que isso seja possível, o processador precisa estar equipado com linhas (fios) de sinais de controle externos. Quando o processador recebe uma voltagem nesse sinal externo, ele gera uma **interrupção** (que, no jargão do MIPS, é apenas uma exceção gerada por um dispositivo externo). O processador também pode ler do barramento externo informações complementares sobre a interrupção. Por exemplo, pode vir embutida no barramento uma informação identificando qual periférico exato de hardware solicitou a atenção da CPU.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.9%20-%20Excecoes%20Interrupcoes%20e%20IO/slide_6_img_1.png)

Diferente de uma exceção interna, quando uma interrupção externa é gerada de forma assíncrona, o processador muitas vezes tem a opção de terminar de executar as instruções inofensivas que já estão descendo no pipeline, antes de finalmente redirecionar o fluxo para o Sistema Operacional. Como o evento veio de fora e não é fruto de um erro das instruções ativas, não há um perigo imediato que impeça as instruções na metade do caminho de terminarem o seu ciclo (`WB`). Com isso, evitamos stalls ou flushes desnecessários. A interrupção é assíncrona em relação às instruções em voo.

O processador armazena as informações necessárias sobre o evento, faz o redirecionamento, e a partir daí o resto do tratamento é exatamente igual a uma exceção normal; o problema é entregue ao S.O. ou à rotina de tratamento instalada.

---

### O Mundo Real: Chipsets e as Pontes

No mundo real dos PCs clássicos, os principais controladores encarregados de fazer as traduções de endereços, coordenar os barramentos e encaminhar as interrupções dos dispositivos de E/S para a CPU formavam o chipset da placa-mãe, classicamente dividido em **Ponte Norte** (*Northbridge*) e **Ponte Sul** (*Southbridge*).

- **Ponte Norte**: Era o controlador de memória de alta velocidade. Ficava fisicamente mais próximo à CPU. Seu papel era conectar os dispositivos que exigiam a maior largura de banda do sistema (e.g., Memória Principal RAM, portas gráficas PCIe x16 de placa de vídeo). Também servia de "caminho" (hub) direto para a conexão com a Ponte Sul.
- **Ponte Sul**: Conectava todos os demais dispositivos (geralmente mais lentos). Gerenciava as interfaces de mouse, teclado (USB), portas SATA de HDs, placa de rede, áudio, portas legadas, etc.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.9%20-%20Excecoes%20Interrupcoes%20e%20IO/slide_7_img_1.png)
![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.9%20-%20Excecoes%20Interrupcoes%20e%20IO/slide_7_img_2.png)
![Imagem Embutida 3](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.9%20-%20Excecoes%20Interrupcoes%20e%20IO/slide_7_img_3.png)

**A Evolução para os Processadores Atuais**

A esmagadora maioria dos processadores x86-64 modernos incorporou as funcionalidades das pontes norte (e de partes vitais da ponte sul) diretamente para dentro da pastilha de silício (die) da CPU (tornando-se um SoC ou trazendo o controlador de memória *on-die*).

A ideia dos projetistas é reduzir as latências e os atrasos no circuito elétrico, criando controladores altamente otimizados e fisicamente adjacentes aos núcleos de processamento. No entanto, o encapsulamento gerou alguns novos **Problemas**:
- Agora quase tudo deve possuir linhas de barramento e se comunicar "diretamente com a CPU".
- Gasta-se uma área valiosa do chip (*die space*) do processador implementando funções lógicas de controladores de memória e PCI, encarecendo a manufatura.
- É necessário um número muito maior de pinos extras no pacote (socket) do processador para acomodar todas as linhas de dados, pois a filtragem que as pontes externas da placa-mãe faziam deixou de existir. As trilhas têm que sair direto dos contatos da CPU para os slots PCIe ou slots de RAM.
- Embora ainda tenhamos pequenos chips "hubs" modernos nas placas-mães (o PCH na Intel, ou o chipset AM4/AM5 na AMD), eles lidam com um subconjunto de interfaces mais lentas (como USBs e SATAs adicionais) e atuam repassando essas informações para o elo principal dentro do processador.

Alguns reflexos da arquitetura de pinos:
- **Intel Xeon para Socket PPGA604** (ano 2006): Contava com apenas **604 pinos** (nesta época o controlador de memória ficava na placa-mãe, limitando o gargalo na CPU).
- **Intel Core i9-9900k para Socket FCLGA1151** (ano 2019): Saltou para **1151 pinos**.
- Em segmentos para servidores de alta densidade como o **Xeon Scalable em socket LGA 3647**, temos CPUs monstruosas operando com incríveis **3647 pinos**.

---

### Exercícios Propostos

1. Abra o simulador Mars e verifique que processadores MIPS realmente possuem os registradores `cause` e `EPC`. Eles ficam na aba “Coproc 0” — o *Coproc 0* é comumente o coprocessador de exceções e sistema do MIPS, enquanto o *Coproc 1* é reservado para o coprocessador de operações de ponto flutuante (FPU).
2. Note que múltiplas exceções podem ocorrer ao mesmo tempo no pipeline. Por exemplo, ao mesmo tempo que uma instrução na etapa `EX` gera um overflow aritmético, outra gera uma exceção de "instrução inválida" no estágio `ID`, e simultaneamente o carregamento de uma instrução em `IF` dispara uma violação de endereço da memória de instruções. Como você trataria uma situação caótica como essa? Qual exceção deveria ter primazia ou ser priorizada pelo controle do processador?
3. O Sistema Operacional é o componente central responsável por tratar as exceções de software e hardware. O detalhe é que o próprio S.O. também é um programa de computador clássico, que inevitavelmente utiliza a mesma estrutura de registradores de uso geral que o programa do usuário estava utilizando na CPU. Descreva conceitualmente o trecho de código (um prologo e um epilogo) que o S.O. deve sempre executar sistematicamente antes de iniciar a análise de uma causa de erro e depois de concluído o tratamento da exceção. Esse mecanismo é necessário para assegurar que o contexto das informações nos registradores não seja sobrescrito pelo Kernel e irreparavelmente perdido, permitindo assim que o seu programa possa continuar a execução normal após a interrupção (caso o S.O. aprove o retorno à atividade).
4. **Pesquisa extra:** O que é DMA (*Direct Memory Access*), e como ele minimiza a intervenção e a penalidade do processador na transferência de grandes blocos de dados entre a memória e periféricos lentos?

---

### Referências

- D. Patterson; J. Henessy. *Organização e Projeto de Computadores: Interface Hardware/Software*. 5ª Edição. Elsevier Brasil, 2017.
- TANENBAUM, Andrew S. *Sistemas operacionais modernos*. 10. ed. Pearson Education do Brasil, 2018.
- STALLINGS, William. *Arquitetura e organização de computadores*. 8. ed. São Paulo: Pearson Education do Brasil, 2010.
- J. Henessy; D. Patterson. *Arquitetura de computadores: Uma abordagem quantitativa*. 5ª Edição. Elsevier Brasil, 2014.
