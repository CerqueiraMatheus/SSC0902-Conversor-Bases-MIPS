.data
.align 0
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

	# salva strings
	move $s0, $a0
	move $s1, $a1
	

	li $v0, 0				# v�lido <- 0
						#
enquanto_valida:				# enquanto *n�mero != '\0' e *n�mero != '\n' fa�a
	lb $a2, ($s0)				# 	digito <- *numero
	beq $a2, '\0', retorno_valida		#
	beq $a2, '\n', retorno_valida		#
	la $a0, digitos				# 	se busca(digitos, base, digito) = -1 ent�o
	move $a1, $s1				# 		// digitos com tamanho = base testa apenas valores da base
	jal busca				#		retorna -1
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
