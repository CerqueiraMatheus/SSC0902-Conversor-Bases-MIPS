.data
.align 0
	opcoes: .asciiz "[B] Binario\n[D] Decimal\n[H] Hexadecimal\n"
	opcao_invalida: .asciiz "\nOpcao invalida!\n"

.text

# Imprime a string
# Argumentos:
#  $a0 - string
.globl imprime_string
imprime_string:
	# empilha
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	
	li $v0, 4
	syscall
	
	# desempilha
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra


# L� uma op��o v�lida
# Retorno:
#  $v0 - op��o
.globl le_opcao
le_opcao:
	# empilha
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	
	la $a0, opcoes				#
	jal imprime_string			# imrpime_string(op��es)
						#
repita_le_opcao:				# repita
	li $v0, 12				#
	syscall					# 	caracter <- entrada()
	beq $v0, 'B', retorno_le_opcao		# 	se caracter = 'B' ou caracter = 'D' ou caracter = 'H' ent�o
	beq $v0, 'D', retorno_le_opcao		# 		retorna caracter
	beq $v0, 'H', retorno_le_opcao		# 	fim se
	la $a0, opcao_invalida			#
	jal imprime_string			# 	imprime_string(op��o inv�lida)
	j repita_le_opcao			# fim repita

retorno_le_opcao:
	# pula linha
	move $t0, $v0
	li $v0, 11
	li $a0, '\n'
	syscall
	move $v0, $t0

	# desempilha
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra


# Converte a op��o para base
# Argumentos:
#  $a0 - op��o
# Retorno:
#  $v0 - base
.globl para_base
para_base:
	# empilha
	subi $sp, $sp, 4
	sw $ra, 0($sp)

binario_para_base:				# se op��o = 'B' ent�o
	bne $a0, 'B', decimal_para_base		#
	li $v0, 2				# 	retorna 2
	j retorno_para_base			#
						#
decimal_para_base:				# sen�o se op��o = 'D' ent�o
	bne $a0, 'D', hexadecimal_para_base	#
	li $v0, 10				# 	retorna 10
	j retorno_para_base			#
						#
hexadecimal_para_base:				# sen�o
	li $v0, 16				# 	retorna 16
						# fim se
retorno_para_base:
	# desempilha
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
