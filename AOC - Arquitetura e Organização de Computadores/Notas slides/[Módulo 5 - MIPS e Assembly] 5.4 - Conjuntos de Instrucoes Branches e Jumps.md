# Módulo 5 - MIPS e Assembly
## 5.4 - Conjuntos de Instruções: Branches e Jumps

### Convenção da Memória
![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.4%20-%20Conjuntos%20de%20Instrucoes%20Branches%20e%20Jumps/slide_1_img_1.png)

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.4%20-%20Conjuntos%20de%20Instrucoes%20Branches%20e%20Jumps/slide_1_img_2.png)

Existe uma convenção sobre como um programa e seus dados são alocados na memória principal da máquina (como a RAM). A distribuição exata pode mudar dependendo da implementação específica, mas, de maneira geral, temos divisões para o segmento de texto (onde ficam as instruções), o segmento de dados estáticos, o heap (alocação dinâmica) e a pilha (stack).

### Contador de Programa (Program Counter - PC)
Considere o seguinte trecho de programa em assembly do MIPS, onde a primeira coluna representa o endereço de memória de cada instrução:
```mips
0x00400000    ori $t2, $zero, 25
0x00400004    lw $t3, 0($s0)
0x00400008    add $t4, $t2, $t3
0x0040000C    sub $t5, $t2, $t3
```

O processador sabe qual é a próxima instrução a ser executada por meio de um registrador especial chamado de **Contador de Programa**, ou **PC** (*Program Counter*). Na arquitetura x86, esse registrador equivalente é chamado de IP (*Instruction Pointer*).
Diferente dos registradores de uso geral (como `$t0`, `$s0`), o registrador PC **não é diretamente visível ou acessível** ao programador para escrita ou leitura direta convencional.

#### Dinâmica do PC Durante a Execução
Durante a execução de um programa, o fluxo de operação é o seguinte:
1. O processador carrega (busca) a instrução no endereço apontado pelo registrador PC.
2. A primeira coisa que o processador faz em seguida é acrescentar `+4` ao valor do PC para que ele passe a apontar para a próxima instrução.
   - *Por que +4?* Porque cada instrução na arquitetura MIPS32 ocupa exatamente 4 bytes (32 bits).
3. O processador executa a instrução que acabou de ser carregada.
4. O processo se repete indefinidamente.

Abaixo ilustramos como o valor de `pc` muda a cada passo:
- Passo 1: `pc = 0x00400000` (executando `ori $t2, $zero, 25`)
- Passo 2: `pc = 0x00400004` (executando `lw $t3, 0($s0)`)
- Passo 3: `pc = 0x00400008` (executando `add $t4, $t2, $t3`)
- Passo 4: `pc = 0x0040000C` (executando `sub $t5, $t2, $t3`)

#### Restrições de Alinhamento
Como os demais registradores, o Contador de Programa armazena 32 bits. Isso levanta a questão: *Qual é o maior programa que podemos escrever em uma arquitetura MIPS de 32 bits?*
Teoricamente, o espaço de endereçamento é de $2^{32}$ = 4 GiB. Na prática, o tamanho de um programa é muito menor, pois o espaço não é composto apenas de instruções, havendo também as seções de pilha, heap e dados estáticos.

Considerando que a primeira instrução do programa está no endereço `0x00400000`, existe a possibilidade de, em algum momento, o PC conter o valor `0x00400003` na arquitetura MIPS32?
**Não.** Como toda instrução ocupa exatamente 32 bits (4 bytes) e a memória é endereçada byte a byte, os incrementos (ou saltos) sempre ocorrem de 4 em 4. As instruções devem sempre começar em um endereço múltiplo de 4. Isso é conhecido como **restrição de alinhamento**. 
*(Nota: Isso é comum em muitas arquiteturas RISC, mas vale notar que essa restrição de alinhamento de instruções não existe em arquiteturas CISC como a x86).*

### Branches: Desvios Condicionais

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.4%20-%20Conjuntos%20de%20Instrucoes%20Branches%20e%20Jumps/slide_4_img_1.png)

![Imagem Embutida 2](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.4%20-%20Conjuntos%20de%20Instrucoes%20Branches%20e%20Jumps/slide_4_img_2.png)

Instruções do tipo *branch* causam um "desvio" condicional no fluxo de execução do programa. São as instruções utilizadas para controle de fluxo e tomada de decisão (traduzindo lógicas de `if`, `while`, `for`).
Branches são instruções do **Formato I (Tipo-I)**.

- **beq** (*branch if equal* - desvie se igual):
  ```mips
  beq $s0, $s1, ENDEREÇO
  ```
  Se o valor no registrador `$s0` for igual ao valor no registrador `$s1`, o fluxo do programa salta para o `ENDEREÇO`.

