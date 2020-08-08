.data
	backn: .asciiz "\n" 
.text
.globl main
main:
	addi $t0, $zero , 15 
	addi $t1, $zero , 3 
	add $t2, $t0 , $t1 
	move $s0, $t2 
	addi $t0, $s0 , -10 
	addi $t1, $zero , 4 
	mul $t1, $t0 , $t1 
	addi $t0, $t1 , 2 
	addi $t1, $zero , 6 
	sub $t2, $t0 , $t1 
	move $s1, $t2 
	move $a0, $s0 
	li $v0, 1
	syscall
	move $a0, $s1 
	li $v0, 1
	syscall
	li $v0, 10
	syscall
