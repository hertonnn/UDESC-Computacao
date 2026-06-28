# Módulo 5 - MIPS e Assembly
## 5.2 - Conjuntos de Instruções: Lidando com a Memória e Operações Lógicas

![Imagem Embutida 3](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.2%20-%20Conjuntos%20de%20Instrucoes%20Lidando%20com%20Memoria/slide_1_img_3.png)

### Revisão: Palavra de Dados e Instruções no MIPS
**Palavra de Dados (word):**
- Tamanho: 32 bits

**Instruções:**
- Tamanho: Todas possuem 32 bits
- Tipos vistos até o momento:
  - Tipo-R
  - Tipo-I
- Ainda estudaremos o tipo-J em aulas futuras.

### Revisão: Registradores do MIPS
*(Nota: Neste ponto, pressupõe-se a revisão da estrutura de registradores de uso geral e temporários do MIPS abordados em módulos anteriores, como `$s0` a `$s7` e `$t0` a `$t9`)*

---

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.2%20-%20Conjuntos%20de%20Instrucoes%20Lidando%20com%20Memoria/slide_2_img_1.png)

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.2%20-%20Conjuntos%20de%20Instrucoes%20Lidando%20com%20Memoria/slide_2_img_2.png)

### Comentários e Números no MIPS
No MIPS Assembly, o caractere `#` inicia um comentário e faz o montador ignorar o restante da linha. É altamente recomendado comentar bem o seu código. Como sugestão de estilo, pode-se utilizar dois espaços antes e um depois do `#`.

No código abaixo, `main` e `end` são **rótulos (labels)**. Podemos utilizar esses rótulos em nossas instruções ao invés de utilizarmos diretamente os endereços de memória físicos.

```mips
.text
.globl main

main:
    li $t0, 011     # Número decimal 9 escrito em formato octal
    li $t1, 22      # Número decimal 22
    li $t2, 0xFF    # Número decimal 255 escrito em formato hexadecimal

end:
    li $v0, 10      # Código para encerrar o programa na chamada de sistema
    syscall         # Encerra o programa
```

### Acessando a Memória Principal
A memória principal funciona logicamente como um "vetor ou array", onde cada posição possui um endereço físico. 

As memórias são comumente endereçadas **byte a byte**. Isso significa que cada byte possui um endereço físico distinto, e cada endereço suporta exatamente 1 byte (8 bits) de dados.

Considere o seguinte exemplo na linguagem C:
```c
int x = 0x0F; // em C, o prefixo 0x indica um valor em hexadecimal
int v[2] = {0x01, 0x00FFAA1D};
```
Um vetor na memória é uma estrutura que inicia em uma posição de memória fixa (endereço base), e cada nova posição deste vetor é acessada a partir de um deslocamento (*offset*) em relação à posição inicial.

Podemos representar a organização na memória da seguinte forma (considerando a arquitetura *big-endian*, e assumindo que números inteiros ocupam 32 bits, ou seja, 4 bytes):
- A variável `x` está localizada no endereço 0, e ocupa 4 posições na memória (endereços 0, 1, 2 e 3).
- O vetor `v` começa no endereço 4 (o ponteiro com o endereço base de `v` aponta para 4).
- `v[0]` é o mesmo que acessar o endereço base de `v` deslocado em 0 endereços de 1 byte (4 + 0 = endereço 4).
- `v[1]` é o mesmo que acessar o endereço base de `v` deslocado em 4 endereços de 1 byte (4 + 4 = endereço 8).

Deslocamos em múltiplos de 4 porque cada inteiro ocupa 4 bytes neste exemplo. O valor numérico dos deslocamentos mudaria dependendo do tipo da variável (por exemplo, usaríamos deslocamento de 1 byte para variáveis do tipo `char`).

---

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.2%20-%20Conjuntos%20de%20Instrucoes%20Lidando%20com%20Memoria/slide_3_img_1.png)

### Instruções de Carga e Armazenamento (Loads e Stores)
No MIPS, operamos dados realizando cálculos **somente** nos valores armazenados nos registradores. Sempre precisamos carregar dados da memória principal para os registradores antes de usá-los, e armazenar os resultados de volta na memória principal.

Para essas operações de transferência, utilizamos as instruções de **loads** e **stores**, que pertencem às instruções do **Tipo-I**.

- **`lw` (Load Word)**: Carrega uma palavra da memória para o registrador.
  - Sintaxe: `lw $regDestino, deslocamento($regBase)`
  - Operação: `$regDestino = MEM[$regBase + deslocamento]`
  - O `deslocamento` é um valor imediato de 16 bits.
- **`sw` (Store Word)**: Armazena uma palavra de um registrador para a memória.
  - Sintaxe: `sw $regFonte, deslocamento($regBase)`
  - Operação: `MEM[$regBase + deslocamento] = $regFonte`

