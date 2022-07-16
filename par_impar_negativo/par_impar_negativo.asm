# O programa le um array de 10 unsigned int's, depois:
#	1 - conta a quantidade de pares
#	2 - conta a quantidade de impares
#	3 - conta quantos numeros poderiam ser
#	    valores negativos

# Mateus Herrera G. Borges	17.10.2019

.data
# Unsigned Int:
vet:		.space	40		#vetor
tam_vet:	.space	4

# Strings:
str1:		.asciiz	"<< Vetor de 10 inteiros sem sinal >>\n"
str2:		.asciiz	"Entre com o valor: "
str3:		.asciiz	"Foram digitados "
str4:		.asciiz	"par(es).\n"
str5:		.asciiz	"ímpar(es).\n"
str6:		.asciiz	"número(s) que poderiam ser negativos.\n"

.text
main:
	li	$v0, 4
	la	$a0, str1
	syscall			# Imprime titulo
	
	li	$t0, 10
	la	$t1, tam_vet
	sw	$t0, 0($t1)	# Salva na memoria o tamanho
				#do vetor (10)
	
	la	$s0, vet	# 's0' = 1ª endereco 
				#do vet
	
	lw	$s1, 0($t1)	# i = tam_vet
FOR1:
	beqz	$s1, EXITFOR1
	
	####### Corpo FOR1 #######
	
	li	$v0, 4
	la	$a0, str2
	syscall			# Imprime msg
	
	li	$v0, 5
	syscall			# Le inteiro
	
	add	$a0, $zero, $v0	# Salva valor lido para
				#arg da funcao
	
	sw	$s0, 0($sp)
	addi	$sp, $sp, -4	# Salva inf na pilha
	
	sw	$s1, 0($sp)
	addi	$sp, $sp, -4	# Salva inf na pilha
	
	jal	verifica_unsigned
	
	addi	$sp, $sp, 4
	lw	$s1, 0($sp)	# Restaura da pilha
	
	addi	$sp, $sp, 4
	lw	$s0, 0($sp)	# Restaura da pilha
	
	sw	$v0, 0($s0)	# Salva valor lido no vetor

	addi	$s0, $s0, 4	# Avanca vetor
	
	####### Corpo FOR1 #######
	
	addi	$s1, $s1, -1
	j	FOR1
EXITFOR1:
	la	$t0, tam_vet
	lw	$a1, 0($t0)	# Argumento tamanho do vetor
	la	$a0, vet

	jal	par
	
	add	$s0, $zero, $v0	# Pega retorno da funcao
	
	li	$v0, 4
	la	$a0, str3
	syscall			# Imprime msg
	
	li	$v0, 1
	add	$a0, $zero, $s0
	syscall			# Imprime qtd de pares
	
	li	$v0, 4
	la	$a0, str4
	syscall			# Imprime msg
	
	la	$t0, tam_vet
	lw	$a1, 0($t0)	# Argumento tamanho do vetor
	la	$a0, vet
	
	jal	impar
	
	add	$s0, $zero, $v0	# Pega retorno da funcao
	
	li	$v0, 4
	la	$a0, str3
	syscall			# Imprime msg
	
	li	$v0, 1
	add	$a0, $zero, $s0
	syscall			# Imprime qtd de impares
	
	li	$v0, 4
	la	$a0, str5
	syscall			# Imprime msg
	
	la	$t0, tam_vet
	lw	$a1, 0($t0)	# Argumento tamanho do vetor
	la	$a0, vet
	
	jal	qtd_cand_neg
	
	add	$s0, $zero, $v0	# Pega retorno da funcao
	
	li	$v0, 4
	la	$a0, str3
	syscall			# Imprime msg
	
	li	$v0, 1
	add	$a0, $zero, $s0
	syscall			# Imprime qtd de candi-
				#datos negativos.
	
	li	$v0, 4
	la	$a0, str6
	syscall			# Imprime msg

	li	$v0, 10
	syscall			# 'return 0;'


##
#	verifica_unsigned:
##
verifica_unsigned: