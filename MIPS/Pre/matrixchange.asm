.data
  matrix: .space 10000
  space: .asciiz " "
  enter: .asciiz "\n"

.macro  getindex(%ans, %i, %j, %m)
    mult %i, %m
    mflo %ans
    add %ans, %ans, %j
    sll %ans, %ans, 2
.end_macro

.text
  li $v0, 5
  syscall
  move $s0, $v0 # $s0 =  n
  li $v0, 5
  syscall
  move $s1, $v0 # $s1 =  m
  li $t0, 0     # $t0 
  
for_n_begin:
  slt $t2, $t0, $s0
  beq $t2, $zero, for_n_end
  nop
  li $t1, 0     # $t1
  
for_m_begin:
  slt $t2, $t1, $s1
  beq $t2, $zero, for_m_end
  nop
  li $v0, 5
  syscall
  getindex($t2, $t0, $t1, $s1)
  sw $v0, matrix($t2)
  addi $t1, $t1, 1
  jal for_m_begin
  nop

for_m_end:
  addi $t0, $t0, 1
  jal for_n_begin
  nop

for_n_end:
  move $t0, $s0     
  addi $t0, $t0, -1 # $t0 = n - 1
  
out_n:
  bltz $t0, out_n_end
  nop
  move $t1, $s1     
  addi $t1, $t1, -1 # $t1 = m - 1
  
out_m:
  bltz $t1, out_m_end
  nop
  getindex($t2, $t0, $t1, $s1)
  lw $t3, matrix($t2)
  bne $t3, $zero, if_have
  jal if_end
  nop

if_have:
  move $a0, $t0
  addi $a0, $a0, 1
  li $v0, 1
  syscall # print line
  la $a0, space
  li $v0, 4
  syscall # print space
  move $a0, $t1
  addi $a0, $a0, 1
  li $v0, 1
  syscall # print list
  la $a0, space
  li $v0, 4
  syscall # print space
  move $a0, $t3
  li $v0, 1
  syscall # print value
  la $a0, enter
  li $v0, 4
  syscall # print enter
 
if_end: 
  addi $t1, $t1, -1
  jal out_m
  nop
  
out_m_end:
  addi $t0, $t0, -1
  jal out_n
  nop
  
out_n_end:
  li $v0, 10
  syscall 
