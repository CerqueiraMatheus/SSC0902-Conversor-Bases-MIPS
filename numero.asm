.data
.align 0
	convertido: .space 33
	digitos: .asciiz "0123456789ABCDEF"

.text

# Checa se o n�mero � v�lido
# Argumentos:
#  $a0 - n�mero
#  $a1 - base
# Retorno:
#  $v0 - 1 se v�lido ou 0 se inv�lido
# Registradores:
#  $s0 - n�mero
#  $s1 - base
.globl valida
valida:
	# empilha
	subi $sp, $sp, 12
	sw $s0, 8($sp)
	sw $s1, 4($sp)
	sw $ra, 0($sp)

	# salva n�mero e base
	move $s0, $a0
	move $s1, $a1

	li $v0, 0				# v�lido <- 0
						#
enquanto_valida:				# enquanto *n�mero != '\0' e *n�mero != '\n' fa�a
	lb $a0, ($s0)				# 	d�gito <- *n�mero
	beq $a0, '\0', retorno_valida		#
	beq $a0, '\n', retorno_valida		#
	la $a1, digitos				#
	move $a2, $s1				# 	se busca(d�gito, d�gitos, base) = -1 ent�o
	jal busca				#		retorna 0
	beq $v0, -1, falha_valida		# 	fim se
	li $v0, 1				#	v�lido <- 1
	addi $s0, $s0, 1			#	pr�ximo(n�mero)
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


# Converte um n�mero para decimal
# Argumentos:
#  $a0 - n�mero
#  $a1 - base
# Retorno:
#  $v0 - decimal
#  $v1 - 1 se houve overflow e 0 se n�o
# Registradores:
#  $s0 - n�mero
#  $s1 - base
#  $s2 - decimal
#  $s3 - overflow
.globl para_decimal
para_decimal:
	# empilha
	subi $sp, $sp, 20
	sw $s0, 16($sp)
	sw $s1, 12($sp)
	sw $s2, 8($sp)
	sw $s3, 4($sp)
	sw $ra, 0($sp)
	
	# salva n�mero e base
	move $s0, $a0
	move $s1, $a1
	
	li $s2, 0				# decimal <- 0
	li $s3, 0				# overflow <- 0
						#
enquanto_para_decimal:				# enquanto *n�mero != '\0' e *n�mero != '\n' fa�a
	lb $a0, ($s0)				# 	d�gito <- *n�mero
	beq $a0, '\0', retorno_para_decimal	#
	beq $a0, '\n', retorno_para_decimal	#
	multu $s2, $s1				# 	decimal *= base
	mflo $s2				#
	mfhi $t0				#
	bnez $t0, overflow_para_decimal		# 	se parte alta da multiplica��o != 0 ent�o retorna overflow = 1
	la $a1, digitos				#
	move $a2, $s1				#
	jal busca				# 	valor <- busca(d�gito, d�gitos, base)
	move $t0, $s2				# 	anterior <- decimal
	addu $s2, $s2, $v0			# 	decimal += valor
	bltu $s2, $t0, overflow_para_decimal	# 	se decimal < anterior ent�o retorna overflow = 1
	addi $s0, $s0, 1			#	pr�ximo(n�mero)
	j enquanto_para_decimal			# fim enquanto
	
overflow_para_decimal:
	li $s3, 1

retorno_para_decimal:
	move $v0, $s2
	move $v1, $s3

	# desempilha
	lw $s0, 16($sp)
	lw $s1, 12($sp)
	lw $s2, 8($sp)
	lw $s3, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 20
	
	jr $ra


# Converte um decimal para base
# Argumentos:
#  $a0 - decimal
#  $a1 - base
# Retorno:
#  $v0 - convertido
.globl decimal_para
decimal_para:
	# empilha
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	
	beqz $a0, zero_decimal_para		# se decimal = 0 ent�o retorna "0"
	li $t0, 0				# tamanho <- 0
						#
enquanto_decimal_para:				# enquanto decimal != 0 fa�a
	beqz $a0, inverte_decimal_para		#
	divu $a0, $a1				#
	mflo $a0				# 	decimal <- decimal / base
	mfhi $t1				# 	�ndice <- decimal % base
	lb $t1, digitos($t1)			# 	d�gito <- d�gitos[�ndice]
	sb $t1, convertido($t0)			# 	convertido[tamanho] <- d�gito
	addi $t0, $t0, 1			# 	tamanho++
	j enquanto_decimal_para			# fim enquanto
						#
inverte_decimal_para:				#
	li $t1, '\0'				#
	sb $t1, convertido($t0)			# convertido[tamanho] <- '\0'
	la $a0, convertido			#
	move $a1, $t0				#
	jal inverte				# inverte(convertido, tamanho)
	j retorno_decimal_para			# retorna convertido

zero_decimal_para:
	li $t1, '0'
	sb $t1, convertido
	li $t1, '\0'
	sb $t1, convertido+1

retorno_decimal_para:
	la $v0, convertido

	# desempilha
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
