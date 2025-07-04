.data
  array: .word 0 : 100
  
.macro push(%src)
    sw %src, 0($sp)
    subi $sp, $sp, 4
.end_macro

.macro pop(%des)
    addi $sp, $sp, 4
    lw %des, 0($sp)
.end_macro

.macro end
    li $v0, 10
    syscall
.end_macro

.text
main:
  li $s0, 7 # $s0 = N
  move $a0, $s0
  la $a1, array
  jal FIB
  end 
  
FIB:
  
  #push
  
  move $t0, $a0 # $t0 = N
  move $t1, $a1 # $t1 = array
  li $t2, 1 # $t2 = i
  li $t3, 1 # $t3 = 
  
  loop:
    bgt $t2, $t0, loop_end
    
    
    
  loop_end:
    
  
  #pop