Exemplo:
```mips
lw $t0, 32($s3) # Carrega no $t0 a palavra localizada no endereço ($s3 + 32)
```

### Exemplo Prático: Lendo e Gravando Arrays

```mips
.data
vector:
    .word 3    # v[0] = 3
    .word 5    # v[1] = 5

.text
.globl main
main:
    la $t0, vector     # Carrega o endereço base de 'vector' no registrador $t0
    lw $t1, 4($t0)     # Carrega o valor de v[1] em $t1 (deslocamento de 4 bytes a partir do endereço base)
                       # $t1 = 5
    addi $t1, $t1, 6   # Incrementa $t1 em 6 ($t1 += 6). Agora $t1 = 11
    sw $t1, 8($t0)     # Armazena o valor de $t1 na posição v[2] (deslocamento de 8 bytes do endereço base)
                       # v[2] = $t1 (11)
end:
    li $v0, 10         # Código para encerrar o programa
    syscall            # Encerra o programa
```
Na seção `.data` (linhas iniciais do código), estamos estabelecendo os valores iniciais no espaço de dados da memória. A instrução `la` (Load Address) é uma pseudoinstrução utilizada para carregar um **endereço** de memória (não os dados contidos nele) para um registrador.

### Exercício de Tradução: C para MIPS
Considere o trecho de código em C abaixo. Tente traduzi-lo para assembly do MIPS:

```c
int v[4] = {3, 7, 5, 1};
v[2] = 87 + v[3];
```

**Solução:**
```mips
.data
vector:
    .word 3    # v[0] = 3 (Deslocamento 0)
    .word 7    # v[1] = 7 (Deslocamento +4)
    .word 5    # v[2] = 5 (Deslocamento +8)
    .word 1    # v[3] = 1 (Deslocamento +12)

.text
.globl main
main:
    la $t0, vector     # Carrega o endereço base de 'vector' em $t0
    lw $t1, 12($t0)    # Lê o valor de v[3] e salva em $t1
                       # $t1 = 1
    addi $t1, $t1, 87  # Soma 87 ao valor armazenado em $t1 ($t1 = 1 + 87)
                       # $t1 = 88
    sw $t1, 8($t0)     # Armazena o valor atualizado de $t1 na posição de memória de v[2]
                       # v[2] = 88
end:
    li $v0, 10         # Código para encerrar o programa
    syscall            # Encerra o programa
```

---

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.2%20-%20Conjuntos%20de%20Instrucoes%20Lidando%20com%20Memoria/slide_4_img_1.png)

### Operações Lógicas: Deslocamentos (Shifts)
As operações lógicas bit a bit pertencem às instruções do **Tipo-R**. 
Os deslocamentos (shifts) permitem mover todos os bits de uma palavra para a esquerda ou direita em um registrador.

- **`sll` (Shift Left Logical - Deslocamento Lógico à Esquerda)**
  Desloca os bits da palavra para a esquerda de acordo com o valor especificado. As lacunas geradas à direita são preenchidas com zeros.
  - Sintaxe: `sll $RegDestino, $RegFonte, deslocamento`
  
  Exemplo: `sll $t2, $s0, 4`
  Se `$s0` possuía: `0000 0000 0000 0000 0000 0000 0000 1001`
  Após o shift, `$t2` conterá: `0000 0000 0000 0000 0000 0000 1001 0000`

- **`srl` (Shift Right Logical - Deslocamento Lógico à Direita)**
  Desloca os bits da palavra para a direita de acordo com o valor especificado. As lacunas geradas à esquerda são preenchidas com zeros.
  - Sintaxe: `srl $RegDestino, $RegFonte, deslocamento`
  
  Exemplo: `srl $t2, $s0, 2`
  Se `$s0` possuía: `0000 0000 0000 0000 0000 1111 0000 1011`
  Após o shift, `$t2` conterá: `0000 0000 0000 0000 0000 0011 1100 0010`

**Qual a utilidade dos shifts?**
Dentre outros usos, ao realizarmos um shift lógico para a esquerda de *n* bits, estamos efetivamente **multiplicando o valor original por 2^n**. Lidar com potências de 2 na máquina é uma operação muito comum em linguagens de baixo nível. A unidade aritmética (ALU) responsável por fazer *shifts* é extremamente simples e de execução rápida. Por isso, utilizar um shift é consideravelmente mais rápido do que realizar uma multiplicação por 2 "clássica".

### Operações Lógicas: AND e OR

- **`and` (AND Lógico)**
  Realiza a operação de AND lógico bit a bit entre os registradores fonte e salva o resultado no destino.
  - Sintaxe: `and $t0, $t1, $t2` (Representa: `$t0 = $t1 & $t2`)

  Exemplo prático:
  `$t1`: `0000 0000 0000 0000 0000 0000 1101 0001`
  `$t2`: `0000 0000 0000 0000 0000 0000 1100 0000`
  Resultado em `$t0`: `0000 0000 0000 0000 0000 0000 1100 0000`

