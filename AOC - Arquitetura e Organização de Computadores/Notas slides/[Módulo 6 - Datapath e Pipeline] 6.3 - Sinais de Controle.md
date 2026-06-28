# [Módulo 6 - Datapath e Pipeline] 6.3 - Sinais de Controle

### Revisão: Caminho de Dados

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.3%20-%20Sinais%20de%20Controle/slide_1_img_1.png)

![Imagem Embutida 4](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.3%20-%20Sinais%20de%20Controle/slide_1_img_4.png)

### Controle da ALU

Temos uma unidade de controle exclusiva da ALU (e outra geral).
Sinal ALU Operation de 4 bits.
O sinal enviado para a ALU vai depender da instrução, por exemplo:
- `lw` e `sw` precisam calcular o endereço através de uma adição: `0010` (em binário)
- `beq` precisa realizar uma subtração (`0110` em binário) para verificar se os valores são iguais
- Instruções do tipo-R devem ter a operação definida pelo campo `funct` de 6 bits da instrução

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.3%20-%20Sinais%20de%20Controle/slide_2_img_1.png)

A unidade de controle da ALU vai receber como entrada um sinal de 2 bits, chamado `ALUOp`, que vai definir o tipo da instrução, e também vai receber o sinal do campo `funct`.

Sinais `ALUOp`:
- `00` (em binário) -> indica que a operação é uma adição (para `lw` e `sw`)
- `01` (em binário) -> indica que a operação é uma subtração (para `beq`/`bne`)
- `10` (em binário) -> indica que a operação vai ser definida pelo campo `funct` (tipo-R)

### Controle da ALU: Tabela Verdade

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.3%20-%20Sinais%20de%20Controle/slide_2_img_2.png)

`ALUOp` e Funct field: entradas do Controle da ALU.
ALU control input (ALU Operation): saída para a ALU.

Os dois primeiros campos do `funct` não são relevantes na escolha da operação.
No entanto, todos os campos de `funct` serão enviados para o controle da ALU, pois uma implementação mais ampla do MIPS pode precisar desses campos.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.3%20-%20Sinais%20de%20Controle/slide_3_img_1.png)

Dada a tabela verdade, podemos agora construir o Controle da ALU.
Podemos definir a expressão Booleana para a ALU, simplificá-la, e implementá-la com portas lógicas.
Exemplo: utilizar soma dos produtos, e então simplificar a expressão lógica pelos teoremas e leis booleanas.

O controle da ALU gera o sinal ALU Operation de 4 bits.
Mas depende de um sinal `ALUOp` de 2 bits.

O sinal `ALUOp` vai ser gerado pela unidade de controle principal.
- Múltiplos níveis de unidades de controle
- Mais simples projetar
- Possível redução no tamanho do circuito
- Possível aumento de velocidade
- Unidades mais simples processam a informação mais rapidamente do que uma única unidade grande
- Redução do período do ciclo de clock (principalmente quando considerarmos pipelining)

### Unidade de Controle Principal

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.3%20-%20Sinais%20de%20Controle/slide_4_img_1.png)

Podemos agora criar uma unidade de controle principal.
- Vai cuidar das 7 linhas de controle (de 1 bit) e do sinal de controle de dois bits `ALUOp`.

### Exercício de Verificação de Sinais

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.3%20-%20Sinais%20de%20Controle/slide_4_img_2.png)

Verifique os sinais no circuito, e escreva na tabela o que se espera quando cada um dos sinais é 0 ou 1. O resultado em `RegDST` está descrito como exemplo.

![Imagem Embutida 3](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.3%20-%20Sinais%20de%20Controle/slide_4_img_3.png)

Verifique os sinais no circuito, e escreva na tabela o que se espera quando cada um dos sinais é 0 ou 1. O resultado em `RegDST` está descrito como exemplo.

### Tabela Verdade da Unidade de Controle

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.3%20-%20Sinais%20de%20Controle/slide_5_img_1.png)

### Unidade de Controle

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.3%20-%20Sinais%20de%20Controle/slide_5_img_2.png)

### Controle Hardwired e Microcódigo

Nossa unidade de controle é simples e pode ser do tipo "hardwired".
Definida com portas lógicas e de comportamento fixo.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.3%20-%20Sinais%20de%20Controle/slide_6_img_1.png)

Em projetos complexos podemos criar unidades de controle programáveis.
O programa na unidade de controle dita como os sinais de controle são gerados de acordo com as entradas: O programa é chamado de microcódigo.
- Utilizado na maioria das CPUs.
- Temos uma maior flexibilidade.
- Podemos realizar correções no hardware "on-the-fly".
- Assim que a Intel "corrigiu" as falhas de segurança Spectre e Meltdown em suas CPUs sem precisar trocá-las.
- No Linux, abra um terminal e digite `dmesg | grep microcode` para verificar sua versão de microcódigo na CPU.
- Muitas vezes o microcódigo é chamado de firmware.
- O programa que controla o fluxo interno do hardware.
- Não cobriremos os detalhes sobre microcódigo em nossa disciplina introdutória.

### Exercícios Finais

1. Adicione o circuito para realizar jumps em nosso processador. Ligue os sinais de controle, e se necessário crie novos, indicando na tabela verdade quais as entradas e saídas necessárias para os sinais de controle dessa instrução.
2. Considerando as instruções implementadas até o momento, qual a instrução que você considera que demora mais tempo e qual demora menos tempo para ser executada? Uma adição? Loads? Stores? `beq`? `jump`? ... Explique.
3. Adicionando mais um sinal de controle, `BranchNE`, e portas lógicas, indique as alterações no caminho de dados para a implementação da instrução `bne`.

### Referências
- D. Patterson; J. Henessy. Organização e Projeto de Computadores: Interface Hardware/Software. 5a Edição. Elsevier Brasil, 2017.
- Andrew S. Tanenbaum. Organização estruturada de computadores. 5. ed. São Paulo: Pearson, 2007.
- Harris, D. and Harris, S. Digital Design and Computer Architecture. 2a ed. 2012.
- courses.missouristate.edu/KenVollmar/mars/
