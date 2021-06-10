.text

# Checa se o número é um binário válido
# Argumentos:
#  $a0 - número
#  $a1 - digitos
# Retorno:
#  $v0 - endereço do bit menos significativo ou -1 caso inválido
# Registradores:
#  $s0 - número
#  $s1 - digitos
.globl checa
checa:
	# empilha
	subi $sp, $sp, 12
	sw $s0, 8($sp)
	sw $s1, 4($sp)
	sw $ra, 0($sp)

	# salva strings
	move $s0, $a0
	move $s1, $a1
	
	li $v0, -1				# endereço <- -1
						#
enquanto_checa:					# enquanto *número != '\0' e *número != '\n' faça
	lb $a1, ($s0)				# 	digito <- *numero
	beq $a1, '\0', retorno_checa		#
	beq $a1, '\n', retorno_checa		#
	move $a0, $s1				# 	se busca(digitos, digito) == -1 então
	jal busca				#		retorna -1
	beq $v0, -1, retorno_checa		# 	fim se
	move $v0, $s0				#	endereço <- número
	addi $s0, $s0, 1			#	próximo(número)
	j enquanto_checa			# fim enquanto

retorno_checa:
	# desempilha
	lw $s0, 8($sp)
	lw $s1, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 12
	
	jr $ra
