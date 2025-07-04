.data
  matrix1: .space 256
  matrix2: .space 256
  matrix: .space 256
  str_space: .asciiz " "
  str_enter: .asciiz "\n"
  
.macro getindex(%ans, %i, %j, %n)
    mult %i, %n
    mflo %ans
    add %ans, %ans, %j
    sll %ans, %ans, 2
.end_macro

.text
  li $v0, 5
  syscall
  move $s0, $v0 # $s0 = n
  li $t0, 0 # $t0 = i 
  
for_m1line_begin:
  slt $t2, $t0, $s0
  beq $t2, $zero, for_m1line_end
  li $t1, 0 # $t1 = j
  
for_m1list_begin:
  slt $t2, $t1, $s0
  beq $t2, $zero, for_m1list_end
  li $v0, 5
  syscall
  getindex($t2, $t0, $t1, $s0)
  sw $v0, matrix1($t2)
  addi $t1, $t1, 1
  jal for_m1list_begin    
  
for_m1list_end:
  addi $t0, $t0, 1
  jal for_m1line_begin
  
for_m1line_end:
  li $t0, 0 # $t0 = i
  
for_m2line_begin:
  slt $t2, $t0, $s0
  beq $t2, $zero, for_m2line_end
  li $t1, 0 # $t1 = j
  
for_m2list_begin:
  slt $t2, $t1, $s0
  beq $t2, $zero, for_m2list_end
  li $v0, 5
  syscall
  getindex($t2, $t0, $t1, $s0)
  sw $v0, matrix2($t2)
  addi $t1, $t1, 1
  jal for_m2list_begin    
  
for_m2list_end:
  addi $t0, $t0, 1
  jal for_m2line_begin
  
for_m2line_end:
  li $t0, 0 # $t0 = i
  
for_nline_begin:
  slt $t2, $t0, $s0
  beq $t2, $zero, for_nline_end
  li $t1, 0 # $t1 = j
  
for_nlist_begin:
  slt $t2, $t1, $s0
  beq $t2, $zero, for_nlist_end
  li $t7, 0 # $t7 = k
  li $s1, 0 # $s1 = value
  
forn:
  slt $t2, $t7, $s0
  beq $t2, $zero, forn_end
  getindex($t2, $t0, $t7, $s0) # 
  getindex($t3, $t7, $t1, $s0) #
  lw $t2, matrix1($t2)
  lw $t3, matrix2($t3)
  mult $t2, $t3
  mflo $t4
  add $s1, $s1, $t4
  addi $t7, $t7, 1
  jal forn

forn_end:
  getindex($t2, $t0, $t1, $s0)
  sw $s1, matrix($t2)
  move $a0, $s1
  li $v0, 1
  syscall
  la $a0, str_space
  li $v0, 4
  syscall
  addi $t1, $t1, 1
  jal for_nlist_begin
      
for_nlist_end:
  la $a0, str_enter
  li $v0, 4
  syscall
  addi $t0, $t0, 1
  jal for_nline_begin
  
for_nline_end:
  li $v0, 10
  syscall
  
