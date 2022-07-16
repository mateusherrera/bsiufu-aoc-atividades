# O programa lê 10 números inteiros, salva-os em um array e soma todos
#os números pares

.data:
vetor: .space 40
str1:  .asciiz "Digite 10 inteiros:\n"
str2:  .asciiz "O resultado da soma é "

.text:
MAIN:
	# Imprime String str1
	addi $v0, $zero, 4
	la   $a0, str1
	syscall
	
	# Prepara $s6 para a soma dos nums pares
	add  $s6, $zero, $zero
	
	# Carrega endereço 0 do vetor para $s7
	la   $s7, vetor
	
	# loop para ler números e somá-los (apenas os pares)
	addi $s0, $zero, 10
	addi $s3, $zero, 0x00000001
LOOP1:	addi $v0, $zero, 5
	syscall
	
	sw   $v0, 0($s7)
	lw   $s5, 0($s7)
	addi $s7, $s7, 4
	
	# se o num lido é par soma-se ele em $s6
	and  $t0, $s5, $s3
	bne  $t0, $zero, NAO1
	
	add  $s6, $s6, $s5
	
	# senão segue o loop normalmente
NAO1:	addi $s0, $s0, -1
	bne  $s0, $zero, LOOP1
	# fim loop
	
	# Imprime resultado
	addi $v0, $zero, 4
	la   $a0, str2
	syscall
	
	li   $v0, 1
	add  $a0, $zero, $s6
	syscall
	
	addi $v0, $zero, 10
	syscall
