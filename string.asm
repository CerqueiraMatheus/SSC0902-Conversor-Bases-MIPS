.text

# Busca por um caracter desejado dentro da string
# Argumentos:
#  $a0 - desejado
#  $a1 - string
#  $a2 - tamanho
# Retorno:
#  $v0 - �ndice ou -1 caso n�o encontrado
.globl busca
busca:
	# empilha
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	
	li $v0, 0				# �ndice <- 0
						#
enquanto_busca:					# enquanto *string != '\0' e tamanho > 0 fa�a
	lb $t0, ($a1)				# 	caracter <- *string
	beq $t0, '\0', falha_busca		#
	blez $a2, falha_busca			#
	beq $t0, $a0, retorno_busca		# 	se caracter = desejado ent�o retorna �ndice
	addi $v0, $v0, 1			#	�ndice++
	addi $a1, $a1, 1			#	pr�ximo(string)
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


# Converte a string para mai�sculo
# Argumentos:
#  $a0 - string
.globl maiusculo
maiusculo:
	# empilha
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	
enquanto_maiusculo:				# enquanto *string != '\0' fa�a
	lb $t0, ($a0)				# 	caracter <- *string
	beq $t0, '\0', returno_maiusculo	#
	blt $t0, 'a', continua_maiusculo	# 	se 'a' <= caracter <= 'z' ent�o
	bgt $t0, 'z', continua_maiusculo	#
	subi $t0, $t0, 32			#		caracter -= 32
	sb $t0, ($a0)				#		*string <- caracter
						#	fim se
continua_maiusculo:				#
	addi $a0, $a0, 1			# 	pr�ximo(string)
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
	
	li $t0, 0				# in�cio <- 0
	subi $t1, $a1, 1			# fim <- tamanho - 1
						#
enquanto_inverte:				# enquanto in�cio < fim fa�a
	bge $t0, $t1, retorno_inverte		#
	add $t2, $a0, $t0			#
	add $t3, $a0, $t1			#
	lb $t4, ($t2)				#
	lb $t5, ($t3)				#
	sb $t5, ($t2)				# 	string[in�cio] <- string[fim]
	sb $t4, ($t3)				# 	string[fim] <- string[in�cio]
	addi $t0, $t0, 1			# 	in�cio++
	subi $t1, $t1, 1			# 	fim--
	j enquanto_inverte			# fim enquanto
	
retorno_inverte:
	# desempilha
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
