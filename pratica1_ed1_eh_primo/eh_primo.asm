# Programa que verifica se um valor lido eh primo ou nao

# Mateus Herrera G. Borges	15.10.2019

.data
# Inteiros:
num:	.space	4

# String:
str1:	.asciiz	"<< É primo? >>\n"
str2:	.asciiz	"Entre com um candidato: "
str3:	.asciiz	"O número "
str4:	.asciiz	" é primo\n"
str5:	.asciiz	" não é primo\n"

.text
main:
	li	$v0, 4
	la	$a0, str1
	syscall			# Imprime titulo
	
	li	$v0, 4
	la	$a0, str2
	syscall			# Imprime msg
	
	li	$v0, 5
	syscall			# Le candidato
	
	la	$s0, num
	sw	$v0, 0($s0)	# Salva valor lido na
				#memoria
	
	add	$a0, $zero, $v0	# Argumento da funcao
				#abaixo

	jal	eh_primo	# Chamada da funcao
				#'eh_primo'
	
	add	$s0, $zero, $v0	# Pega retorno da funcao
				#'eh_primo'
	
	li	$v0, 4
	la	$a0, str3
	syscall			# Imprime primeira msg
				#da saida
	
	la	$s1, num
	lw	$s2, 0($s1)	# Le valor de num da me-
				#moria
	
	li	$v0, 1
	add	$a0, $zero, $s2
	syscall			# Imprime num
	
	li	$v0, 4
	beqz	$s0, nao_primo	# Segundo o retorno da
				#funcao, se $v0 igual à 0
				#num nao eh primo, caso
				#contrario eh primo
	
primo:
	# Eh_primo
	la	$a0, str4
	syscall			# Msg para valor primo
	
	j	EXIT1		# Jump para final do
				#programa
	
nao_primo:
	# Nao_primo
	la	$a0, str5
	syscall			# Msg para valor nao
				#primo
	
EXIT1:
	li	$v0, 10
	syscall			# 'return 0;'


eh_primo:
	add	$s0, $zero, $a0	# Pega argumento 'a0'

	srl	$s0, $s0, 1	# Divide por 2 (trun-
				#cando para baixo)
	
	addi	$s1, $zero, 1	# Guarda valor 1
FOR1:
	slt	$t0, $s1, $s0	# Se 1 < 's0' - 't0' = 1
				# Senao 't0' = 0
	
	beqz	$t0, EXITFOR1	# Se 't0' == 0 - sai do loop
	####### Corpo do for #######
	
	div	$a0, $s0	# Divide 'a0' (num)
				#por 's0' (candidato de
				#divisor)
	
	mfhi	$s2		# Coloca em 's0' o resto
				#da divisao acima
	
	beqz	$s2, EXIT2_ESP	# Se resto == 0 há outro
				#divisor, entao num não
				#eh primo
	
	####### Corpo do for #######
	addi	$s0, $s0, -1	# Decrementa 's0'	
	j	FOR1
	
EXITFOR1:
	addi	$v0, $zero, 1	# Numero eh primo
	j	EXITFUNC	# Sai da funcao

EXIT2_ESP:
	add	$v0, $zero, $zero
				# Numero nao eh primo
	
EXITFUNC:
	jr	$ra		# Retorna para main