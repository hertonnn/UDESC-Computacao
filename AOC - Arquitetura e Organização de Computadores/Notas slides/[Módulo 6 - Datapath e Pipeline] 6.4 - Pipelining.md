# [Módulo 6 - Datapath e Pipeline] 6.4 - Pipelining

### Duração das Instruções

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.4%20-%20Pipelining/slide_1_img_1.png)

Qual tipo de instrução nos toma mais tempo?
- Provavelmente instruções que lidam com a memória, principalmente loads
  - Passam por cinco unidades funcionais em série: Memória de instruções, banco de registradores, ALU, memória de dados, banco de registradores.

E qual tipo mais rápido?
- Provavelmente os jumps
  - Após a memória de instruções, basta fazer o shift left do imediato, e concatenar com o PC.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.4%20-%20Pipelining/slide_2_img_1.png)

Temos instruções que em teoria levam tempos diferentes para serem executadas.
Considere um exemplo com o tempo gasto por cada componente (busca de instruções, banco de registradores, operação na ALU, ...) em picossegundos.
- 1 ps = $10^{-12}$ segundos

### Problemas do Ciclo Único

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.4%20-%20Pipelining/slide_2_img_2.png)

Componentes de estado são sincronizados por um sinal de clock.
O clock deve ser longo o suficiente para dar tempo da instrução ser executada.
Devemos então considerar o pior caso, e ter um período de clock de 800ps (no exemplo).
- Esperar 800ps para carregar a próxima instrução.
- Se a instrução "não necessita" todos os 800ps, jogamos tempo fora.

### Ordem de Execução em Ciclo Único

![Imagem Embutida 3](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.4%20-%20Pipelining/slide_2_img_3.png)

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.4%20-%20Pipelining/slide_3_img_1.png)

### Onde Ciclo Único é Usado

Processadores extremamente simples podem usar ciclo único (talvez como a nossa versão do processador MIPS).
- Poucas instruções, e o caminho de dados completo é curto.
- Impacto no tempo de ciclo pode ser relativamente pequeno.

Mas se adicionarmos mais complexidade ao nosso circuito, um tamanho de ciclo que considera o pior caso se torna impraticável.
- Exemplo: unidades para ponto flutuante.

### Pipelining e Analogia da Lavanderia

A técnica de pipelining é utilizada em praticamente todos processadores atuais.
Transformamos o processador em uma "linha de montagem".

Vamos começar com uma analogia de exemplo onde precisamos "lavar roupas":
- Temos quatro estágios:
  - Lavadora de roupas
  - Secadora de roupas
  - Mesa de passar roupas
  - Armário

#### Lavando Roupas Sem um Pipeline

Considere que temos 4 trouxas de roupa (A, B, C e D) para lavar, e que cada estágio (ex: lavar a roupa) demora 30 minutos.
Sem aumentar os recursos (ainda temos uma lavadora, uma secadora, ...), como você poderia otimizar esse processo?

#### Lavando Roupas Com um Pipeline

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.4%20-%20Pipelining/slide_4_img_1.png)

Após a máquina de lavar terminar a trouxa A, transfere-se a trouxa para a secadora.
A próxima trouxa já é inserida na máquina de lavar, enquanto a secadora continua o processo com a trouxa anterior.
- A máquina de lavar nunca fica ociosa.
- Repetimos o processo para os demais componentes.

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.4%20-%20Pipelining/slide_4_img_2.png)

#### Onde Está o Ganho de Tempo?

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.4%20-%20Pipelining/slide_5_img_1.png)

O tempo para executar uma tarefa completa muda?
- Não. No exemplo, lavar uma trouxa de roupas ainda demora 2 horas.
- Se nosso objetivo fosse lavar uma única trouxa de roupas, não haveria ganho algum.

Onde está o ganho de tempo?
- Temos múltiplas trouxas sendo "processadas" em paralelo, cada uma em um estágio.

