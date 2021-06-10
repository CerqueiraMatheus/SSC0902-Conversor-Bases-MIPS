.data
.align 0
	numero: .space 34
	msg_numero: .asciiz "Digite o numero a ser convertido:\n"
	
	opcoes: .asciiz "[1] Binario\n[2] Decimal\n[3] Hexadecimal\n"
	msg_base_entrada: .asciiz "Selecione a base da entrada:\n"
	msg_base_saida: .asciiz "Selecione a base da saida:\n"

.text

# $s0 - base_entrada
# $s1 - base_saida
.globl main
main:
	# imprime msg_numero
	li $v0, 4
	la $a0, msg_numero
	syscall
	# l� numero
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
	# l� base_entrada
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
	# l� base_saida
	li $v0, 5
	syscall
	move $s1, $v0
	
	
	
	# fim execu��o
	li $v0, 10
	syscall