- **bne** (*branch if not equal* - desvie se não igual):
  ```mips
  bne $s0, $s1, ENDEREÇO
  ```
  Se o valor no registrador `$s0` for diferente do valor no registrador `$s1`, o fluxo do programa salta para o `ENDEREÇO`.

#### O Cálculo do Endereço de Salto
Temos um problema de codificação em instruções do Tipo-I: o campo imediato disponível para o endereço tem apenas 16 bits. Se o campo `ENDEREÇO` armazenasse o endereço absoluto da instrução na memória, nenhum programa poderia conter saltos para além de $2^{16}$ = 64 Kbytes de espaço de endereçamento.

**A Solução: Endereçamento Relativo ao PC**
Na maior parte dos casos, os desvios em loops e comandos condicionais são tomados para instruções fisicamente próximas da instrução atual. Sabendo que o registrador PC já aponta para a próxima instrução a ser executada, o valor de `ENDEREÇO` na instrução de branch é na verdade um **salto relativo ao PC**.

Para otimizar o alcance e aumentar a distância possível do desvio, este "salto" codificado no branch não é expresso em bytes, mas sim em **palavras de instrução (blocos de 4 bytes)**. O valor do salto é com sinal (complemento de dois), podendo ser positivo (saltar para frente) ou negativo (saltar para trás, comum em loops).
Isso dá ao branch um alcance relativo de $\pm 2^{15}$ palavras.

A fórmula para o endereço de memória **efetivo** do desvio é a seguinte:
$\text{Endereço Efetivo} = PC + 4 + (\text{ENDEREÇO} \times 4)$

Portanto, se a condição do branch for avaliada como verdadeira, a atualização que ocorre no PC é:
$pc = pc + 4 + (\text{ENDEREÇO} \times 4)$

**Exemplo Prático de Salto:**
Desejamos ignorar a linha de instrução 5 caso `$s0 == $s1`.
```mips
0x00400000    lw $s0, 0($t0)
0x00400004    lw $s1, 4($t0)
0x00400008    lw $s2, 8($t0)
0x0040000C    beq $s0, $s1, ENDEREÇO   # <-- Linha 4
0x00400010    addi $s2, $s2, 5         # <-- Linha 5 (ignorar se a condição for verdadeira)
0x00400014    addi $s2, $s2, 10
```
Qual valor binário (imediato) devemos codificar na instrução da linha 4 no campo `ENDEREÇO` para que ela salte corretamente para a instrução `0x00400014`?
1. Ao chegar na instrução `beq` e começar sua execução, o valor no PC era `0x0040000C`.
2. Como a primeira coisa que a CPU faz é incrementar o PC, no momento do cálculo do desvio o PC já aponta para a próxima instrução, ou seja: `pc = 0x00400010`.
3. O `beq` deve então assumir que o salto relativo ocorre a partir de `0x00400010`.
4. Queremos atingir o destino `0x00400014`. A diferença em bytes é `0x00400014 - 0x00400010 = 0x4` bytes.
5. Como os desvios de branch são codificados em palavras, convertemos esse valor de bytes para palavras: $4_{16} / 4 = 1$ palavra.
6. O campo imediato `ENDEREÇO` na instrução em linguagem de máquina deve, portanto, conter o valor decimal `1` ($1_{10}$).

### Facilidades do Montador: Rótulos (Labels)
Como demonstrado acima, calcular manualmente os offsets dos desvios não é uma tarefa simples e é propensa a erros, especialmente em manutenções de código onde inserimos uma nova instrução e acabamos alterando a distância entre o branch e seu alvo (exigindo recalcular tudo novamente). O uso de pseudoinstruções agrava esse cenário, pois uma pseudoinstrução pode se expandir em mais de uma instrução de máquina, mudando o alinhamento esperado sem que o programador perceba de imediato.

Para nos poupar desse problema, os montadores Assembly (como MARS e SPIM) permitem o uso de **rótulos (labels)**.
- O programador simplesmente define um rótulo (com um nome único seguido de dois pontos `:`) e pede que a instrução de desvio aponte para ele.
- Durante a tradução, o próprio montador calcula a distância correta em bytes/palavras e substitui o nome do rótulo pelo número de salto relativo equivalente no código de máquina.

Exemplo usando rótulos:
```mips
      lw $s0, 0($t0)
      lw $s1, 4($t0)
      lw $s2, 8($t0)
      beq $s0, $s1, salto
      addi $s2, $s2, 5
salto:
      addi $s2, $s2, 10
```

