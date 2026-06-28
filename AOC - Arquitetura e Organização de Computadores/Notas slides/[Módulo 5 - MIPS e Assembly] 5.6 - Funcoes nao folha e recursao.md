### Funções Folha e Não-Folha

**Funções folha:**
A função apresentada na aula passada é um exemplo de uma **função folha**: uma função que realiza a sua tarefa e retorna sem chamar nenhuma outra função internamente.

```c
int leaf_example(int g, int h, int i, int j){
    int f;
    f = (g+h) - (i+j);
    return f;
}
```

**Funções não folha:**
Uma função que chama outra internamente para resolver um problema é denominada **função não-folha**.
Esta função pode chamar uma outra função diferente ou até mesmo um clone de si mesma (o que caracteriza a **recursão**).
▶ Os problemas enfrentados a nível de hardware e linguagem de montagem são os mesmos em ambos os casos.

### Revisão: Otimizando Funções Folha

Em funções folha, podemos evitar ou diminuir o uso da pilha de memória (Stack).
▶ Não é necessário escrever ou salvar o registrador de endereço de retorno (`$ra`), já que nenhuma outra função será chamada.
▶ Podemos utilizar livremente os registradores temporários (`$t0` - `$t9`).

**Exemplo utilizando a pilha:**
```mips
leaf_example:
    addi $sp, $sp, -8
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    
    add $s0, $a0, $a1
    add $s1, $a2, $a3
    sub $v0, $s0, $s1
    
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    addi $sp, $sp, 8
    
    jr $ra  # saltando para o endereço armazenado em $ra
```

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.6%20-%20Funcoes%20nao%20folha%20e%20recursao/slide_2_img_1.png)

**Exemplo sem o uso da pilha (apenas registradores temporários):**
```mips
leaf_example:
    add $t0, $a0, $a1
    add $t1, $a2, $a3
    sub $v0, $t0, $t1
    jr $ra  # saltando para o endereço armazenado em $ra
```

### Revisão: Convenções de Preservação de Registradores

Para organizar as chamadas de funções, o MIPS define convenções claras sobre quais registradores devem ter seus valores preservados (salvos pelo "chamado") e quais podem ser sobrescritos (salvos pelo "chamador", se necessário).

| Preservado | Não preservado |
| :--- | :--- |
| `$s0` — `$s7` | `$t0` — `$t9` |
| `$sp` | `$a0` — `$a3` |
| `$ra` | `$v0` — `$v1` |
| Pilha acima de `$sp` | Pilha abaixo de `$sp` |

Em **funções não folha**, podemos não ter todas estas opções livres. Como uma função chama outra função:
▶ Nós inevitavelmente vamos escrever no registrador `$ra` ao chamar a outra função utilizando a instrução `jal`.
▶ Podemos ter situações em que queremos preservar os dados atuais em registradores antes de realizar a chamada da outra função, para podermos usá-los novamente após o retorno da outra função.

### Problemas em Funções Não-Folha e Recursão

Considere uma função escrita em C que calcula o fatorial de forma recursiva:

```c
int fatorial(int n){
    if(n < 1)
        return 1;
    return n * fatorial(n-1);
}
```

▶ Que problemas nós criamos agora a nível de linguagem de montagem que não existiam em uma função folha?
⋆ Os valores atuais armazenados nos registradores podem se perder na chamada da próxima função.
⋆ O endereço de retorno armazenado no registrador `$ra` vai ser sobrescrito pelo novo `jal`, o que significa que o valor original vai se perder e o programa não saberá como voltar para a função original (como o bloco `main`) que chamou o fatorial primeiramente.

![Imagem Embutida 1](./imagens/%5BM%C3%B3dulo%205%20-%20MIPS%20e%20Assembly%5D%205.6%20-%20Funcoes%20nao%20folha%20e%20recursao/slide_3_img_1.png)

Cada chamada da função `fatorial` deveria ter acesso aos seus próprios registradores (por exemplo, `$s0`, `$s1`) e também ao seu próprio endereço de retorno.
▶ Como podemos resolver esse conflito?
▶ A solução é usar o espaço de memória para empilhar (`push` na Stack) todos os valores que precisam ser salvos antes da chamada recursiva, e depois desempilhá-los (`pop`) após o retorno.

### Criação do Fatorial Recursivo em MIPS

