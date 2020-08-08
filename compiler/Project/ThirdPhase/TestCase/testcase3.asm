.data
	backn: .asciiz "\n" 
.text
.globl main
main:
	addi $a0, $zero, 40 
	li $v0, 9 
	syscall
	move $s0, $v0
	addi $s1, $zero, 0 
LOOP1: 
	slti $t0, $s1 , 10 
	beq $t0, $zero, L1
	sll $t1, $s1 , 2
	add $t1, $t1 , $s0
	sw $s1, 0($t1)
	sll $t1, $s1 , 2
	add $t1, $t1 , $s0
	lw $t1, 0($t1)
	addi $sp, $sp , -4
	sw $a0, 0($sp)
	move $a0, $t1 
	li $v0, 1
	syscall
	lw $a0, 0($sp)
	addi $sp, $sp , 4
	addi $t2, $s1 , 1 
	move $s1, $t2 
	j LOOP1
L1: 
	li $v0, 10
	syscall
