.data

	espaco: .asciiz " "

.text
.globl main

main:
	li $s2, 0  # contador para notas de 50
	li $s3, 0  # contador para notas de 20
	li $s4, 0  # contador para notas de 10
	li $s5, 0  # contador para notas de 5
	li $s6, 0  # contador para moedas de 1
		
		
	li $v0, 5  # leitura de um inteiro
	syscall
	
	move $s0, $v0  # salvando o valor lido
	
subtracao_50:
	addi $s0, $s0, -50  # fazendo a subtracao -50
	bltz $s0, adici_50
	addi $s2, $s2, 1  # incrementando o cont
	j subtracao_50 

adici_50:
	addi $s0, $s0, 50 
	j subtracao_20
	
subtracao_20:
	addi $s0, $s0, -20  # fazendo a subtracao -20
	bltz $s0, adici_20
	addi $s3, $s3, 1  # incrementando o cont
	j subtracao_20
	
adici_20:
	addi $s0, $s0, 20 
	j subtracao_10
	
subtracao_10:
	addi $s0, $s0, -10  # fazendo a subtracao -20
	bltz $s0, adici_10
	addi $s4, $s4, 1  # incrementando o cont
	j subtracao_10
	
adici_10:
	addi $s0, $s0, 10 
	j subtracao_5
		 
subtracao_5:
	addi $s0, $s0, -5  # fazendo a subtracao -20
	bltz $s0, adici_5
	addi $s5, $s5, 1  # incrementando o cont
	j subtracao_5
	
adici_5:
	addi $s0, $s0, 5
	j subtracao_1	 		 
		 
		 
subtracao_1:
	addi $s0, $s0, -1  # fazendo a subtracao -20
	bltz $s0, adici_1
	addi $s6, $s6, 1  # incrementando o cont
	j subtracao_1
	
adici_1:
	j print

print:
	move $a0, $s2
	li $v0, 1
	syscall
	
	la $a0, espaco
	li $v0, 4
	syscall
	
	move $a0, $s3
	li $v0, 1
	syscall
	
	la $a0, espaco
	li $v0, 4
	syscall
	
	move $a0, $s4
	li $v0, 1
	syscall
	
	la $a0, espaco
	li $v0, 4
	syscall
	
	move $a0, $s5
	li $v0, 1
	syscall
	
	la $a0, espaco
	li $v0, 4
	syscall
	
	move $a0, $s6
	li $v0, 1
	syscall
	
end:
	li $v0, 10
	syscall