### Comparações (Set on Less Than)

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.4%20-%20Conjuntos%20de%20Instrucoes%20Branches%20e%20Jumps/slide_6_img_1.png)

Para criar desvios baseados nas lógicas "menor que" ($<$), "maior que" ($>$), usamos em conjunto as instruções da família `slt`.

- **slt** (*set on less than* - atribuir se menor que):
  Uma instrução do **Formato R (Tipo-R)**.
  ```mips
  slt $s0, $s1, $s2
  ```
  Isso significa: armazene o valor `1` em `$s0` se `$s1 < $s2`. Caso contrário (se `$s1 \ge $s2`), armazene `0` em `$s0`.

Variantes do `slt`:
- `slti`: Para comparações envolvendo valores imediatos (instrução Formato I).
- `sltu`: Para comparações entre números sem sinal (tratando todos os bits como magnitude e não aplicando complemento de dois).
- `sltiu`: Para comparações com imediatos sem sinal (Formato I).

#### Exercício Resolvido: Mapeamento if-else (C para MIPS)
Considere o trecho de código em C:
```c
if (a > b) {
    a += 30;
}
b += 10;
```
Assumindo que `a` está no registrador `$s0` e `b` no registrador `$s1`, a tradução correspondente em Assembly MIPS seria:
```mips
    slt $t0, $s1, $s0                # $t0 recebe 1 se b < a (ou a > b), ou 0 caso contrário.
    beq $t0, $zero, b_maior_igual    # Se $t0 == 0 (ou seja, a não é > b), pule o bloco "if".
    addi $s0, $s0, 30                # Conteúdo do if: a += 30

b_maior_igual:
    addi $s1, $s1, 10                # Resto do programa: b += 10
```

### Jumps: Saltos Incondicionais
Além dos desvios condicionais, o MIPS suporta **saltos incondicionais**, que transferem o fluxo de controle de forma imediata e sem testar qualquer pré-requisito.

- **j** (*jump* - salte para o endereço):
  ```mips
  j 40000
  ```
Instruções de Jump utilizam o **Formato J (Tipo-J)**, que é o tipo mais simples de instrução MIPS, comportando apenas o opcode e um campo longo de endereço.

#### O Endereçamento Pseudodireto do Jump
Ao contrário dos desvios condicionais (`beq`/`bne`), os saltos do tipo `j` **não são relativos ao PC**. O campo de endereço da instrução aponta diretamente para o local de destino na memória.

- O endereço imediato codificado na instrução do Formato J possui **26 bits**.
- Como todas as instruções também estão alinhadas a múltiplos de 4 (palavras), o processador implicitamente multiplica o endereço alvo codificado no jump por 4 para formar o endereço em bytes. Isso é feito realizando um deslocamento lógico de 2 bits para a esquerda (shift left logical - `<< 2`), efetivamente acrescentando dois `0`s ao final do endereço binário.
- Dessa forma, os 26 bits cobrem um espaço de endereçamento contínuo equivalente a 28 bits no nível do byte ($26 + 2$ bits inferidos de zeros).
- Para atingir os 32 bits de um endereço de memória completo e atualizar completamente o registrador PC, a CPU apanha emprestados os **4 bits mais significativos do PC atual** e os concatena no início do endereço calculado.
- Esse método é chamado de **endereçamento pseudodireto**, pois utiliza endereços absolutos (quase diretos), limitando o alvo ao mesmo "bloco" de $2^{28}$ bytes (256 MB) em que se encontra a instrução atual, por reaproveitar os 4 bits de alta ordem do PC.

Tal como nos branches, podemos utilizar rótulos com a instrução `j`, e deixar o montador resolver as distâncias para nós:
```mips
repetir:
    addi $s0, $s0, 1
    beq $s0, $s1, fim
    j repetir
fim:
    ...
```

#### Exercício Resolvido: While e Vetores
Considere o seguinte trecho em C:
```c
while (vet[i] == k) {
    i += 1;
}
vet[i] = k + 10;
```
Considerando que `i` ($s3), `k` ($s5), a base do vetor `vet` ($s6), o vetor é de inteiros (4 bytes por elemento). O código Assembly seria:
```mips
loop:
    sll $t0, $s3, 2         # multiplicando i por 4 para ajustar deslocamento para palavras
    add $t0, $t0, $s6       # somando o deslocamento calculado ao endereço base do vetor ($t0 = &vet[i])
    lw $t1, 0($t0)          # Carrega na memória: $t1 = vet[i]
    bne $t1, $s5, saida     # Testa condição do while: saia do loop se vet[i] != k
    add $s3, $s3, 1         # Corpo do loop: i++
    j loop                  # Fim da iteração: salta incondicionalmente para o início do loop

saida:
    addi $t1, $s5, 10       # $t1 = k + 10
    sw $t1, 0($t0)          # vet[i] = $t1 (ou seja, k + 10)
```

