.data
.align 0
	numero: .space 35
	
	msg_base_entrada: .asciiz "Selecione a base do numero de entrada:\n"
	msg_base_saida: .asciiz "Selecione a base do numero de saida:\n"
	msg_numero: .asciiz "Digite o numero a ser convertido:\n"
	msg_numero_invalido: .asciiz "Numero invalido!\n"
	msg_convertido: .asciiz "Numero convertido:\n"
	msg_overflow: .asciiz "Overflow detectado!\n"

.text

# Registradores:
#  $s0 - base da entrada
#  $s1 - base da saída
#  $s2 - convertido
.globl main
main:
	la $a0, msg_base_entrada		#
	jal imprime_string			# imprime_string(mensagem base da entrada)
	jal le_opcao				# opção <- le_opcao()
	move $a0, $v0				#
	jal para_base				# base da entrada <- para_base(opção)
	move $s0, $v0				#
	
	la $a0, msg_numero			#
	jal imprime_string			# imprime_string(mensagem número)
	li $v0, 8				#
	la $a0, numero				#
	li $a1, 35				#
	syscall					# número <- entrada()
	
	la $a0, msg_base_saida			#
	jal imprime_string			# imprime_string(mensagem base da saída)
	jal le_opcao				# opção <- le_opcao()
	move $a0, $v0				#
	jal para_base				# base da saída <- para_base(opção)
	move $s1, $v0				#
	
	la $a0, numero				#
	jal maiusculo				# maiusculo(número)
	la $a0, numero				#
	move $a1, $s0				#
	jal valida				# válido <- valida(número, base da entrada)
	beqz $v0, numero_invalido		# se válido = 0 então imprime_string(mensagem número inválido) senão
	la $a0, numero				#
	move $a1, $s0				#
	jal para_decimal			# decimal, overflow <- para_decimal(número, base da entrada)
	bnez $v1, overflow			# se overflow != 0 então imprime_string(mensagem overflow)
	move $a0, $v0				#
	move $a1, $s1				#
	jal decimal_para			# convertido <- decimal_para(decimal, base da saída)
	move $s2, $v0				#
	la $a0, msg_convertido			#
	jal imprime_string			# imprime_string(mensagem convertido)
	move $a0, $s2				#
	jal imprime_string			# imprime_string(convertido)
	j saida					#

overflow:
	la $a0, msg_overflow
	jal imprime_string
	j saida

numero_invalido:
	la $a0, msg_numero_invalido
	jal imprime_string

saida:	
	li $v0, 10
	syscall