Primeiro, definimos a rotina principal para chamar a função:

```mips
.text
.globl main
main:
    li $a0, 4
    jal fatorial
    
    move $a0, $v0
    li $v0, 1
    syscall  # imprimir resultado
    
end:
    li $v0, 10
    syscall

fatorial:
    # vamos escrever nossa função aqui
```

Em seguida, começamos a estruturar o corpo da função `fatorial`, planejando onde as variáveis de contexto precisarão ser salvas:

```mips
fatorial:
    # if ($a0 < 1)
    blt $a0, 1, fat_parada

    # salvar contexto
    
    # código principal com chamada recursiva

    # restaurar
    
    # retornar

fat_parada:
    ori $v0, $zero, 1
    jr $ra
```

#### Código Completo do Fatorial Recursivo

Preenchendo as lacunas e gerenciando a pilha (`$sp`):

```mips
fatorial:
    # if ($a0 < 1)
    blt $a0, 1, fat_parada

    # salvar contexto
    addi $sp, $sp, -8    # Aloca espaço para 2 itens na pilha
    sw $s0, 0($sp)       # Salva o valor de $s0
    sw $ra, 4($sp)       # Salva o endereço de retorno $ra

    # código principal com chamada recursiva
    move $s0, $a0        # Salva o argumento atual n em $s0
    addi $a0, $a0, -1    # n-1
    jal fatorial         # $v0 = fatorial($a0 - 1)
    mul $v0, $v0, $s0    # $v0 = fatorial($a0 - 1) * n

    # restaurar contexto
    lw $s0, 0($sp)       # Restaura o valor original de $s0
    lw $ra, 4($sp)       # Restaura o endereço de retorno $ra
    addi $sp, $sp, 8     # Desaloca espaço na pilha

    # retornar
    jr $ra

fat_parada:
    ori $v0, $zero, 1    # Retorna 1 se n < 1
    jr $ra               # Retorna para quem chamou
```

### Considerações Sobre Recursividade em Baixo Nível

Muitos problemas possuem soluções muito mais simples de implementar e de ler quando utilizado o conceito de recursividade:
▶ Navegar em estruturas de dados como uma árvore binária ou grafos.
▶ Técnicas algorítmicas como o algoritmo guloso, programação dinâmica, e divisão e conquista.

No entanto, a recursão (ou mesmo chamadas em profundidade de procedimentos não folha) **custa caro para o hardware da máquina**.
⋆ Por quê?
⋆ Cada chamada exige comunicação com a memória principal para empilhar e salvar os dados do contexto (registradores).
⋆ Ocupa grande espaço na memória de pilha (Stack), podendo levar a um erro de *Stack Overflow*.
⋆ Invalida e limpa linhas em nossa memória cache devido a constante movimentação de dados.

▶ Sendo assim, a nível de linguagem de máquina, **uma solução iterativa (usando laços de repetição) é sempre preferível em relação ao desempenho**.
▶ Compiladores modernos fazem o que podem para tentar analisar e eliminar recursões no código (transformando-as em iterações de forma implícita), técnica conhecida como *Tail Call Optimization* (Otimização de Chamada de Cauda).

### Exercícios

1. Execute o código do fatorial recursivo no MARS passo a passo, analise atentamente e entenda as mudanças que ocorrem em cada um dos registradores e nos endereços de memória durante o empilhamento e desempilhamento.
2. Questões do laboratório de programação (notas das atividades):
   ▶ O sistema (Moodle) apenas testa a corretude da saída do seu código.
   ▶ O código será avaliado manualmente para atestar se atende ao requisito obrigatório de **resolver o problema recursivamente** (a nota será zero na questão se os requisitos do enunciado não forem cumpridos).
   ▶ O código será avaliado manualmente em quesitos de qualidade: estilo de código, eficiência, elegância, limpeza, organização e bons comentários.

### Referências

* D. Patterson; J. Henessy. Organização e Projeto de Computadores: Interface Hardware/Software. 5a Edição. Elsevier Brasil, 2017.
* Andrew S. Tanenbaum. Organização estruturada de computadores. 5. ed. São Paulo: Pearson, 2007.
* Harris, D. and Harris, S. Digital Design and Computer Architecture. 2a ed. 2012.
* courses.missouristate.edu/KenVollmar/mars/
