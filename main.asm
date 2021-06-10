.data
.align 0
	opcoes: .asciiz "[1] Binario\n[2] Decimal\n[3] Hexadecimal\n"
	mensagem_entrada: .asciiz "Digite o numero a ser convertido:\n"
	mensagem_base_entrada: .asciiz "Selecione a base da entreda:\n"
	mensagem_base_saida: .asciiz "Selecione a base da saida:\n"
	
	numero: .space 34

.text

# $s0 - base_entrada
# $s1 - base_saida
.globl main
main:
	# Imprime string mensagem_entrada
	li $v0, 4
	la $a0, mensagem_entrada
	syscall
	# Lê numero
	li $v0, 8
	la $a0, numero
	li $a1, 34
	syscall

	# Imprime string mensagem_base_entrada
	li $v0, 4
	la $a0, mensagem_base_entrada
	syscall
	# Imprime string opcoes
	li $v0, 4
	la $a0, opcoes
	syscall
	# Lê base_entrada
	li $v0, 5
	syscall
	move $s0, $v0
	
	# Imprime string mensagem_base_saida
	li $v0, 4
	la $a0, mensagem_base_saida
	syscall
	# Imprime string opcoes
	li $v0, 4
	la $a0, opcoes
	syscall
	# Lê base_saida
	li $v0, 5
	syscall
	move $s1, $v0
	
	la $a0, numero
	jal toupper
	
	li $v0, 4
	la $a0, numero
	syscall
	
	li $v0, 10
	syscall
