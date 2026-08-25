	.data 

texto:
	pula_linha: .asciiz "\n"
	erro: .asciiz "ERRO" 
	
	.text
	.globl main
		
main:
	li $t1, -1  # carrega -1 em $t0 para deixar salvo para futuras comparacoes
	li $s0, 0  # inicializando $s0 como a variavel que contera a soma
	li $t2, 0  # inicilaizand o contador para a media
	li $s1, 0  # media
	
loop:
	li $v0, 5  # careguei o codigo do syscall para leitura
	syscall  #chama o syscall para ler
	
	move $t0, $v0  # movendo para um registrador temporario
	bne $t0, $t1, somar  # comparo se o int inserido é != -1 e mando para somar
	
	j imprecao  # se $t0 for == -1, pulará somar e ira direto para imprecao
	
somar:
	add $s0, $t0, $s0  # salvando em $s0 o valor da soma
	addi $t2, $t2, 1  # $t2 = $t2 + 1
	j loop  # jump para loop novamente

imprecao:

	li $v0, 1  # carrega o syscall de imprecao
	move $a0, $s0  # move a soma para $a0
	syscall  # imprime a soma
	
	la $a0, pula_linha  #carrega o endereco da pula linha 
	li $v0, 4  # syscall de imprecao de string
	syscall
	
	beq $t2, $s1, error  # comparacao pra ver se cont == 0
	
	div $s0, $t2  # $s0/$t2
	mflo $s1  # move o quociente salvo em LO para $t3
	li $v0, 1  # carrega o syscall para imprecao da media
	move $a0, $s1
	syscall
	
	j end
	
error:
	
	la $a0, erro
	li $v0, 4
	syscall
	
end:
	li $v0, 10
	syscall
