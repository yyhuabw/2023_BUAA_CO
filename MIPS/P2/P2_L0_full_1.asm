.data
  symbol: .word 0 : 7
  array: .word 0 : 7
  str_space: .asciiz " "
  str_enter: .asciiz "\n"
  
.macro getInt(%ans)
    li $v0, 5
    syscall
    move %ans, $v0
.end_macro

.macro push(%src)
    sw %src, 0($sp)
    subi $sp, $sp, 4
.end_macro

.macro pop(%des)
    addi $sp, $sp, 4
    lw %des, 0($sp)
.end_macro

.macro printInt(%ans)
    move $a0, %ans
    li $v0, 1
    syscall
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
  getInt($s0) # $s0 = n
  move $a0, $zero
  jal FullArray
  end
  
FullArray:
  push($ra)
  push($t0)
  push($t1)
  push($t2)
  push($t3)
  #push
  
  move $t0, $a0 # $t0 = index
  bge $t0, $s0, if_in
  j if_in_end
  
  if_in:
    li $t1, 0 # $t1 = i
    for_n1:
      beq $t1, $s0, for_n1_end
      sll $t2, $t1, 2
      lw $t2, array($t2) # $t2 = array[i]
      printInt($t2)
      printSpace
      addi $t1, $t1, 1
      j for_n1
    
    for_n1_end:
      printEnter
      j return
    
  if_in_end:
    li $t1, 0 # $t1 = i
    for_n2:
      beq $t1, $s0, for_n2_end
      sll $t2, $t1, 2
      lw $t2, symbol($t2) # $t2 = symbol[i]
      beq $t2, $zero, if_sy
      j if_sy_end
      
      if_sy:
        addi $t3, $t1, 1
        sll $t2, $t0, 2
        sw $t3, array($t2) # $t2 = index*4
        li $t3, 1
        sll $t2, $t1, 2
        sw $t3, symbol($t2) # $t2 = i*4
        addi $t3, $t0, 1
        move $a0, $t3
        jal FullArray
        li $t3, 0
        sll $t2, $t1, 2
        sw $t3, symbol($t2) # $t2 = i*4
      
      if_sy_end:
        addi $t1, $t1, 1
        j for_n2
    
    for_n2_end:
      j return
       
  return:
  pop($t3)
  pop($t2)
  pop($t1)
  pop($t0)
  pop($ra)
  #pop
  jr $ra
  