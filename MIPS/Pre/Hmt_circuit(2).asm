.data
	array_had: .space 800
	array_a: .space 80
	char_space: .asciiz " "
	char_endl: .asciiz "\n"
 
 
.text
 
main:
	la $s0,array_had
	la $s1,array_a
#la $s2,int_n
#la $s3,int_m
#la $s4,int_all
#la $s5,int_mark
	li $s4,0
	li $s5,2
#one
	li $s6,1 
 
	li $v0,5
	syscall
	move $s2,$v0
 
	li $v0,5
	syscall
	move $s3,$v0
 
# for m
	li $t1,0
	for_m_st:
		beq $t1,$s3,for_m_ed
		nop
 
		li $v0,5
		syscall
		move $t6,$v0
 
		li $v0,5
		syscall
		move $t7,$v0
 
		move $a0,$t6
		move $a1,$t7
		
		jal get_id
		mul $v0,$v0,4
		add $t2,$s0,$v0 
		sw $s6,0($t2)
 
		#swap
		move $a0,$t7
		move $a1,$t6
 
		jal get_id
		mul $v0,$v0,4
		add $t2,$s0,$v0
		sw $s6,0($t2)
 
		addi $t1,$t1,1
		j for_m_st
		nop
	for_m_ed:
 
	sw $s6,4($s1)
	li $a0,2
	jal dfs
 
	move $a0,$s4
	li $v0,1
	syscall
 
	li $v0,10
	syscall
 
get_id:
	mul $a0,$a0,$s2
	add $v0,$a0,$a1
	jr $31
 
dfs:
 
	sw $ra,0($sp)
	subi $sp,$sp,4
	sw $a0,0($sp)
	subi $sp,$sp,4
 
	bgt $a0,$s2,if_check_then
	nop
	j if_check_end
 
	if_check_then:
		
		li $t1 1
		mul $t1,$t1,4
		add $t1,$t1,$s1
		lw $t1,0($t1)
		move $a0,$t1
 
		move $t1,$s2
		mul $t1,$t1,4
		add $t1,$t1,$s1
		lw $t1,0($t1)
		move $a1,$t1
 
		jal get_id
		mul $v0,$v0,4
		add $t1,$s0,$v0
		lw $t1,0($t1)
		or $s4,$s4,$t1
 
		addi $sp,$sp,4
		addi $sp,$sp,4
		lw $ra,0($sp)
		jr $31
 
	if_check_end:
 
	bne $a0,$0,dfs_work
 
	dfs_work:
		#for_dfs
		li $t1,1
		for_dfs_st:
			bgt $t1,$s2,for_dfs_ed
			nop
 
				sllv $t2,$s6,$t1
				and $t2,$s5,$t2
				seq $t2,$t2,0
 
				addi $sp,$sp,4
				lw $t3,0($sp)
				subi $sp,$sp,4
				sub $t3,$t3,1
 
				mul $t3,$t3,4
				add $t3,$t3,$s1
				lw $t3,0($t3)
				move $a0,$t3
				move $a1,$t1
 
				jal get_id
				mul $v0,$v0,4
				add $t3,$v0,$s0
				lw $t3,0($t3)
				
				and $t2,$t2,$t3
 
				beq $t2,$s6,if_mark_then
				nop
				j if_mark_end
 
				if_mark_then:
 
					# t3  = a0
					addi $sp,$sp,4
					lw $t3,0($sp)
					subi $sp,$sp,4
 
					sw $s5,0($sp)
					subi $sp,$sp,4
 
					sllv $t2,$s6,$t1
					or $s5,$s5,$t2
 
					mul $t2,$t3,4
					add $t2,$s1,$t2
					sw $t1,0($t2)
 
					sw $t1,0($sp)
					subi $sp,$sp,4
 
					addi $a0,$t3,1
					jal dfs
 
					addi $sp,$sp,4
					lw $t1,0($sp)
 
					addi $sp,$sp,4
					lw $s5,0($sp)
 
				if_mark_end:
 
			addi $t1,$t1,1
			j for_dfs_st
		for_dfs_ed:
 
			addi $sp,$sp,4
			addi $sp,$sp,4
			lw $ra,0($sp)
			jr $31