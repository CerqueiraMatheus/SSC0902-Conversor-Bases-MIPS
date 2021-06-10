.text

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
	blt $t0, 'a', inc_maiusculo		# 	se 'a' <= caracter <= 'z' ent�o
	bgt $t0, 'z', inc_maiusculo		#
	subi $t0, $t0, 32			#		caracter -= 32
	sb $t0, ($a0)				#		*string <- caracter
						#	fim se
inc_maiusculo:					#
	addi $a0, $a0, 1			# pr�ximo(string)
	j enquanto_maiusculo			# fim enquanto

returno_maiusculo:
	# desempilha
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra


# Busca por um caracter dentro da string
# Argumentos:
#  $a0 - string
#  $a1 - desejado
# Retorno:
#  $v0 - �ndice ou -1 caso n�o encontrado
.globl busca
busca:
	# empilha
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	
	li $v0, 0				# �ndice <- 0
						#
enquanto_busca:					# enquanto *string != '\0' fa�a
	lb $t0, ($a0)				# 	caracter <- *string
	beq $t0, '\0', falha_busca		#	
	beq $t0, $a1, retorno_busca		# 	se caracter == desejado ent�o retorna �ndice
	addi $v0, $v0, 1			#	�ndice++
	addi $a0, $a0, 1			#	pr�ximo(string)
	j enquanto_busca			# fim enquanto
						#
falha_busca:					#
	li $v0, -1				# retorna -1

retorno_busca:
	# desempilha
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
