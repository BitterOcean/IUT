.data
	backn: .asciiz "\n" 
.text
.globl main
main:
	addi $s0, $zero, 9 
	addi $s1, $zero, 0 
LOOP1: 
	addi $t0, $zero , 5
	slt $t0, $t0 , $s1 
	xori $t0 , $t0 , 1
	beq $t0, $zero, L1
	addi $t1, $s0 , 1 
	move $s0, $t1 
	addi $t1, $s1 , 1 
	move $s1, $t1 
	j LOOP1
L1: 
	move $a0, $s0 
	li $v0, 1
	syscall
	li $v0, 10
	syscall
