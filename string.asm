.data

.text

# Passa a string para maiúsculo
#  $a0 - string
.globl toupper
toupper:
	# Empilha
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
loop_toupper:
	lb $t0, ($a0)
	beq $t0, '\0', return_toupper
	blt $t0, 'a', inc_toupper
	bgt $t0, 'z', inc_toupper
	subi $t0, $t0, 32
	sb $t0, ($a0)

inc_toupper:
	addi $a0, $a0, 1
	j loop_toupper

return_toupper:
	# Desempilha
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