- **`or` (OR Lógico)**
  Realiza a operação de OR lógico bit a bit entre os registradores fonte e salva o resultado no destino.
  - Sintaxe: `or $t0, $t1, $t2` (Representa: `$t0 = $t1 | $t2`)

  Exemplo prático:
  `$t1`: `0000 0000 0000 0000 0000 0000 1101 0001`
  `$t2`: `0000 0000 0000 0000 0000 0000 1100 0000`
  Resultado em `$t0`: `0000 0000 0000 0000 0000 0000 1101 0001`

---

### Operações Lógicas: NOR
A última operação lógica fundamental e que estaria presente seria um `not` (inversão simples de bit).
Porém, se ela fosse implementada, essa operação tomaria apenas um registrador fonte e um registrador de destino, o que **não segue o formato padrão de 3 operandos de uma instrução do Tipo-R**. 

Para manter o padrão de *design* estrito das instruções e simplificar o hardware do processador, a operação `not` não existe nativamente. Em seu lugar, a operação **NOR** foi incluída no MIPS.

- **`nor` (NOR Lógico / OR-negado)**
  Realiza o OR lógico entre os bits dos registradores e em seguida nega (inverte) todo o resultado.
  - Sintaxe: `nor $t0, $t1, $t2` (Representa: `$t0 = ~($t1 | $t2)`)

  Exemplo prático:
  `$t1`: `0000 0000 0000 0000 0000 0000 1101 0001`
  `$t2`: `0000 0000 0000 0000 0000 0000 1100 0000`
  Resultado em `$t0`: `1111 1111 1111 1111 1111 1111 0010 1110`

**Como fazer um `not` utilizando `nor`?**
Para simularmos um `not`, basta aplicarmos o `nor` do registrador de interesse junto com o registrador especial `$zero`. O OR de qualquer bit com 0 resulta nele mesmo. Em seguida, o `nor` inverte todos os bits resultantes.
```mips
nor $t0, $t1, $zero # $t0 = ~$t1
```

### AND e OR com Imediatos
As instruções `and` e `or` possuem versões que lidam com valores imediatos de 16 bits.
```mips
ori $t0, $t1, 0xACDC  # $t0 = $t1 | 0xACDC
andi $t0, $t1, 0xACDC # $t0 = $t1 & 0xACDC
```

É muito comum utilizar o `ori` para carregar um valor constante (imediato) para dentro de um registrador, combinando o imediato com o registrador `$zero`:
Como podemos carregar o imediato `156` (em decimal) para o registrador `$s0` utilizando `ori`?
```mips
ori $s0, $zero, 156   # $s0 = 0 | 156 <==> $s0 = 156
```

Poderíamos fazer a carga deste imediato utilizando um `addi` ao invés de `ori`?
O problema reside no fato de que o `addi` **realiza extensão de sinal**. Ele copia o bit mais alto (mais significativo) do imediato (que tem 16 bits) para os bits mais altos do registrador (de 32 bits) se o somarmos com zero, usando a lógica de complemento de dois. 
- Isso não é um problema para constantes pequenas e positivas ($\le$ `0x7FFF`).
- No entanto, isso irá gerar problemas com imediatos maiores em que o bit mais significativo do imediato seja `1`, pois o topo do registrador será preenchido com `1`s (número negativo estendido).
- A instrução `addiu` (sem extensão de sinal limitadora) pode ser uma opção válida nestes casos. Mas, na prática, o montador (Assembler) costuma ajudar a resolver isso.

### Ação do Montador MIPS (Assembler)
Dependendo do contexto e do montador empregado (como o MARS ou Spim), o código que você escreve não é sempre traduzido diretamente para a máquina em formato 1:1. 
Muitas vezes, uma instrução `addi` atua como uma **pseudoinstrução** caso passe limites:

- Código original: `addi $t0, $zero, 0x7FFF`
  O Montador gera a instrução nativa real: `addi $8, $0, 0x7FFF`
- Código original: `addi $t0, $zero, 0x8000` *(Aqui o MSB é 1, `0x8000` causaria extensão de sinal)*
  O Montador do MARS traduz como:
  ```mips
  lui $1, 0x0000
  ori $1, $1, 0x8000
  add $8, $0, $1
  ```

---

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.2%20-%20Conjuntos%20de%20Instrucoes%20Lidando%20com%20Memoria/slide_6_img_1.png)

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.2%20-%20Conjuntos%20de%20Instrucoes%20Lidando%20com%20Memoria/slide_6_img_2.png)

