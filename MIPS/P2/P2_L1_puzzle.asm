.data
  matrix: .word 0 : 49
  
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

.macro getindex(%ans, %i, %j, %m)
    mult %i, %m
    mflo %ans
    addu %ans, %ans, %j
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

.macro end
    li $v0, 10
    syscall
.end_macro

.text
main:
  getInt($s0) # $s0 = n
  getInt($s1) # $s1 = m
  li $t0, 0 # $t0 = i
  for_n:
    beq $t0, $s0, for_n_end
    li $t1, 0 # $t1 = j
    for_m:
      beq $t1, $s1, for_m_end
      getInt($s2)
      getindex($t2, $t0, $t1, $s1)
      sw $s2, matrix($t2)
      addi $t1, $t1, 1
      j for_m
    
    for_m_end:
      addi $t0, $t0, 1
      j for_n
    
  for_n_end:
    getInt($s2) # $s2 = x1
    getInt($s3) # $s3 = y1
    getInt($s4) # $s4 = x2
    getInt($s5) # $s5 = y2
    li $s6, 0 # $s6 = count
    move $a0, $s2 # $a0 = x1
    move $a1, $s3 # $a1 = y1
    jal dfs
    printInt($s6)
    end
    
dfs:
   push($ra)
   push($a2)
   push($t0)
   push($t1)
   push($t7)
   #push
   
   move $t0, $a0 # $t0 = x1
   move $t1, $a1 # $t1 = y1
   
   bge $t0, 1, if_x1g
     j return
     
     if_x1g:
       bge $t1, 1, if_y1g
       j return
       
       if_y1g:
         ble $t0, $s0, if_x1l
         j return
         
         if_x1l:
           ble $t1, $s1, continue
           j return

continue:      
   subi $t0, $t0, 1
   subi $t1, $t1, 1
   getindex($t2, $t0, $t1, $s1)
   move $a2, $t2
   addi $t0, $t0, 1
   addi $t1, $t1, 1
   beq $t0, $s4, if_x1
   j elsee
   
   if_x1:
     beq $t1, $s5, if_a
     j elsee
    
       if_a:
         addi $s6, $s6, 1
         j return
         
   elsee:
     li $t7, 0 # $t7 = i
   for_i4:
     beq $t7, 4, return
     lw $t2, matrix($a2)
     beq $t2, $0, if_true
     j if_true_end
     
         if_true:
           li $t3, 2 # already pass
           sw $t3, matrix($a2)
           
           move $t4, $t0 # $t4 -> x1
           move $t5, $t1 # $t5 -> y1 
           beq $t7, 0, if_ii0
           beq $t7, 1, if_ii1
           beq $t7, 2, if_ii2
           beq $t7, 3, if_ii3
           
           if_ii0:
             addi $t4, $t4, 1
             j if_ii_end
           
           if_ii1:
             subi $t4, $t4, 1
             j if_ii_end
             
           if_ii2:
             addi $t5, $t5, 1
             j if_ii_end
             
           if_ii3:
             subi $t5, $t5, 1
             j if_ii_end
             
           if_ii_end:   
             move $a0, $t4 # $a0 = x1'
             move $a1, $t5 # $a1 = y1'
             jal dfs
           
           li $t3, 0 # clear pass
           sw $t3, matrix($a2)
           
       if_true_end:
         addi $t7, $t7, 1
         j for_i4
   
   return:
     pop($t7)
     pop($t1)
     pop($t0)
     pop($a2)
     pop($ra)
     jr $ra
     #pop
