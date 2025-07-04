.data
  SRC: .word 0 : 100
  DEST: .word 0 : 100
  
.macro end
    li $v0, 10
    syscall
.end_macro

.text
main:
  li $t0, 0 # $t0 = 0
  
  # you may initialize the SRC
  
  loop:
    beq $t0, 100, loop_end
    sll $t1, $t0, 2
    lw $t2, SRC($t1) # load value
    sw $zero, SRC($t1) # clear value
    sw $t2, DEST($t1) # store value
    addi $t0, $t0, 1
    j loop
    
  loop_end:
    end