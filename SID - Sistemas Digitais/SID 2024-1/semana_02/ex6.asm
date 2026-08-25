.data

par: .asciiz "Par"
impar: .asciiz "Impar"
pula_linha: .asciiz "\n"

.text
.globl main

main:
	li $s1, 2
	li $v0, 5
	syscall
	
	beqz $v0, end  # se entrada == 0 encerra
	
	div $v0, $s1  # $v0 / 2
	mfhi $t0  # movendo o resto para $t0
	beqz $t0, imprimir_par  # resto da div == 0
	
	la $a0, impar
	li $v0, 4
	syscall
	
	la $a0, pula_linha
 	li $v0, 4
 	syscall
	
	j main
 	
 imprimir_par: 	
	
  	la $a0, par
 	li $v0, 4
 	syscall
 	
 	la $a0, pula_linha
 	li $v0, 4
 	syscall
 	
 	j main
 
end:
	li $v0, 10
	syscall