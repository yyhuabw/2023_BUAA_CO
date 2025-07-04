.data
array: .space 40           # 存储这些数需要用到数组，数组需要使用 10 * 4 = 40 字节
                           # 一个 int 整数需要占用 4 个字节，需要存储 10 个 int 整数
                           # 因此，array[0] 的地址为 0x00，array[1] 的地址为 0x04
                           # array[2] 的地址为 0x08，以此类推。

str:   .asciiz "The numbers are: "
space: .asciiz " "

.text
li $v0,5
syscall                    # 输入一个整数
move $s0, $v0              # $s0 is n
li $t0, 0                  # $t0 循环变量

loop_in:
beq $t0, $s0, loop_in_end  # $t0 == $s0 的时候跳出循环
li $v0, 5
syscall                    # 输入一个整数
sll $t1, $t0, 2            # $t1 = $t0 << 2，即 $t1 = $t0 * 4
sw $v0, array($t1)         # 把输入的数存入地址为 array + $t1 的内存中
addi $t0, $t0, 1           # $t0 = $t0 + 1
j loop_in                  # 跳转到 loop_in

loop_in_end:
la $a0, str
li $v0, 4
syscall                    # 输出提示信息
li $t0, 0
loop_out:
beq $t0, $s0, loop_out_end
sll $t1, $t0, 2            # $t1 = $t0 << 2，即 $t1 = $t0 * 4
lw $a0, array($t1)         # 把内存中地址为 array + $t1 的数取出到 $a0 中
li $v0, 1
syscall                    # 输出 $a0
la $a0, space
li $v0, 4
syscall                    # 输出一个空格
addi $t0, $t0, 1
j loop_out

loop_out_end:
li $v0, 10
syscall                    # 结束程序
