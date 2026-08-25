.data
pula_linha: .asciiz "\n"

.text
.globl main

main:
	li $v0, 5
	syscall
	beqz $v0, end  # se n == 0, encerra o programa
	move $a1, $v0  # a1 (primeiro argumento)

	li $v0, 5
	syscall
    	move $a2, $v0  # $a2 (segundo argumento)

    	jal contar_digitos
	
    	move $a0, $v0  # $v0 para o resultado (contador final)
    	li $v0, 1
    	syscall

    	li $v0, 4       
    	la $a0, pula_linha
    	syscall

    	j main
    
end:
    	li $v0, 10
    	syscall

contar_digitos:
    	beqz $a1, fim_recursao

	li $t1, 10
    	div $a1, $t1 # n/10
    	mfhi $t2  # resto da divisao (ultimo digito)
    	mflo $a1  # $a0 agora tem n/10 (parte inteira)
    
    	# salva o contexto
    	addi $sp, $sp, -8
    	sw $ra, 0($sp)  
    	sw $t2, 4($sp)  # ultimo digito
 
    	jal contar_digitos  # recursao

    	lw $ra, 0($sp)  
    	lw $t2, 4($sp)
    	addi $sp, $sp, 8
    	
	beq $a2, $t2, incrementar  # if(ultimo digito == k): cont++
	jr $ra

incrementar:   
	addi $v0, $v0, 1  # cont++
    	jr $ra
    
fim_recursao:
	li $v0, 0  # csso base
	jr $ra