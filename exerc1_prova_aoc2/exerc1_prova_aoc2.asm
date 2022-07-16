# Programa que implementa o exercicio 1 da prova 1
#de 2019-01 da turma de AOCII

# O programa le um inteiro, calcula um polinomio e retorno
#seu valor

# DDA e Turma AOC(BSI)  07.10.2019

.data
x:    .space 4
str1: .asciiz "Entre com um inteiro: "
str2: .asciiz "O resultado é "

.text
MAIN:	
	addi $v0, $zero, 4
	la   $a0, str1
	syscall

	# le um inteiro
	addi $v0, $zero, 5
	syscall
	la   $t0, x
	sw   $v0, 0($t0)
	
	# invoca a funcao COMPUTA
	add  $a0, $zero, $v0
	jal  COMPUTA
	
	# $v0 contem o retorno da funcao
	add  $s0, $zero, $v0
	
	addi $v0, $zero, 4
	la   $a0, str2
	syscall

	addi $v0, $zero, 1
	add  $a0, $zero, $s0
	syscall
	
	
	li   $v0, 10
	syscall
	
	
COMPUTA: # x² + x + 42
	
	add  $t0, $zero, $a0
	add  $t1, $zero, $zero

	LOOP1:
	
		beqz $t0, EXIT_LOOP1
		add  $t1, $t1, $a0
		
		addi $t0, $t0, -1
		j    LOOP1

	EXIT_LOOP1:

	add  $t1, $t1, $a0
	addi $v0, $t1, 42
		
	jr   $ra