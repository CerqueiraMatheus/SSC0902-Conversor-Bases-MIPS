.data
.align 0
	digitos: .asciiz "0123456789ABCDEF"

.text

# Checa se o número é válido
# Argumentos:
#  $a0 - número
#  $a1 - base
# Retorno:
#  $v0 - 1 se válido ou 0 se inválido
# Registradores:
#  $s0 - número
#  $s1 - base
.globl valida
valida:
	# empilha
	subi $sp, $sp, 12
	sw $s0, 8($sp)
	sw $s1, 4($sp)
	sw $ra, 0($sp)

	# salva número e base
	move $s0, $a0
	move $s1, $a1

	li $v0, 0				# válido <- 0
						#
enquanto_valida:				# enquanto *número != '\0' e *número != '\n' faça
	lb $a0, ($s0)				# 	dígito <- *número
	beq $a0, '\0', retorno_valida		#
	beq $a0, '\n', retorno_valida		#
	la $a1, digitos				#
	move $a2, $s1				# 	se busca(dígito, dígitos, base) = -1 então
	jal busca				#		retorna 0
	beq $v0, -1, falha_valida		# 	fim se
	li $v0, 1				#	válido <- 1
	addi $s0, $s0, 1			#	próximo(número)
	j enquanto_valida			# fim enquanto

falha_valida:
	li $v0, 0

retorno_valida:
	# desempilha
	lw $s0, 8($sp)
	lw $s1, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 12
	
	jr $ra

# Converte um número para decimal
# Argumentos:
#  $a0 - número
#  $a1 - base
# Retorno:
#  $v0 - decimal
# Registradores:
#  $s0 - número
#  $s1 - base
#  $s2 - decimal
.globl para_decimal
para_decimal:
	# empilha
	subi $sp, $sp, 16
	sw $s0, 12($sp)
	sw $s1, 8($sp)
	sw $s2, 4($sp)
	sw $ra, 0($sp)
	
	# salva número e base
	move $s0, $a0
	move $s1, $a1
	
	li $s2, 0				# decimal <- 0
						#
enquanto_para_decimal:				# enquanto *número != '\0' e *número != '\n' faça
	lb $a0, ($s0)				# 	dígito <- *número
	beq $a0, '\0', retorno_para_decimal	#
	beq $a0, '\n', retorno_para_decimal	#
	mulu $s2, $s2, $s1			# 	decimal *= base
	la $a1, digitos				#
	move $a2, $s1				#
	jal busca				# 	valor <- busca(dígito, dígitos, base)
	addu $s2, $s2, $v0			# 	decimal += valor
	addi $s0, $s0, 1			#	próximo(número)
	j enquanto_para_decimal			# fim enquanto

retorno_para_decimal:
	move $v0, $s2

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
