# Construindo a CPU: Parte 1

### Implementação Básica
Vamos construir um processador MIPS básico, que implementa o seguinte:
- Instruções de referência à memória: `sw` e `lw`
- Instruções lógicas e aritméticas tipo-R: `add`, `sub`, `and`, `or` e `slt`
- Instruções lógicas e aritméticas tipo-I: `addi`, `andi` e `ori`
- Instruções de desvio: `beq` e `j`

Seguiremos a implementação descrita no livro base da disciplina:
- D. Patterson; J. Henessy. Organização e Projeto de Computadores: Interface Hardware/Software. 5ª Edição. Elsevier Brasil, 2017.

### O Formato das Instruções
Até o momento, aprendemos os formatos básicos de instruções MIPS:
- Tipo R
- Tipo I
- Tipo J

Devemos considerar:
- Tamanho das instruções (sempre 32 bits no MIPS)
- Tamanho do *opcode*
- Outros campos conforme o tipo

Veremos que isso impacta diretamente no hardware. O conjunto de instruções e a forma com que o hardware é implementado são diretamente relacionados.

![Imagem Embutida 4](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.1%20-%20Construindo%20a%20CPU%20Parte%201/slide_2_img_4.png)

### Convenções Iniciais
O tamanho da palavra no MIPS é de 32 bits. Assumiremos que as linhas de conexão no nosso projeto são, na verdade, um barramento de 32 bits, como se tivéssemos 32 fios em paralelo. Caso o barramento tenha uma largura diferente de 32, isso será indicado colocando-se a largura do barramento acompanhada do número de bits. 
Exemplos:
- Um barramento de 32 bits: indicado com 32 (conforme o traço transversal na linha).
- Um barramento de 16 bits: indicado com 16.

Para sinais de controle (em azul) um único fio para um único bit é utilizado.

### O Caminho de Dados
Vamos analisar os principais componentes que precisamos para executar um programa:
- **Uma memória**, para armazenar as instruções do nosso programa.
  - Entrada: O endereço da instrução desejada.
  - Saída: A instrução no endereço apontado.
- **Um registrador** que vai armazenar o endereço da próxima instrução a ser executada: Registrador PC (*Program Counter*) no MIPS.
  - Entrada: O próximo endereço a ser armazenado no registrador.
  - Saída: O endereço corrente.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.1%20-%20Construindo%20a%20CPU%20Parte%201/slide_3_img_1.png)
![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.1%20-%20Construindo%20a%20CPU%20Parte%201/slide_3_img_2.png)
![Imagem Embutida 3](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.1%20-%20Construindo%20a%20CPU%20Parte%201/slide_3_img_3.png)
![Imagem Embutida 4](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.1%20-%20Construindo%20a%20CPU%20Parte%201/slide_3_img_4.png)

### Incrementando o PC
Caso não tenhamos desvios, após a execução da instrução atual, devemos executar a próxima instrução. O que devemos fazer com o PC? Como?
Precisamos adicionar 4 no valor atual do `pc`. A memória é endereçada em bytes, logo "saltamos" 4 bytes, o que equivale a 32 bits.

Para isso, vamos precisar de um somador. Podemos, por exemplo, utilizar o circuito somador estudado em Sistemas Digitais (ineficiente, mas funciona). O símbolo geral utilizado para uma Unidade Lógica Aritmética (ULA ou ALU) indica quando a unidade deve realizar somas.

### Sincronização
Sinais de clock são adicionados nos elementos de estado (sequenciais). Por exemplo, o registrador `pc` só vai ler a entrada na transição de *clock*. Enquanto não há transição, o valor antigo de PC é enviado para a saída, e lido pelo *adder* (somador).

Nos nossos circuitos, o sinal de *clock* vai ser omitido para simplificar o raciocínio, mas sempre assuma que existe sincronismo, para que o sinal anterior não seja "atropelado" pelo próximo.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.1%20-%20Construindo%20a%20CPU%20Parte%201/slide_4_img_1.png)
![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.1%20-%20Construindo%20a%20CPU%20Parte%201/slide_4_img_2.png)

