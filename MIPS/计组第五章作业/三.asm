.data
  example100: .word 0 : 100
  
.macro end
    li $v0, 10
    syscall
.end_macro

.text
main:
  li $t0, 0 # $t0 = 0
  li $s0, 0 # $s0 = num
  
  # you may initialize the example
  
  loop:
    beq $t0, 100, loop_end
    sll $t1, $t0, 2
    lw $t1, example100($t1) # load value
    addu $s0, $s0, $t1
    addi $t0, $t0, 1
    j loop
    
  loop_end:
    sll $t1, $t0, 2
    sw $s0, example100($t1) # store num 
    end
  