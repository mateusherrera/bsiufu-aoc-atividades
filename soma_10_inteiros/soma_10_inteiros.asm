#	O programa soma de 1 até 10.
#
#	Mateus Herrera G. Borges	11/12/2019

.data

.text
MAIN:
	
	addi	$s0, $zero, 10				# Contador para o FOR1
	add	$s1, $zero, $zero			# Recebe a soma dos inteiros
	
	FOR1:
		
		beqz	$s0, EXIT_FOR1			# Condicao do FOR1
		
		add	$s1, $s1, $s0			# Faz a soma
		
		addi	$s0, $s0, -1			# Decrementa o Contador
		
	EXIT_FOR1:

	li	$v0, 10
	syscall						# Finaliza o programa