### PC e Memória de Instrução
O "loop" principal está pronto: sempre enviamos a instrução para execução, e incrementamos `pc` em 4 para apontar para a próxima instrução. O que é feito com a instrução agora depende do seu formato.

Vamos começar com instruções básicas do tipo-R.

### Instruções do Tipo-R
Exemplo:
```mips
add $a0, $a1, $a2
```
Instruções do tipo-R leem dois registradores, executam uma operação aritmética em uma ALU (soma, subtração, deslocamento, etc.), e armazenam o resultado em um terceiro registrador.

### Banco de Registradores
Precisamos de uma estrutura denominada banco de registradores. Ele vai conter todos os 32 registradores do MIPS.

**Entradas:**
- Endereço do registrador de leitura 1
- Endereço do registrador de leitura 2
- Endereço do registrador de escrita
- Dados a serem escritos no registrador de escrita

**Saídas:**
- Dados do registrador de leitura 1
- Dados do registrador de leitura 2

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.1%20-%20Construindo%20a%20CPU%20Parte%201/slide_5_img_1.png)
![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.1%20-%20Construindo%20a%20CPU%20Parte%201/slide_5_img_2.png)

### Fonte dos Bits
Como definimos, uma linha sem marcação tem largura de 32 bits. Então na verdade são 32 linhas (barramento), endereçadas de 0 a 31. Conforme o livro, vamos seguir uma abordagem *little-endian*, onde a instrução fica "ao contrário" no endereçamento.

### ALU (Unidade Lógica Aritmética)
Além de precisar dos registradores, as instruções precisam executar a operação com esses registradores (soma, subtração, deslocamento, lógicas, etc). Vamos utilizar uma ALU geral para isso.

**Entradas:**
- Dois valores de 32 bits
- Uma entrada `ALUop` de 4 bits, que define qual a operação deve ser realizada com os valores

**Saídas:**
- Uma saída de 32 bits com o resultado da operação
- Uma saída de 1 bit indicando se o resultado da operação foi zero (Essa saída simplificará a construção do nosso circuito em breve)

Dentro da ALU podemos ter diversos circuitos especialistas:
- Somadores
- Operadores Lógicos

Qual desses circuitos será ativado depende do sinal de `ALUOp`.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.1%20-%20Construindo%20a%20CPU%20Parte%201/slide_6_img_1.png)
![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.1%20-%20Construindo%20a%20CPU%20Parte%201/slide_6_img_2.png)
![Imagem Embutida 3](./imagens/%5BM%C3%B3dulo%206%20-%20Datapath%20e%20Pipeline%5D%206.1%20-%20Construindo%20a%20CPU%20Parte%201/slide_6_img_3.png)

### Exercícios

**1)** Sem olhar os slides anteriores, utilizando os seguintes componentes, monte novamente o processador capaz de executar instruções do tipo R básicas. Marque no circuito a largura de cada barramento. Caso o barramento utilize somente algumas linhas de outro (e.g., número do registrador de entrada), indique quais as linhas que são utilizadas por ele através da notação `[n-m]`.

**2)** Os 4 bits que informam a ALU sobre qual a operação que deve ser executada podem vir de onde? Não precisa ligar no circuito, mas dê suas ideias sobre como poderíamos definir isso.

**3)** A seguir é dado um multiplexador, com duas entradas de 32 bits e uma saída de 32 bits. A entrada superior é enviada para a saída se o bit `S=0`, caso contrário, a entrada inferior é enviada para a saída. Compare as instruções do tipo R com instruções de *load*/*store* (`lw`, `sw`) (tipo I). Quais registradores (fonte 1, fonte 2 e destino) podem mudar de acordo com o tipo da instrução? Adicione o multiplexador no seu circuito para resolver esse problema. No momento não precisa se preocupar em onde ligar a entrada `S`.

### Referências
- D. Patterson; J. Henessy. Organização e Projeto de Computadores: Interface Hardware/Software. 5ª Edição. Elsevier Brasil, 2017.
- Andrew S. Tanenbaum. Organização estruturada de computadores. 5. ed. São Paulo: Pearson, 2007.
- Harris, D. and Harris, S. Digital Design and Computer Architecture. 2ª ed. 2012.
- courses.missouristate.edu/KenVollmar/mars/
