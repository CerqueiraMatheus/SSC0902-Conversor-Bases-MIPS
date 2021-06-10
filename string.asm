.text

# converte a string para maiúsculo
#  $a0 - string
.globl maiusculo
maiusculo:
	# empilha
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
enquanto_maiusculo:				# enquanto *string != '\0' faça
	lb $t0, ($a0)				# 	caracter <- *string
	beq $t0, '\0', returno_maiusculo	#
	blt $t0, 'a', inc_maiusculo		# 	se 'a' <= caracter <= 'z' então
	bgt $t0, 'z', inc_maiusculo		#
	subi $t0, $t0, 32			#		caracter -= 32
	sb $t0, ($a0)				#		*string <- caracter
						#	fim se
inc_maiusculo:					#
	addi $a0, $a0, 1			# próximo(string)
	j enquanto_maiusculo			# fim enquanto

returno_maiusculo:
	# desempilha
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
