.data
arr1: .space 256
arr2: .space 256
space: .asciiz " "
enter: .asciiz "\n"

# read a number
.macro scanInt(%des)
	li $v0 5
	syscall
	move %des $v0
.end_macro

# read a character
.macro scanChar(%des)
	li $v0 12
	syscall
	move %des $v0
.end_macro

# get the position of an element in the array
.macro getPos(%des,%i)
	sll %des %i 2
.end_macro


# push into stack
.macro push(%des)
	sw %des 0($sp)
	subi $sp $sp 4
.end_macro

# pop the stack
.macro pop(%des)
	addi $sp $sp 4
	lw %des 0($sp)
.end_macro

# finish program
.macro finish()
	li $v0 10
	syscall
.end_macro

# print a number
.macro printInt(%des)
	addi $a0 %des 0
	li $v0 1
	syscall
.end_macro

# print a string
.macro printString()
	li $v0 4
	syscall
.end_macro

# print '\n'
.macro enter()
	la $a0 enter
	li $v0 4
	syscall
.end_macro

# print ' '
.macro space()
	la $a0 space
	li $v0 4
	syscall
.end_macro 


.text
	scanInt($s0)
	li $t0 0
	for_begin_0:
		beq $t0 $s0 for_end_0
		
		scanInt($t1)
		getPos($t2,$t0)
		sw $t1, arr1($t2)
		
		
		addi $t0 $t0 1
		j for_begin_0
	for_end_0:
	
	scanInt($s1)
	li $t0 0
	for_begin_1:
		beq $t0 $s1 for_end_1

		scanInt($t1)
		getPos($t2,$t0)
		sw $t1, arr2($t2)

		addi $t0 $t0 1
		j for_begin_1
	for_end_1:
	
	li $t0 0
	li $t1 0

	# start merge

loop:	blt $t0 $s0 continue
	bge $t1 $s1 over
	continue:
		bne $t0 $s0 next0
		getPos($t7,$t1)
		lw $t2 arr2($t7)
		addi $t1 $t1 1
		j print
		
		next0:
		bne $t1 $s1 next1
		getPos($t7,$t0)
		lw $t2 arr1($t7)
		addi $t0 $t0 1
		j print
		
		next1:
		getPos($t7,$t0)
		getPos($t6,$t1)
		lw $t7 arr1($t7)
		lw $t6 arr2($t6)
		bge $t7 $t6 next2
		addi $t2 $t7 0
		addi $t0 $t0 1
		j print
		
		next2:
		addi $t2 $t6 0
		addi $t1 $t1 1
		
		
		print:

		# hint3: output the result
		# please code here
		printInt($t2)
		space()
		
		j loop

	
	over:
	finish()
