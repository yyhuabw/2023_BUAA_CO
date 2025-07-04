.data
  array: .space 80
  
.text
  li $v0, 5
  syscall
  move $s0, $v0 # $s0 = n
  li $t0, 0 # $t0 = i
  
for_1_begin:
  slt $t1, $t0, $s0
  beq $t1, $zero, for_1_end
  li $v0, 12
  syscall
  sll $t1, $t0, 2
  sw $v0, array($t1)
  addi $t0, $t0, 1
  jal for_1_begin
  
for_1_end:
  move $t0, $s0
  addi $t0, $t0, -1 # $t0 = n-1
  li $t1, 0 # $t1 = i
  
for_2_begin:
  bltz $t0, for_2_end
  nop
  sll $t3, $t0, 2
  sll $t4, $t1, 2
  lw $t3, array($t3) # $t3 = -value
  lw $t4, array($t4) # $t4 = +value
  bne $t3, $t4, notequal
  nop
  addi $t0, $t0, -1
  addi $t1, $t1, 1
  jal for_2_begin
  nop
  
for_2_end:
  li $a0, 1 # flag
  li $v0, 1
  syscall
  li $v0,10
  syscall
  
notequal:
  li $a0, 0 # flag
  li $v0, 1
  syscall
  li $v0,10
  syscall
  