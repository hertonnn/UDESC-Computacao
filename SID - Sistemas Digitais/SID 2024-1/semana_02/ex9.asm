.data

na_origem: .asciiz "Ponto na origem!\n"

primeiro: .asciiz "Primeiro quadrante!\n"
segundo: .asciiz "Segundo quadrante!\n"
terceiro: .asciiz "Terceiro quadrante!\n"
quarto: .asciiz "Quarto quadrante!\n"
sobre_x: .asciiz "Sobre o eixo X!\n"
sobre_y: .asciiz "Sobre o eixo Y!\n"

.text
.globl main

main:
	li $v0, 5
	syscall
	move $s0, $v0  # primeira coordenada
	li $v0, 5
	syscall
	move $s1, $v0  # segunda coordenada

analise:
	beqz $s0, em_x  # se $s0 é 0
	beqz $s1, em_y  # se $s1 é 0
	
	bgtz $s0, q1_q4  # se x > 0 pula pra q1_q4
	bltz $s1, q3  # se y < 0, aqui x < 0
	
	la $a0, segundo  # aqui x < 0 e y > 0
	li $v0, 4
	syscall
	j end

q3:
	la $a0, terceiro
	li $v0, 4
	syscall
	j end

q1_q4:
	bgtz $s1, q1  # y > 0
	la $a0, quarto  # logo, esta no quarto quadrante
	li $v0, 4
	syscall
	j end
	
q1:
	la $a0, primeiro
	li $v0, 4
	syscall
	j end

em_x:
	beqz, $s1, origem  # y == 0
	la $a0, sobre_x
	li $v0, 4
	syscall 
	j end

em_y:
	beqz, $s0, origem  # y == 0
	la $a0, sobre_y
	li $v0, 4
	syscall
	j end
	
origem:
	la $a0, na_origem
	li $v0, 4
	syscall
	j end
		
end:
	li $v0, 10
	syscall
