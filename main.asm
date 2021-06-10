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
	syscall						# número <- input

	li $v0, 4					#
	la $a0, msg_base_entrada			#
	syscall						# imprime "Selecione a base da entrada:\n"
	jal imprime_opcoes				# imprime_opções
	li $v0, 5					#
	syscall						#
	move $s0, $v0					# base_entrada <- input
	
	li $v0, 4					#
	la $a0, msg_base_saida				# 
	syscall						# imprime "Selecione a base da saida:\n"
	jal imprime_opcoes				# imprime opções
	li $v0, 5					#
	syscall						#
	move $s1, $v0					# base_saída <- input

binario:
	bne $s0, 1, decimal				# se base_entrada == 1 então
	la $a0, numero					# 	
	la $a1, dig_binario				#
	jal valida					#	tamanho <- valida(número, dig_binário)
	beq $v0, -1, numero_invalido			# 	se tamanho == -1 então imprime "Numero invalido!"
	binario_binario:				#
		bne $s1, 1, binario_decimal		# 	se base_saída == 1 então
		jal imprime_numero			# 		imprime número
		j retorno				#
	binario_decimal:				#
		bne $s1, 2, binario_hexadecimal		# 	senão se base_saída == 2 então
		la $a0, numero				#
		move $a1, $v0				#
		jal binario_para_decimal		# 		binário_para_decimal(número, tamanho)
		j retorno				#
	binario_hexadecimal:				#
		bne $s1, 3, opcao_invalida		# 	senão se base_saída == 3 então
		la $a0, numero				#
		move $a1, $v0				#
		jal binario_para_hexadecimal		# 		binário_para_hexadecimal(número, tamanho)
		j retorno				# 	senão imprime "Opcao invalida!"
							# 	fim se
decimal:
	bne $s0, 2, hexadecimal				# senão se base_entrada == 2 então
	la $a0, numero					# 	
	la $a1, dig_decimal				#
	jal valida					#	tamanho <- valida(número, dig_binário)
	beq $v0, -1, numero_invalido			# 	se tamanho == -1 então imprime "Numero invalido!"
	decimal_binario:				#
		bne $s1, 1, decimal_decimal		#	se base_saída == 1 então
		la $a0, numero				#
		move $a1, $v0				#
		jal decimal_para_binario		# 		decimal_para_binário(número, tamanho)
		j retorno				#
	decimal_decimal:				# 	senão se base_saída == 2 então
		bne $s1, 2, decimal_hexadecimal		#
		jal imprime_numero			# 		imprime número
		j retorno				#
	decimal_hexadecimal:				#
		bne $s1, 3, opcao_invalida		# 	senão se base_saída == 3 então
		la $a0, numero				#
		move $a1, $v0				#
		jal decimal_para_hexadecimal		# 		decimal_para_hexadecimal(número, tamanho)
		j retorno				# 	senão imprime "Opcao invalida!"
							# 	fim se
hexadecimal:
	bne $s0, 3, opcao_invalida			# senão se base_entrada == 3 então
	la $a0, numero					#
	jal maiusculo					# 	maiusculo(número)
	la $a0, numero					# 	
	la $a1, dig_hexadecimal				#
	jal valida					#	tamanho <- valida(número, dig_binário)
	beq $v0, -1, numero_invalido			# 	se tamanho == -1 então imprime "Numero invalido!"
	hexadecimal_binario:				#
		bne $s1, 1, hexadecimal_decimal		# 	se base_saída == 1 então
		la $a0, numero				#
		move $a1, $v0				#
		jal hexadecimal_para_binario		# 		hexadecimal_para_binário(número, tamanho)
		j retorno				#
	hexadecimal_decimal:				#
		bne $s1, 2, hexadecimal_hexadecimal	# 	senão se base_saída == 2 então
		la $a0, numero				#
		move $a1, $v0				#
		jal hexadecimal_para_decimal		# 		hexadecimal_para_decimal(número, tamanho)
		j retorno				#
	hexadecimal_hexadecimal:			# 	senão se base_saída == 3 então
		bne $s1, 3, opcao_invalida		#
		jal imprime_numero			# 		imprime número
		j retorno				# 	senão imprime "Opcao invalida!"
							# 	fim se
opcao_invalida:
	li $v0, 4					# senão
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


# Imprime as opções de base
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


# Imprime o número
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
