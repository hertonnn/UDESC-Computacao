.data

.text
.globl main

main:
    li $v0, 5 
    syscall
    move $a0, $v0
    
    jal fibonacci
    
    move $a0, $v0
    li $v0, 1
    syscall

    li $v0, 10
    syscall
    
fibonacci:
    beq $a0, 0, caso_0  # se n == 0, vai para caso_0
    beq $a0, 1, caso_1  # se n == 1, vai para caso_1

    addi $sp, $sp, -12  # criar espaço na pilha para salvar retorno e $t2
    sw $a0, 0($sp)  # salvar valor de n
    sw $ra, 4($sp)  # salvar endereço de retorno
    sw $t2, 8($sp)  # salvar $t2
    
    addi $a0, $a0, -1  # n-1
    jal fibonacci  # chamada recursiva
    move $t2, $v0  # salvar resultado de fibonacci(n-1) em $t2

    lw $a0, 0($sp)  # carregar valor original de n
    addi $a0, $a0, -2  # n-2
    jal fibonacci  # chamada recursiva

    add $v0, $v0, $t2  # fibonacci(n) = fibonacci(n-1) + fibonacci(n-2)

    lw $t2, 8($sp)  # restaurar $t2
    lw $ra, 4($sp)  # restaurar endereço de retorno
    addi $sp, $sp, 12  # restaurar pilha
    jr $ra  # retornar

caso_0:
    li $v0, 1  # exige fibonacci(0) = 1
    jr $ra  # retornar

caso_1:
    li $v0, 1  # fibonacci(1) = 1
    jr $ra  # retornar
