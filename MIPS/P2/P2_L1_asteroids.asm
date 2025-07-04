.data
  st: .word 0 : 64
  asteroids: .word 0 : 64
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
  getInt($s0) # $s0 = asteroidsSize
  li $t0, 0 # $t0 = i
  
  for_asize1:
    beq $t0, $s0, for_asize1_end
    getInt($t1)
    sll $t2, $t0, 2
    sw $t1, asteroids($t2)
    add $t0, $t0, 1
    j for_asize1
    
  for_asize1_end:
    li $s1, 0 # $s1 = pos
    li $t0, 0 # $t0 = i
  
  for_asize2:
    beq $t0, $s0, for_asize2_end
    li $t1, 1 # $t1 = alive
    
    while:
      bne $t1, 1, while_end
      sll $t2, $t0, 2
      lw $t2, asteroids($t2) # $t2 = asteroids[i]
      bgez $t2, while_end
      blez $s1, while_end
      sub $t3, $s1, 1
      sll $t3, $t3, 2
      lw $t3, st($t3) # $t3 = st[pos - 1]
      blez $t3, while_end
      sub $t4, $zero, $t2 # $t4 = -asteroids[i]
      slt $t1, $t3, $t4
      ble $t3, $t4, if_lesse
      j if_lesse_end
      
      if_lesse:
        sub $s1, $s1, 1
      
      if_lesse_end:
        j while
      
    while_end:
      beq $t1, 1, if_alive
      j if_alive_end
      
      if_alive:
        sll $t3, $s1, 2
        sw $t2, st($t3)
        add $s1, $s1, 1
        
      if_alive_end:
        add $t0, $t0, 1
        j for_asize2
    
  for_asize2_end:
    printInt($s1)
    printEnter
    li $t0, 0 # $t0 = i
  
  for_asize3:
    beq $t0, $s1, for_asize3_end
    sll $t2, $t0, 2
    lw $t2, st($t2)
    printInt($t2)
    printSpace
    add $t0, $t0, 1
    j for_asize3
    
  for_asize3_end:
    end
    