Considerando que todos os estágios duram o mesmo tempo, qual o ganho de tempo se dividirmos o processo em *n* estágios (no exemplo *n*=4)?
- Temos o potencial para executar nossas tarefas *n* vezes mais rápido.
- Mas para isso nosso pipeline sempre deve estar cheio.
- No início das tarefas, e no fim, sempre temos "unidades" vazias.

#### Resumo de Pipelining

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.4%20-%20Pipelining/slide_5_img_2.png)

Não aumentamos o tamanho de nossa lavanderia.
Se olharmos para uma única tarefa, do início ao fim, o tempo para sua execução não muda.
- O tempo de execução de uma instrução "não muda" (não é bem assim... detalhes na sequência).
- O tempo gasto para uma instrução individual também é chamado de latência.

Mas se olharmos um período de tempo suficientemente longo, o número de tarefas completadas nesse tempo é muito maior.
- A vazão (throughput) pode aumentar em até *n* vezes.

### Pipeline na CPU MIPS

![Imagem Embutida 3](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.4%20-%20Pipelining/slide_5_img_3.png)

Vamos aplicar a ideia da lavadora de roupas no processador MIPS.
Quais são os estágios?
- Buscar a instrução na memória: Instruction fetch (IF)
- Ler os registradores enquanto a unidade de controle a decodifica: Instruction decoding (ID)
- Executar a operação / cálculo do endereço: Execution (EX)
- Acessar a memória de dados: Memory Access (MEM)
- Escrever o resultado num registrador: Write Back (WB)

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.4%20-%20Pipelining/slide_6_img_1.png)

Nosso processador pode ser então dividido em 5 estágios.
- A quantidade de estágios depende diretamente da arquitetura do processador.

### Ajustando o Tempo de Clock

Veja mais uma vez o tempo gasto em cada unidade funcional.
Cada unidade nos representa um estágio no pipeline.

Tempo de clock:
- Sem pipeline, somamos tudo e ajustamos para o pior caso (800ps).
- Dado que o clock é fixo, qual o tempo de clock se adicionarmos o pipeline?
  - Com o pipeline, ajustamos para o estágio de pior caso.
  - Os estágios mais demorados precisam de 200ps.
  - Logo, o tempo de clock deve ser de no mínimo 200ps.

Já temos uma limitação:
- O ganho seria de *n* vezes o número de estágios se todos durassem o mesmo tempo.

Na prática, nosso ganho vai ser:
`proporção do aumento de vazão = Tempo do ciclo sem pipeline / Tempo do ciclo para a unidade mais lenta`

Em nosso processador MIPS com os números do exemplo:
`proporção do aumento de vazão = 800 / 200 = 4`

Temos 5 estágios, potencial para até 5 vezes mais rápido, porém, neste caso é 4 vezes mais rápido.

### Ciclo Único versus Pipeline

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.4%20-%20Pipelining/slide_6_img_2.png)

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.4%20-%20Pipelining/slide_7_img_1.png)

### Exercícios Finais

1. Considere que criamos um pipeline em um processador qualquer. Ao olhar para o tempo de execução de uma única instrução (latência) na versão com pipeline desse processador, esse tempo:
   - Pode ser menor que o tempo do processador sem pipeline?
   - Pode ser igual o tempo do processador sem pipeline?
   - Pode ser maior que o tempo do processador sem pipeline?
   Confirme ou refute cada uma das afirmações, explicando detalhadamente.
2. Toda instrução no MIPS possui o mesmo tamanho. Como isso nos ajuda no pipeline?
   - Se as instruções fossem de tamanho variável, em qual estágio do pipeline precisaríamos estar para só então definir onde está a próxima instrução?
   - Observação: seu processador x86-64 possui instruções de tamanho variável, e precisa tratar essa complexidade extra.

### Referências
- D. Patterson; J. Henessy. Organização e Projeto de Computadores: Interface Hardware/Software. 5a Edição. Elsevier Brasil, 2017.
- Andrew S. Tanenbaum. Organização estruturada de computadores. 5. ed. São Paulo: Pearson, 2007.
- Harris, D. and Harris, S. Digital Design and Computer Architecture. 2a ed. 2012.
- courses.missouristate.edu/KenVollmar/mars/
