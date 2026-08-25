.data
espaco: .asciiz "\n"

.text
.globl main

main:
	li $s0, 2  # valor da tabuada
	li $s1, 1  # valor da mult da tabuada
	
loop:
	beq $s1, 11, prox_num  # verifica se o valor != 11
	mult $s0, $s1  # 2*1 exemplo
	mflo $t1  # movendo o resultado para $t1
	addi $s1, $s1, 1 
	
	move $a0, $t1
	li $v0, 1
	syscall
	
	la $a0, espaco
	li $v0, 4
	syscall
	j loop
	
prox_num:
	beq $s0, 10, end
	addi $s0, $s0, 1  # $s0++
	li $s1, 1
	j loop

end:
	li $v0, 10
	syscall