### Carregando Imediatos de 32 Bits
Até agora, vimos `addi`, `addiu` e `ori`. Qual o maior imediato que podemos carregar diretamente com a instrução `ori`? 
Apenas um imediato de **16 bits**, pois esse é o tamanho máximo delimitado para o campo `constant` nas instruções do Tipo-I.

E como carregamos um imediato longo de **32 bits**?
Os registradores comportam 32 bits de dados. Mas será que podemos ter uma única instrução nativa capaz de carregar diretamente os imediatos de 32 bits?
- Toda instrução no MIPS tem rigorosamente 32 bits.
- Se criarmos uma instrução com a finalidade exclusiva de carregar um imediato de 32 bits, absolutamente todos os bits da instrução seriam utilizados para definir o imediato (o valor numérico). Não restaria espaço para o *opcode* da instrução (para o processador saber o que fazer) nem o número do registrador de destino.
- Conclusão: É impossível na arquitetura RISC do MIPS carregar 32 bits com uma única instrução nativa direta.

Para resolver isso, existe a instrução **`lui` (Load Upper Immediate)**:
- O `lui` carrega o imediato especificado (de 16 bits) diretamente para os 16 bits **mais significativos** (parte superior, *upper*) do registrador.
- Ele simultaneamente preenche o restante (a metade inferior) com zeros.
- Após isso, basta utilizarmos um `ori` para popularmos os 16 bits faltantes na parte inferior do registrador!

### A Pseudoinstrução `li` (Load Immediate)
Além das nativas `addi`, `addiu`, `ori` e `lui`, existe a **pseudoinstrução `li`** oferecida na maioria dos montadores MIPS.
O `li` é uma comodidade provida pelo montador, que carrega sem esforço um imediato de 32 bits sem o programador ter que dividir o valor manualmente utilizando `lui` e `ori`.

O montador destrincha a chamada de acordo com a grandeza e tipo do imediato solicitado:
- Código: `li $t0, 0x7FFF`
  Montador gera: `addiu $8, $0, 0x7FFF`
- Código: `li $t0, 0x8000`
  Montador gera: `ori $8, $0, 0x8000`
- Código: `li $t0, 0x100AA`
  Montador gera a dupla `lui` e `ori` utilizando seu registrador reservado `$1` (também conhecido como `$at`, assembler temporary):
  ```mips
  lui $1, 0x1
  ori $8, $1, 0xaa
  ```

---

### Exercícios

**1.** Carregue os seguintes imediatos para o registrador `$t0`. **Não** utilize a pseudoinstrução `li`.
1. `255` em decimal.
2. `987342343` em decimal.
3. `-987342343` em decimal.

**2.** Qual o código de máquina das instruções resultantes do exercício 1? Mostre isso em representação binária "encaixando" os bits em suas posições corretas em instruções do Tipo-R ou Tipo-I, dependendo das suas respostas ao exercício anterior.

**3.** Considere as variáveis `a`, `b`, `c` e `d` de um programa, que foram carregadas para os registradores `$s0`, `$s1`, `$s2` e `$s3`, respectivamente. Como fica o seguinte código escrito em C se traduzido para o assembly do MIPS? Considere que a variável `x` deve ser salva no registrador `$s4`.
```c
x = a + b + c - d - 747;
```

**4.** Faça um programa completo em MIPS equivalente ao código em C apresentado abaixo:
```c
int v[8] = {12, 3, 10, 7, 5, 1, 0, 99};
v[7] = v[1] + v[2] + v[3] + 42;
```

### Sumário de Algumas Instruções e Pseudoinstruções

**Carga/Armazenamento (Memória e Endereços)**
- `la` (Load Address)
- `lb` (Load Byte)
- `lbu` (Load Byte Unsigned)
- `li` (Load Immediate)
- `lui` (Load Upper Immediate)
- `lw` (Load Word)
- `sb` (Store Byte)
- `sw` (Store Word)

**Aritméticas e Transferência**
- `add` (Soma com sinal)
- `addi` (Soma Imediata)
- `addiu` (Soma Imediata Unsigned)
- `addu` (Soma Unsigned)
- `sub` (Subtração)
- `subi` (Subtração Imediata)
- `subiu` (Subtração Imediata Unsigned)
- `subu` (Subtração Unsigned)
- `mul` / `mult` / `div` / `divu` (Multiplicação e Divisão)
- `mfhi` / `mflo` (Move From HI/LO)
- `move` (Cópia de registradores)

**Lógicas e Deslocamentos**
- `and` / `andi` (AND Lógico)
- `or` / `ori` (OR Lógico)
- `nor` (NOR Lógico / OR Negado)
- `not` (NOT Lógico / Inversão)
- `sll` / `srl` (Shift Left/Right Logical)

**Outras**
- `syscall` (Chamada ao sistema / simulador)
