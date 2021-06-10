.text

# Checa se o n�mero � um bin�rio v�lido
# Argumentos:
#  $a0 - n�mero
#  $a1 - digitos
# Retorno:
#  $v0 - endere�o do bit menos significativo ou -1 caso inv�lido
# Registradores:
#  $s0 - n�mero
#  $s1 - digitos
.globl valida
valida:
	# empilha
	subi $sp, $sp, 12
	sw $s0, 8($sp)
	sw $s1, 4($sp)
	sw $ra, 0($sp)

	# salva strings
	move $s0, $a0
	move $s1, $a1
	
	li $v0, -1				# endere�o <- -1
						#
enquanto_valida:					# enquanto *n�mero != '\0' e *n�mero != '\n' fa�a
	lb $a1, ($s0)				# 	digito <- *numero
	beq $a1, '\0', retorno_valida		#
	beq $a1, '\n', retorno_valida		#
	move $a0, $s1				# 	se busca(digitos, digito) == -1 ent�o
	jal busca				#		retorna -1
	beq $v0, -1, retorno_valida		# 	fim se
	move $v0, $s0				#	endere�o <- n�mero
	addi $s0, $s0, 1			#	pr�ximo(n�mero)
	j enquanto_valida			# fim enquanto

retorno_valida:
	# desempilha
	lw $s0, 8($sp)
	lw $s1, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 12
	
	jr $ra


.globl binario_para_decimal
binario_para_decimal:

.globl binario_para_hexadecimal
binario_para_hexadecimal:

.globl decimal_para_binario
decimal_para_binario:

.globl decimal_para_hexadecimal
decimal_para_hexadecimal:

.globl hexadecimal_para_binario
hexadecimal_para_binario:

.globl hexadecimal_para_decimal
hexadecimal_para_decimal:
