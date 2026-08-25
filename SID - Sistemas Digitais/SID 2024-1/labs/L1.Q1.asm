 .text
 .globl main

main:
 	li $v0, 5
	syscall
	
	move $t0, $v0
 	li $s0, 1 # $s0 = 1
while:
	mul $s0, $s0, $t0 # $s0 = $s0 * $s1 (32 bits baixos)
 	addi $t0, $t0, -1 # $t0 = $t0 - 1
 	bnez $t0, while # se $s1 != 0 ent˜ao v´a p/ while
 	
 	li $v0, 1
 	move $a0, $s0  # imprimindo n!
 	syscall
end:
	li $v0, 10 # C´odigo para encerrar o programa
 	syscall # encerra o programa