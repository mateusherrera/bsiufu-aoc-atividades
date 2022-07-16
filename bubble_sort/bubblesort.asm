# BubbleSort - Implementacao e teste do Bubble Sort

# Mateus Herrera G Borges   11.10.2019

.data
vet:  .space 40
tamv: .space 4
str1: .asciiz "Digite valores para o array:"
str2: .asciiz "Valor "
str3: .asciiz ": "
str4: .asciiz "Valores do array:"
str5: .asciiz "\n"

.text
main:
	addi  $v0, $zero, 4
	la    $a0, str1
	syscall			# Imprime str1
	
	addi  $v0, $zero, 4
	la    $a0, str5
	syscall			# Imprime str5
	
	la    $s0, vet		# Carrega endereco de vet
	addi  $s1, $zero, 10
	la    $t0, tamv
	sw    $s1, 0($t0)	# Escreve na memoria o ta-
				#manho de vet

	add   $t0, $zero, $zero	# i = 0
FOR1:
	slt   $t1, $t0, $s1	# i < tamvet
	beqz  $t1, EXITF1	# Se a condicao acima eh
				#verdadeira segue para 
				#o corpo do for
	
	addi  $v0, $zero, 4
	la    $a0, str2
	syscall			# Imprime str2
	
	addi  $t0, $t0, 1	# ++i
	addi  $v0, $zero, 1
	add   $a0, $zero, $t0
	syscall			# Imprime valor de i + 1
				#compor str2
	
	addi  $v0, $zero, 4
	la    $a0, str3
	syscall			# Imprime str3
				#compor str2 ++ i+1
	
	addi  $v0, $zero, 5
	syscall			# Le elemento
	
	sw    $v0, 0($s0)	# Escreve valor lido na
				#memoria

	addi  $s0, $s0, 4	# Avanca para proxima
				#posicao livre do array
	
	j     FOR1

EXITF1: 
	la    $a1, vet
	la    $a2, tamv
	jal   PRINTV
	
	la    $a0, vet
	la    $t0, tamv
	lw    $a1, 0($t0)
	jal   BUBSORT
	
	la    $a1, vet
	la    $a2, tamv
	jal   PRINTV
	
	li    $v0, 10
	syscall


# Funcao para printar vetor
PRINTV:	
	addi  $v0, $zero, 4
	la    $a0, str5
	syscall

	lw    $s0, 0($a2)
	add   $t0, $zero, $zero
	add   $s1, $zero, $a1
	
	addi  $v0, $zero, 4
	la    $a0, str4
	syscall
	
	addi  $v0, $zero, 4
	la    $a0, str5
	syscall
	
FOR2:
	slt   $t1, $t0, $s0
	beqz  $t1, EXITF2
	
	addi  $v0, $zero, 4
	la    $a0, str2
	syscall
	
	addi  $t0, $t0, 1
	
	addi  $v0, $zero, 1
	add   $a0, $zero, $t0
	syscall
		
	addi  $v0, $zero, 4
	la    $a0, str3
	syscall
	
	addi  $v0, $zero, 1
	lw    $a0, 0($s1)
	syscall
	
	addi  $v0, $zero, 4
	la    $a0, str5
	syscall
	
	addi  $s1, $s1, 4
	
	j     FOR2

EXITF2:
	jr    $ra


# Funcao: Bubble Sort
BUBSORT:
	add   $s1, $zero, $a1
	addi  $s1, $s1, -1
	
	DW1:
		addi  $t0, $zero, -1
	
		add   $s0, $zero, $a0	
		add   $t1, $zero, $zero
		
		FOR3:
	
			slt   $t2, $t1, $s1
			beqz  $t2, EXITF3
	
			lw    $t3, 0($s0)
			lw    $t4, 4($s0)
	
			slt   $t5, $t4, $t3
			
			IF1:
			
				beqz  $t5, EXIT_IF1
	
				sw    $t3, 4($s0)
				sw    $t4, 0($s0)
				addi  $t0, $zero, 1

			EXIT_IF1:
			
			addi  $s0, $s0, 4
			addi  $t1, $t1, 1
			j     FOR3
	
		EXITF3:
		
		addi  $s1, $s1, -1
	
		slt   $t6, $t0, $zero
		beqz  $t6, DW1
	
	EXIT_DW1:
	
	add   $v0, $zero, $a0
	jr    $ra
