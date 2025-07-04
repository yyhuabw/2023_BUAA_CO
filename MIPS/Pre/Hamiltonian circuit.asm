.data
  matrix: .space 256 # G[][]
  array: .space 32 # book[]
  
.macro end
    li $v0, 10
    syscall
.end_macro

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

.macro getindex(%ans, %i, %j)
    sll %ans, %i, 3
    add %ans, %ans, %j
    sll %ans, %ans, 2
.end_macro

.macro push(%src)
    sw %src, 0($sp)
    subi $sp, $sp, 4
.end_macro

.macro pop(%des)
    addi $sp, $sp, 4
    lw %des, 0($sp)
.end_macro

.text
main:
  getInt($s0) # $s0 = n
  getInt($s1) # $s1 = m
  li $t0, 0 # $t0 = i
  
for_m: # for (i = 0; i < m; i++)
  slt $t1, $t0, $s1
  beq $t1, $zero, for_m_end
  getInt($t2) 
  addi $t2, $t2, -1 # $t2 = x - 1
  getInt($t3) 
  addi $t3, $t3, -1 # $t3 = y - 1 
  getindex($t4, $t2, $t3) # $t4 = G[$t2][$t3]
  getindex($t5, $t3, $t2) # $t4 = G[$t3][$t2]
  li $t6, 1
  sw $t6, matrix($t4)
  sw $t6, matrix($t5)
  addi $t0, $t0, 1
  jal for_m
  
for_m_end:
  move $a0, $zero
  li $v1, 0 # ans = 0 (initial)
  jal dfs # dfs(0)
  printInt($v1)
  end  
  
dfs:
  push($ra)
  push($a0)
  push($t0)
  push($t1)
  push($t2)
  push($t3)
  push($t4)
  push($t5)
  #push
  
  move $t0, $a0 # $t0 = x
  li $t1, 1
  sll $t2, $t0, 2
  sw $t1, array($t2) # book[x] = 1
  li $t3, 1 # $t3 = flag
  li $t1, 0 # $t1 = i
  
for_n2:
  slt $t4, $t1, $s0
  beq $t4, $zero, for_n2_end
  sll $t2, $t1, 2
  lw $t4, array($t2)
  and $t3, $t3, $t4 # flag &= book[i];
  addi $t1, $t1, 1
  j for_n2
  
for_n2_end:
  getindex($t2, $t0, $zero)
  lw $t2, matrix($t2) # $t2 = G[x][0]
  and $t2, $t3, $t2 # flag $ G[x][0]
  bgtz $t2, if_flag
  li $t1, 0 # $t1 = i
  
for_n3:
  slt $t4, $t1, $s0
  beq $t4, $zero, for_n3_end
  sll $t2, $t1, 2
  lw $t2, array($t2) # book[x]
  li $t5, 1
  slt $t5, $t2, $t5 # $t5 = !book[x]
  getindex($t4, $t0, $t1)
  lw $t4, matrix($t4) # $t4 = G[x][i]
  and $t2, $t5, $t4 # $t2 = flagg -> !book[x] & G[x][i]
  bgtz $t2, if_flagg
  j if_flagg_end
  
if_flagg:
  move $a0, $t1
  jal dfs # dfs(i)
  
if_flagg_end:
  addi $t1, $t1, 1
  j for_n3
  
for_n3_end:
  sll $t2, $t0, 2
  sw $zero, array($t2) # b00k[x] = 0

func_end:
  pop($t5)
  pop($t4)
  pop($t3)
  pop($t2)
  pop($t1)
  pop($t0)
  pop($a0)
  pop($ra)
  #pop
  jr $ra # return 

if_flag:
  li $v1, 1 # ans = 1
  j func_end 
  
  
  
