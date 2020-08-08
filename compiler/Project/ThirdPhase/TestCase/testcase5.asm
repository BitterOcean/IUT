.data
	backn: .asciiz "\n" 
.text
.globl main
main:
	addi $a0, $zero, 8 
	li $v0, 9 
	syscall
	move $s0, $v0
	addi $s1, $zero, 2 
	addi $t0, $s1 , 5 
	slti $t1, $t0 , 10 
	beq $t1, $zero, L1
	addi $t2, $zero , 0
	sw $t2, 4($s0)
	addi $t2, $zero , 6
	sw $t2, 0($s0)
	L1 : 
	lw $t2, 0($s0)
	move $a0, $t2 
	li $v0, 1
	syscall
	lw $t3, 4($s0)
	move $a0, $t3 
	li $v0, 1
	syscall
	li $v0, 10
	syscall
