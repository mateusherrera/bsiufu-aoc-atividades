# O programa primeiro lera e salvara na memoria 42 inteiros
#sem sinal e depois fara:
#	1 - soma de todos
#	2 - achar maior deles
#	3 - achar menor deles
# Apos imprimir na tela cada resultado

# Mateus Herrera G. Borges	15.10.2019

.data
# Inteiros:
tam_vet:	.space	4
maior:		.space	4
menor:		.space	4
soma:		.space	4

# Inteiros sem sinal:
vet:		.space	168		# Vetor

# String:
str1:		.asciiz	"<< Vetor de Unsigned Int >>\n"
str2:		.asciiz	"Entre com o proximo valor: "
str3:		.asciiz	"O maior é "
str4:		.asciiz	"O menor é "
str5:		.asciiz	"A soma é "
str6:		.asciiz	"\n"

.text
main:
	li	$v0, 4
	la	$a0, str1
	syscall			# Imprime titulo
	
	la	$s0, vet	# Pega endereco de 'vet'
	addi	$s1, $zero, 10	# i = tam_vet
	
	la	$s2, tam_vet
	sw	$s1, 0($s2)	# Salva na memoria o
				#tamanho do vetor

FOR1:
	beqz	$s1, EXITFOR1
	####### Corpo FOR1 #######
	
	li	$v0, 4
	la	$a0, str2
	syscall			# Imprime msg para pedir
				#entrada do numero
	
	li	$v0, 5
	syscall			# Le numero
	
	sw	$v0, 0($s0)
	addi	$s0, $s0, 4
	
	####### Corpa FOR1 #######
	addi	$s1, $s1, -1
	j	FOR1
	
EXITFOR1:
	li	$v0, 4
	la	$a0, str3
	syscall			# Imprime saida para
				#maior

	la	$a0, vet	# Argumento para funcao
				#(vetor)
	
	la	$s2, tam_vet
	lw	$a1, 0($s2)	# Argumento para funcao
				#(tamanho do vetor)
	
	jal	acha_maior	# Acha maior valor
	
	add	$a0, $zero, $v0
	li	$v0, 1
	syscall			# Imprime maior valor
	
	li	$v0, 4
	la	$a0, str6
	syscall			# Quebra de linha
	
	li	$v0, 4
	la	$a0, str4
	syscall			# Imprime saida para
				#menor
	
	la	$a0, vet	# Argumento para funcao
				#(vetor)
	
	la	$s2, tam_vet
	lw	$a1, 0($s2)	# Argumento para funcao
				#(tamanho do vetor)	
	
	jal	acha_menor	# Acha menor valor
	
	add	$a0, $zero, $v0
	li	$v0, 1
	syscall			# Imprime menor valor
	
	li	$v0, 4
	la	$a0, str6
	syscall			# Quebra de linha
	
	li	$v0, 4
	la	$a0, str5
	syscall			# Imprime saida para
				#soma
	
	la	$a0, vet	# Argumento para funcao
				#(vetor)
	
	la	$s2, tam_vet
	lw	$a1, 0($s2)	# Argumento para funcao
				#(tamanho do vetor)
	
	jal	calcula_soma	# Calcula a soma dos
				#elementos do vetor
	
	add	$a0, $zero, $v0
	li	$v0, 1
	syscall			# Imprime soma 
				#dos elementos
	
	li	$v0, 4
	la	$a0, str6
	syscall			# Quebra de linha
	
	li	$v0, 10
	syscall			# 'return 0;'


##
#	Maior:
##
acha_maior:
	add	$s0, $zero, $a0	# Pega endereco de vet
	
	lw	$s7, 0($s0)	# Guarda primeiro candi-
				#dato para maior
	
	addi	$s0, $s0, 4	# Avanca para proximo
				#elemento do vetor
	
	addi	$t0, $a1, -1	# i = tamanho do vetor
FOR2:
	beqz	$t0, EXITFOR2
	####### Corpo FOR2 #######
	
	lw	$s1, 0($s0)
	slt	$t1, $s7, $s1
	beqz	$t1, IFFALSE1

IFTRUE1:
	add	$s7, $zero, $s1
	
IFFALSE1:
	addi	$s0, $s0, 4	# Avanca vetor
	
	####### Corpo FOR2 #######
	addi	$t0, $t0, -1
	j	FOR2
	
EXITFOR2:
	add	$v0, $zero, $s7
	jr	$ra


##
#	Menor:
##
acha_menor:
	add	$s0, $zero, $a0	# Pega endereco de vet
	
	lw	$s7, 0($s0)	# Guarda primeiro candi-
				#dato para menor
	
	addi	$s0, $s0, 4	# Avanca para proximo
				#elemento do vetor
	
	add	$t0, $a1, -1	# i = tamanho do vetor
FOR3:
	beqz	$t0, EXITFOR3
	####### Corpo FOR2 #######
	
	lw	$s1, 0($s0)
	slt	$t1, $s1, $s7
	beqz	$t1, IFFALSE2

IFTRUE2:
	add	$s7, $zero, $s1
	
IFFALSE2:
	addi	$s0, $s0, 4	# Avanca vetor
	
	####### Corpo FOR2 #######
	addi	$t0, $t0, -1
	j	FOR3
	
EXITFOR3:
	add	$v0, $zero, $s7
	jr	$ra


##
#	Soma:
##
calcula_soma:
	add	$s0, $zero, $a0	# Pega endereco de vet
	
	lw	$s7, 0($s0)	# Guarda primeiro elemen-
				#to do vetor
	
	addi	$s0, $s0, 4	# Avanca para proximo
				#elemento do vetor
	
	add	$t0, $a1, -1	# i = tamanho do vetor
FOR4:
	beqz	$t0, EXITFOR4
	####### Corpo FOR2 #######
	
	lw	$s1, 0($s0)
	add	$s7, $s7, $s1
	addi	$s0, $s0, 4
	
	####### Corpo FOR2 #######
	addi	$t0, $t0, -1
	j	FOR4
	
EXITFOR4:
	add	$v0, $zero, $s7
	jr	$ra