.data

barra: .asciiz "/"

.text
.globl main

main:
	li $s0, 365  # para div com anos
	li $s1, 30  # meses
	
	li $v0, 5
	syscall
	
	move $s2, $v0  # salvando os dias em $s0
	div $s2, $s0  # dias / 365
	mflo $t1  # qnt de anos
	mfhi $t2  # dias restantes
	div $t2, $s1  # dias restantes / meses
	mflo $t3  # qnt de meses
	mfhi $t4  # dias restantes
	
print:
	move $a0, $t1
	li $v0, 1
	syscall
	
	la $a0, barra
	li $v0, 4
	syscall
	
	move $a0, $t3
	li $v0, 1
	syscall
	
	la $a0, barra
	li $v0, 4
	syscall
	
	move $a0, $t4
	li $v0, 1
	syscall
	
end:
	li $v0, 10
	syscall
