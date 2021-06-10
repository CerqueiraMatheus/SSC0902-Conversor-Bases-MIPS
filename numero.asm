.text

# Checa se o número é um binário válido
# Argumentos:
#  $a0 - número
#  $a1 - digitos
# Retorno:
#  $v0 - deslocamento ou -1 caso inválido
# Registradores:
#  $s0 - digitos
#  $s1 - número
#  $s2 - deslocamento + 1
.globl valida
valida:
	# empilha
	subi $sp, $sp, 16
	sw $s0, 12($sp)
	sw $s1, 8($sp)
	sw $s2, 4($sp)
	sw $ra, 0($sp)

	# salva strings
	move $s0, $a1
	move $s1, $a0
	
	li $s2, 0				#
	li $v0, -1				# deslocamento <- -1
						#
enquanto_valida:				# enquanto *número != '\0' e *número != '\n' faça
	lb $a1, ($s1)				# 	digito <- *numero
	beq $a1, '\0', retorno_valida		#
	beq $a1, '\n', retorno_valida		#
	move $a0, $s0				# 	se busca(digitos, digito) == -1 então
	jal busca				#		retorna -1
	beq $v0, -1, retorno_valida		# 	fim se
	move $v0, $s2				#	deslocamento++
	addi $s2, $s2, 1			#
	addi $s1, $s1, 1			#	próximo(número)
	j enquanto_valida			# fim enquanto

retorno_valida:
	# desempilha
	lw $s0, 12($sp)
	lw $s1, 8($sp)
	lw $s2, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 16
	
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
