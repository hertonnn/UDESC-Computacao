.data
prompt_n: .asciiz "Digite n: "
prompt_k: .asciiz "Digite k: "
newline: .asciiz "\n"

.text
.globl main

# Função principal
main:
    # Loop principal
loop:
    # Imprimir o prompt para n
    li $v0, 4
    la $a0, prompt_n
    syscall

    # Ler o valor de n
    li $v0, 5
    syscall
    move $a0, $v0 # Armazena o valor de n em $a0

    # Verificar se n é 0 (caso de parada)
    beq $a0, $zero, end_program

    # Imprimir o prompt para k
    li $v0, 4
    la $a0, prompt_k
    syscall

    # Ler o valor de k
    li $v0, 5
    syscall
    move $a1, $v0 # Armazena o valor de k em $a1

    # Chamar a função que conta as ocorrências do dígito k em n
    jal count_digit_occurrences

    # Imprimir o resultado
    li $v0, 1
    move $a0, $v0
    syscall

    # Imprimir uma nova linha
    li $v0, 4
    la $a0, newline
    syscall

    # Voltar para o início do loop
    j loop

end_program:
    # Encerrar o programa
    li $v0, 10
    syscall

# Função recursiva para contar as ocorrências do dígito k em n
count_digit_occurrences:
    # Salvar contexto
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $s0, 0($sp)

    # Verificar o caso base
    beq $a0, $zero, base_case

    # Salvar n e k temporariamente
    move $s0, $a0
    move $t0, $a1 # Armazena k temporariamente

    # Calcular o dígito menos significativo de n
    li $t1, 10
    divu $a0, $t1
    mfhi $t2 # Resto da divisão (dígito menos significativo)

    # Verificar se o dígito é igual a k
    beq $t2, $t0, found
    li $t2, 0
    j continue_recursive

found:
    li $t2, 1

continue_recursive:
    # Chamada recursiva com n dividido por 10
    move $a0, $a0 # Atualiza n
    divu $a0, $t1
    mflo $a0 # Atualiza n
    jal count_digit_occurrences

    # Adicionar o resultado da chamada recursiva
    add $v0, $v0, $t2

    # Restaurar contexto
    lw $s0, 0($sp)
    lw $ra, 4($sp)
    addi $sp, $sp, 8

    # Retornar
    jr $ra

base_case:
    # Caso base: n == 0
    li $v0, 0
    lw $s0, 0($sp)
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra
