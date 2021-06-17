#	-------------------------------------------------------------------------
# 	|		    Estudante			|	   NUSP		|
# 	-------------------------------------------------------------------------
#	|	Gustavo Henrique Brunelli		|	(11801053)	|
# 	|	Mateus Israel Silva			|	(11735042)	|
# 	|	Matheus Henrique de Cerqueira Pinto	|	(11911104)	|
# 	|	Pedro Lucas de Moliner de Castro 	|	(11795784)	|
#	-------------------------------------------------------------------------
.text

# Busca por um caracter desejado dentro da string
# Argumentos:
#  $a0 - desejado
#  $a1 - string
#  $a2 - tamanho
# Retorno:
#  $v0 - índice ou -1 caso não encontrado
.globl busca
busca:
	# empilha
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	
	li $v0, 0				# índice <- 0
						#
enquanto_busca:					# enquanto *string != '\0' e tamanho > 0 faça
	lb $t0, ($a1)				# 	caracter <- *string
	beq $t0, '\0', falha_busca		#
	blez $a2, falha_busca			#
	beq $t0, $a0, retorno_busca		# 	se caracter = desejado então retorna índice
	addi $v0, $v0, 1			#	índice++
	addi $a1, $a1, 1			#	próximo(string)
	subi $a2, $a2, 1			# 	tamanho--
	j enquanto_busca			# fim enquanto
						#
falha_busca:					#
	li $v0, -1				# retorna -1

retorno_busca:
	# desempilha
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra


# Converte a string para maiúsculo
# Argumentos:
#  $a0 - string
.globl maiusculo
maiusculo:
	# empilha
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	
enquanto_maiusculo:				# enquanto *string != '\0' faça
	lb $t0, ($a0)				# 	caracter <- *string
	beq $t0, '\0', returno_maiusculo	#
	blt $t0, 'a', continua_maiusculo	# 	se 'a' <= caracter <= 'z' então
	bgt $t0, 'z', continua_maiusculo	#
	subi $t0, $t0, 32			#		caracter -= 32
	sb $t0, ($a0)				#		*string <- caracter
						#	fim se
continua_maiusculo:				#
	addi $a0, $a0, 1			# 	próximo(string)
	j enquanto_maiusculo			# fim enquanto

returno_maiusculo:
	# desempilha
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra


# Inverte os caracteres da string
# Argumentos:
#  $a0 - string
#  $a1 - tamanho
.globl inverte
inverte:
	# emipilha
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	
	li $t0, 0				# início <- 0
	subi $t1, $a1, 1			# fim <- tamanho - 1
						#
enquanto_inverte:				# enquanto início < fim faça
	bge $t0, $t1, retorno_inverte		#
	add $t2, $a0, $t0			#
	add $t3, $a0, $t1			#
	lb $t4, ($t2)				#
	lb $t5, ($t3)				#
	sb $t5, ($t2)				# 	string[início] <- string[fim]
	sb $t4, ($t3)				# 	string[fim] <- string[início]
	addi $t0, $t0, 1			# 	início++
	subi $t1, $t1, 1			# 	fim--
	j enquanto_inverte			# fim enquanto
	
retorno_inverte:
	# desempilha
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
