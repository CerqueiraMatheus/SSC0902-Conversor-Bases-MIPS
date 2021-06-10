.data
.align 0
	numero: .space 34
	msg_numero: .asciiz "Digite o numero a ser convertido:\n"
	
	opcoes: .asciiz "[1] Binario\n[2] Decimal\n[3] Hexadecimal\n"
	msg_base_entrada: .asciiz "Selecione a base da entrada:\n"
	msg_base_saida: .asciiz "Selecione a base da saida:\n"
	
	dig_binario: .asciiz "01"
	dig_decimal: .asciiz "0123456789"
	dig_hexadecimal: .asciiz "0123456789ABCDEF"

.text

# Registradores:
#  $s0 - base_entrada
#  $s1 - base_saida
.globl main
main:
	# imprime msg_numero
	li $v0, 4
	la $a0, msg_numero
	syscall
	# lê numero
	li $v0, 8
	la $a0, numero
	li $a1, 34
	syscall

	# imprime msg_base_entrada
	li $v0, 4
	la $a0, msg_base_entrada
	syscall
	# imprime opcoes
	li $v0, 4
	la $a0, opcoes
	syscall
	# lê base_entrada
	li $v0, 5
	syscall
	move $s0, $v0
	
	# imprime msg_base_saida
	li $v0, 4
	la $a0, msg_base_saida
	syscall
	# imprime opcoes
	li $v0, 4
	la $a0, opcoes
	syscall
	# lê base_saida
	li $v0, 5
	syscall
	move $s1, $v0
	
	la $a0, numero
	jal maiusculo
	
	la $a0, numero
	la $a1, dig_hexadecimal
	jal checa
	
	move $a0, $v0
	li $v0, 1
	syscall
	
retorno:
	li $v0, 10
	syscall
