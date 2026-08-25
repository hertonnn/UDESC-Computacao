.data

espaco: .asciiz " "  # Definindo a string a ser impressa

.text
.globl main

main:
	li $t0, 0  # primeiro termo
	li $t1, 1  # segundo termo
	li $s0, 0  # contador para os n termos
	
	li $v0, 5  # careguei o codigo do syscall para leitura
	syscall  #chama o syscall para ler
	
	move $t3, $v0  # movendo para $t3 o conteudo
	
while:

	li $v0, 1  # printando o numero de fibo
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, espaco
	syscall
	
	move $t2, $t1  # movendo para uma auxiliar
	add $t1, $t1, $t0  # somando pro prox num
	move $t0, $t2  # antecessor agr é sucessor
	add $s0, $s0, 1  # somando o contador
	
	bne $s0, $t3, while  # comparacao pra ver se terminou  

end:
	li $v0, 10
	syscall
