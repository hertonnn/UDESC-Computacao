.text
.globl main

main:
	li $t1, -1  # carrega -1 em $t0 para deixar salvo para futuras comparacoes
	li $t2, 2048  # variavel para comparacao
	li $s0, 0  # inicializando $s0 como a variavel que contera a soma
	
loop:
	li $v0, 5  # careguei o codigo do syscall para leitura
	syscall  #chama o syscall para ler
	
	move $t0, $v0  # movendo para um registrador temporario
	bne $t0, $t1, somar  # comparo se o int inserido é != -1 e mando para somar
	
	j imprecao  # se $t0 for == -1, pulará somar e ira direto para imprecao
	
somar:
	add $s0, $t0, $s0  # salvando em $s0 o valor da soma
	bge $s0, $t2, imprecao  # comparacao
	
	j loop  # jump para loop novamente

imprecao:
	li $v0, 1  # carrega o syscall de imprecao
	move $a0, $s0  # move a soma para $a0
	syscall  # imprime a soma

end:
	li $v0, 10
	syscall