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
	
	li $v0, -1				# endereço <- -1
						#
enquanto_valida:					# enquanto *número != '\0' e *número != '\n' faça
	lb $a1, ($s0)				# 	digito <- *numero
	beq $a1, '\0', retorno_valida		#
	beq $a1, '\n', retorno_valida		#
	move $a0, $s1				# 	se busca(digitos, digito) == -1 então
	jal busca				#		retorna -1
	beq $v0, -1, retorno_valida		# 	fim se
	move $v0, $s0				#	endereço <- número
	addi $s0, $s0, 1			#	próximo(número)
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
