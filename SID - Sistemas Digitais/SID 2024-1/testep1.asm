.text
.globl main

main:
	li $v0, 5
	syscall
	
	move $s0, $v0
	jal sum
	
	move $a0, $v0
	li $v0, 1
	syscall
	

end:
	li $v0, 10
	syscall
	
	
sum:
	beqz $s0, caso_base
	
	add $s1, $s1, $s0
	addi $s0, $s0, -1
	
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	sw $ra, 4($sp)
	
	jal sum
	
	lw $s0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	
	move $v0, $s1
	jr $ra
	
	
caso_base:
	ori, $zero, $s0
	jr $ra
	
	