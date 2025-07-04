.data
  result: .word 0 : 1000
  
.macro getInt(%ans)
    li $v0, 5
    syscall
    move %ans, $v0
.end_macro

.text
main:
  getInt($s0) # $s0 = n