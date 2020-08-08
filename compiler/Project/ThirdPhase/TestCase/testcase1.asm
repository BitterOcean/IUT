.data
	backn: .asciiz "\n" 
.text
.globl main
main:
	addi $s0, $zero, 3 
	addi $s1, $zero, 9 
	add $t0, $s1 , $s0 
	move $s1, $t0 
	move $a0, $s1 
	li $v0, 1
	syscall
	li $v0, 10
	syscall
