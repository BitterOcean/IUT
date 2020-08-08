.data
	backn: .asciiz "\n" 
.text
.globl main
func:
	addi $sp, $sp , -32
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	add $t0, $a0 , $a1 
	move $v0, $t0 
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	addi $sp, $sp , 32
	jr $ra
main:
	addi $a0, $zero , 3
	addi $a1, $zero , 7
	jal func
	move $s0, $v0
	move $a0, $s0 
	li $v0, 1
	syscall
	li $v0, 10
	syscall