#### Exercício Resolvido: Excedendo o Limite do Branch (Alcance do Jump)
Considere a estrutura abaixo, onde precisamos fazer um desvio se `$s0 == $s1`:
```mips
    beq $s0, $s1, L1
    # [Conjunto de instruções 1]

L1:
    # [Conjunto de instruções 2]
```
Se a quantidade de código dentro do `[Conjunto de instruções 1]` for gigantesca (maior do que o limite do salto relativo de 16 bits oferecido pelas instruções I-Type do branch $\pm 2^{15}$ palavras), o montador não conseguirá alocar a distância no comando `beq`. Como podemos resolver esse problema estrutural emprestando o longo alcance da instrução `j`?

**Solução:** Invertemos a lógica condicional e encapsulamos um pulo longo (`j`) dentro dela:
```mips
    bne $s0, $s1, L0        # Se não forem iguais, pule o salto e caia no Conjunto 1
    j L1                    # Se FOREM iguais, usamos o jump de longo alcance (26 bits) para ir para o Conjunto 2.

L0:
    # [Conjunto de instruções 1]

L1:
    # [Conjunto de instruções 2]
```

#### Exercício Resolvido: Condicionais Complexas Múltiplas (Lógica AND/OR)
Considere o seguinte programa C:
```c
if ((a < b && b < 50) || a == -10) {
    vet[b] = vet[b] + vet[b - 20];
} else {
    a = 50;
}
b++;
```
Assumindo:
- `a` em `$s0`
- `b` em `$s1`
- Endereço base de `vet` em `$s2`
- Vetor com elementos de 32 bits (inteiros / palavras).

**Solução em MIPS Assembly:**
```mips
    # 1. Testando: (a < b)
    slt $t0, $s0, $s1           # $t0 = 1 se a < b
    beq $t0, $zero, L1          # se a >= b (falhou na 1ª parte do AND), pula direto para testar o OR (a == -10)
    
    # 2. Testando (b < 50) (se chegou aqui, a < b era verdade)
    slti $t0, $s1, 50           # $t0 = 1 se b < 50
    beq $t0, $zero, L1          # se b >= 50 (falhou na 2ª parte do AND), pula para o teste do OR (a == -10)

    # 3. Sucesso no AND
    j if                        # Como as duas condições do AND ((a < b) && (b < 50)) foram válidas, salta para executar o bloco do if

    # 4. Avaliando o lado direito do OR lógico
L1:
    ori $t0, $zero, -10         # carrega constante -10 (ou usa addi $t0, $zero, -10)
    bne $s0, $t0, else          # se a != -10, todas as condições falharam. Salta para o bloco else

    # 5. Execução do bloco IF (vet[b] = vet[b] + vet[b-20])
if:
    sll $t0, $s1, 2             # $t0 = b * 4 (offset para acesso a elementos de vet)
    add $t0, $t0, $s2           # $t0 aponta para o endereço da base + offset (vet[b])
    lw $t1, 0($t0)              # Carrega $t1 = vet[b]
    
    addi $t2, $s1, -20          # $t2 calcula índice de (b - 20)
    sll $t2, $t2, 2             # Multiplica índice por 4 para obter offset em bytes
    add $t2, $t2, $s2           # $t2 aponta para o endereço da base + offset (vet[b-20])
    lw $t2, 0($t2)              # Carrega $t2 = vet[b-20]
    
    add $t1, $t1, $t2           # soma vet[b] + vet[b-20]
    sw $t1, 0($t0)              # Guarda o resultado de volta no endereço armazenado em $t0, que é a posição de vet[b]
    j saida                     # Terminou o bloco IF, pula para a saída desviando o fluxo em torno do else

    # 6. Execução do bloco ELSE (a = 50)
else:
    ori $s0, $zero, 50          # Carrega $s0 com a constante 50. Pode ser li $s0, 50 ou addi $s0, $zero, 50

    # 7. Restante do programa
saida:
    addi $s1, $s1, 1            # Incrementa o b (b++)
```

### Referências
- D. Patterson; J. Hennessy. *Organização e Projeto de Computadores: Interface Hardware/Software*. 5ª Edição. Elsevier Brasil, 2017.
- Andrew S. Tanenbaum. *Organização estruturada de computadores*. 5ª ed. São Paulo: Pearson, 2007.
- Harris, D. and Harris, S. *Digital Design and Computer Architecture*. 2ª ed. 2012.
- `courses.missouristate.edu/KenVollmar/mars/`
