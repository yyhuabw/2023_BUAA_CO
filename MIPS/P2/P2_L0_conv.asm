.data
  matrix1: .word 0 : 100 # m1*n1
  matrix2: .word 0 : 100 # m2*n2
  matrix: .word 0 : 100 # m*n
  str_space: .asciiz " "
  str_enter: .asciiz "\n"
  
.macro getInt(%ans)
    li $v0, 5
    syscall
    move %ans, $v0
.end_macro

.macro printInt(%ans)
    move $a0, %ans
    li $v0, 1
    syscall
.end_macro

.macro getindex(%ans, %i, %j, %n)
    mult %i, %n
    mflo %ans
    addu %ans, %ans, %j
    sll %ans, %ans, 2
.end_macro

.macro printSpace
    la $a0, str_space
    li $v0, 4
    syscall
.end_macro

.macro printEnter
    la $a0, str_enter
    li $v0, 4
    syscall
.end_macro

.macro end
    li $v0, 10
    syscall
.end_macro

.text
main:
  getInt($s0) # $s0 = m1
  getInt($s1) # $s1 = n1
  getInt($s2) # $s2 = m2
  getInt($s3) # $s3 = n2
  subu $s4, $s0, $s2
  addi $s4, $s4, 1 # $s4 = m
  subu $s5, $s1, $s3
  addi $s5, $s5, 1 # $s5 = n
  
  # store matrix1
  li $t0, 0 # $t0 = i
  for_m1:
    beq $t0, $s0, for_m1_end
    li $t1, 0 # $t1 = j
    for_n1:
      beq $t1, $s1, for_n1_end
      getInt($t2) # $t2 = value
      getindex($t3, $t0, $t1, $s1) # $t3 = location
      sw $t2, matrix1($t3)
      addi $t1, $t1, 1
      j for_n1
    
    for_n1_end:
      addi $t0, $t0, 1
      j for_m1
    
  for_m1_end:
    li $t0, 0 # $t0 = i
    
  # store matrix2
  for_m2:
    beq $t0, $s2, for_m2_end
    li $t1, 0 # $t1 = j
    for_n2:
      beq $t1, $s3, for_n2_end
      getInt($t2) # $t2 = value
      getindex($t3, $t0, $t1, $s3) # $t3 = location
      sw $t2, matrix2($t3)
      addi $t1, $t1, 1
      j for_n2
    
    for_n2_end:
      addi $t0, $t0, 1
      j for_m2
    
  for_m2_end:
    li $t0, 0 # $t0 = i
    
  # matrix
  for_m:
    beq $t0, $s4, for_m_end
    li $t1, 0 # $t1 = j
    for_n:
      beq $t1, $s5, for_n_end
      
      # g(i,j)
      li $s6, 0 # $s6 = g(i,j)
      li $t2, 0 # $t2 = k
      for_k:
        beq $t2, $s2, for_k_end
        li $t3, 0 # $t3 = l
        for_l:
          beq $t3, $s3, for_l_end
          addu $t4, $t2, $t0 # i + k
          addu $t5, $t3, $t1 # j + l
          getindex($t6, $t4, $t5, $s1)
          lw $t6, matrix1($t6)
          getindex($t7, $t2, $t3, $s3)
          lw $t7, matrix2($t7)
          mult $t6, $t7
          mflo $t4
          addu $s6, $s6, $t4
          addi $t3, $t3, 1
          j for_l
          
        for_l_end:
          addi $t2, $t2, 1
          j for_k
        
      for_k_end:
        printInt($s6)
      
      printSpace
      addi $t1, $t1, 1
      j for_n
    
    for_n_end:
      printEnter
      addi $t0, $t0, 1
      j for_m
    
  for_m_end:
    end
    