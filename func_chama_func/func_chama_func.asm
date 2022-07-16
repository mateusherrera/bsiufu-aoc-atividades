# Le valor e salva na memoria (Pratica para chamada
#dupla de funcao)

# Mateus Herrera G Borges

.data
str0:  .asciiz "Vai\n"
str1:  .asciiz "dar\n"
str2:  .asciiz "certo"
str3:  .asciiz "!\n"

.text
main:
	addi  $v0, $zero, 4
	la    $a0, str0
	syscall
	
	jal   FUNC1
	
	addi  $v0, $zero, 4
	la    $a0, str3
	syscall
	
	li    $v0, 10
	syscall


FUNC1:
	sw    $ra, 0($sp)
	addi  $sp, $sp, -4

	addi  $v0, $zero, 4
	la    $a0, str1
	syscall

	jal   FUNC2
	
	addi  $sp, $sp, 4
	lw    $ra, 0($sp)
	jr    $ra
	
FUNC2:
	addi  $v0, $zero, 4
	la    $a0, str2
	syscall

	jr    $ra
