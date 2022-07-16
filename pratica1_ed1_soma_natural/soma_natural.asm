# O programa soma os n numeros naturais apartir de 0

# Mateus Herrera G. Borges	15.10.2019

.data
# Inteiros:
n:	.space 	4

# Strings:
str1:	.asciiz	"<< Soma de n valores naturais >>\n"
str2:	.asciiz	"Quantos números deseja somar? "
str3:	.asciiz	"A soma dos "
str4:	.asciiz	" primeiros números naturais é: "
str5:	.asciiz	"\n"

.text
main:
	li	$v0, 4
	la	$a0, str1
	syscall			# Imprime primeira mensagem
	
	li	$v0, 4
	la	$a0, str2
	syscall			# Imprime mensagem que pede
				#o numero natural
	
	li	$v0, 5
	syscall			# Le natural
	
	la	$s0, n
	sw	$v0, 0($s0)	# Salva valor lido na
				#memoria
	
	add	$a0, $zero, $v0	# Valor lido eh passado
				#como argumento

	jal	soma_naturais	# Chamada da funcao que
				#soma os n primeiros na-
				#turais
	
	add	$s0, $zero, $v0	# Retorno da funcao e
				#guardado em '$s0'
	
	li	$v0, 4
	la	$a0, str3
	syscall			# Imprime primeira msg
				#da soma
	
	la	$s2, n		# Pega valor de n
	lw	$s1, 0($s2)	#na memoria

	li	$v0, 1
	add	$a0, $zero, $s1
	syscall			# Imprime n
	
	li	$v0, 4
	la	$a0, str4
	syscall			# Imprime segunda msg
				#da soma
	
	li	$v0, 1
	add	$a0, $zero, $s0
	syscall			# Imprime resultado da
				#soma
	
	li	$v0, 4
	la	$a0, str5
	syscall			# '\n' final
	
	li	$v0, 10
	syscall			# 'return 0;'


soma_naturais:
	addi	$s0, $a0, 1	# Soma 1º termo (1) com
				#o último (n - $a0)
	
	mul	$s1, $s0, $a0	# Multiplica a soma ante-
				#rior por n (número de 
				#termos)
	
	srl	$v0, $s1, 1	# Divide a multiplicacao
				#por 2

	jr	$ra		# Retorna para 'main' 