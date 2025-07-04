.data
  str_enter: .asciiz "\n"
  
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
  li $a0, 5 # initial
  jal ABS
  printInt($v0)
  printEnter
  li $a0, -6 # initial
  jal ABS
  printInt($v0)
  printEnter
  end
  
ABS:
  push($ra)
  push($t0)
  #push
  
  move $t0, $a0 # $t0 = x
  
  bltz $t0, if_less
  else:
    move $v0, $t0
    j return
  
  if_less:
    sub $v0, $zero, $t0 
  
  return:
    pop($t0)
    pop($ra)
    #pop
    jr $ra
  