.data
.align 0
	numero: .space 34
	msg_numero: .asciiz "Digite o numero a ser convertido:\n"
	msg_numero_invalido: .asciiz "Numero invalido!\n"
	
	opcoes: .asciiz "[1] Binario\n[2] Decimal\n[3] Hexadecimal\n"
	msg_base_entrada: .asciiz "Selecione a base da entrada:\n"
	msg_base_saida: .asciiz "Selecione a base da saida:\n"
	msg_opcao_invalida: .asciiz "Opcao invalida!\n"
	
	dig_binario: .asciiz "01"
	dig_decimal: .asciiz "0123456789"
	dig_hexadecimal: .asciiz "0123456789ABCDEF"

.text

# Registradores:
#  $s0 - base_entrada
#  $s1 - base_saida
.globl main
main:
	li $v0, 4					#
	la $a0, msg_numero				#
	syscall						# imprime "Digite o numero a ser convertido:\n"
	li $v0, 8					#
	la $a0, numero					#
	li $a1, 34					#
	syscall						# n�mero <- input

	li $v0, 4					#
	la $a0, msg_base_entrada			#
	syscall						# imprime "Selecione a base da entrada:\n"
	jal imprime_opcoes				# imprime_op��es
	li $v0, 5					#
	syscall						#
	move $s0, $v0					# base_entrada <- input
	
	li $v0, 4					#
	la $a0, msg_base_saida				# 
	syscall						# imprime "Selecione a base da saida:\n"
	jal imprime_opcoes				# imprime op��es
	li $v0, 5					#
	syscall						#
	move $s1, $v0					# base_sa�da <- input

binario:
	bne $s0, 1, decimal				# se base_entrada == 1 ent�o
	la $a0, numero					# 	
	la $a1, dig_binario				#
	jal valida					#	tamanho <- valida(n�mero, dig_bin�rio)
	beq $v0, -1, numero_invalido			# 	se tamanho == -1 ent�o imprime "Numero invalido!"
	binario_binario:				#
		bne $s1, 1, binario_decimal		# 	se base_sa�da == 1 ent�o
		jal imprime_numero			# 		imprime n�mero
		j retorno				#
	binario_decimal:				#
		bne $s1, 2, binario_hexadecimal		# 	sen�o se base_sa�da == 2 ent�o
		la $a0, numero				#
		move $a1, $v0				#
		jal binario_para_decimal		# 		bin�rio_para_decimal(n�mero, tamanho)
		j retorno				#
	binario_hexadecimal:				#
		bne $s1, 3, opcao_invalida		# 	sen�o se base_sa�da == 3 ent�o
		la $a0, numero				#
		move $a1, $v0				#
		jal binario_para_hexadecimal		# 		bin�rio_para_hexadecimal(n�mero, tamanho)
		j retorno				# 	sen�o imprime "Opcao invalida!"
							# 	fim se
decimal:
	bne $s0, 2, hexadecimal				# sen�o se base_entrada == 2 ent�o
	la $a0, numero					# 	
	la $a1, dig_decimal				#
	jal valida					#	tamanho <- valida(n�mero, dig_bin�rio)
	beq $v0, -1, numero_invalido			# 	se tamanho == -1 ent�o imprime "Numero invalido!"
	decimal_binario:				#
		bne $s1, 1, decimal_decimal		#	se base_sa�da == 1 ent�o
		la $a0, numero				#
		move $a1, $v0				#
		jal decimal_para_binario		# 		decimal_para_bin�rio(n�mero, tamanho)
		j retorno				#
	decimal_decimal:				# 	sen�o se base_sa�da == 2 ent�o
		bne $s1, 2, decimal_hexadecimal		#
		jal imprime_numero			# 		imprime n�mero
		j retorno				#
	decimal_hexadecimal:				#
		bne $s1, 3, opcao_invalida		# 	sen�o se base_sa�da == 3 ent�o
		la $a0, numero				#
		move $a1, $v0				#
		jal decimal_para_hexadecimal		# 		decimal_para_hexadecimal(n�mero, tamanho)
		j retorno				# 	sen�o imprime "Opcao invalida!"
							# 	fim se
hexadecimal:
	bne $s0, 3, opcao_invalida			# sen�o se base_entrada == 3 ent�o
	la $a0, numero					#
	jal maiusculo					# 	maiusculo(n�mero)
	la $a0, numero					# 	
	la $a1, dig_hexadecimal				#
	jal valida					#	tamanho <- valida(n�mero, dig_bin�rio)
	beq $v0, -1, numero_invalido			# 	se tamanho == -1 ent�o imprime "Numero invalido!"
	hexadecimal_binario:				#
		bne $s1, 1, hexadecimal_decimal		# 	se base_sa�da == 1 ent�o
		la $a0, numero				#
		move $a1, $v0				#
		jal hexadecimal_para_binario		# 		hexadecimal_para_bin�rio(n�mero, tamanho)
		j retorno				#
	hexadecimal_decimal:				#
		bne $s1, 2, hexadecimal_hexadecimal	# 	sen�o se base_sa�da == 2 ent�o
		la $a0, numero				#
		move $a1, $v0				#
		jal hexadecimal_para_decimal		# 		hexadecimal_para_decimal(n�mero, tamanho)
		j retorno				#
	hexadecimal_hexadecimal:			# 	sen�o se base_sa�da == 3 ent�o
		bne $s1, 3, opcao_invalida		#
		jal imprime_numero			# 		imprime n�mero
		j retorno				# 	sen�o imprime "Opcao invalida!"
							# 	fim se
opcao_invalida:
	li $v0, 4					# sen�o
	la $a0, msg_opcao_invalida			#
	syscall						# 	imprime "Opcao invalida!\n"
	j retorno					# fim se

# imprime "Numero invalido!\n"
numero_invalido:
	li $v0, 4
	la $a0, msg_numero_invalido
	syscall
	j retorno
	
retorno:
	li $v0, 10
	syscall


# Imprime as op��es de base
imprime_opcoes:
	# empilha
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	
	li $v0, 4
	la $a0, opcoes
	syscall
	
	# desempilha
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra


# Imprime o n�mero
imprime_numero:
	# empilha
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	
	li $v0, 4
	la $a0, numero
	syscall
	
	# desempilha
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
