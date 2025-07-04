.text
  li $v0, 5
  syscall
  move $s0, $v0
  li $s2, 100
  div $s0, $s2
  mfhi $s1
  beq $s1, $zero, if_100
  li $s2, 4
  div $s0, $s2
  mfhi $s1
  beq $s1, $zero, if_4
  jal false
  
if_4:
  jal true
  
if_100:
  li $s2, 400
  div $s0, $s2
  mfhi $s1
  beq $s1, $zero, if_400
  jal false
  
if_400:
  jal true     
   
true:
  li $a0, 1
  li $v0, 1
  syscall
  jal end
  
false:  
  li $a0, 0
  li $v0, 1
  syscall
  jal end
  
end:
  li $v0, 10
  syscall
  