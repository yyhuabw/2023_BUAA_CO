L99999: nop
ori $t0, $0, 0x1001
mtc0 $t0, $12
ori $0 ,$0 ,20513
lui $1 ,25333
lui $2 ,7857
lui $3 ,18773
ori $4 ,$0 ,13006
ori $5 ,$0 ,29711
ori $6 ,$0 ,9177
lui $7 ,5813
ori $8 ,$0 ,11260
ori $9 ,$0 ,30686
ori $10 ,$0 ,23230
ori $11 ,$0 ,22628
lui $12 ,21972
lui $13 ,23247
lui $14 ,7226
lui $15 ,32528
lui $16 ,32643
ori $17 ,$0 ,1651
ori $18 ,$0 ,18286
lui $19 ,21455
lui $20 ,13241
ori $21 ,$0 ,7167
ori $22 ,$0 ,20538
lui $23 ,31382
ori $24 ,$0 ,20267
ori $25 ,$0 ,16079
ori $26 ,$0 ,24006
lui $27 ,1219
lui $28 ,10002
ori $29 ,$0 ,28383
lui $30 ,30972
ori $31 ,$0 ,5012
sub $14 ,$2 ,$16
lw $18 ,1884($0)
sub $17 ,$30 ,$21
sub $31 ,$7 ,$8
ori $20 ,$0 ,26761
bne $21, $21, L99999
sub $6 ,$24 ,$12
lw $19 ,2164($18)
addi $0 ,$30 ,6997
sh $27 ,2400($0)
lh $22 ,2400($0)
beq $27, $22, L0
add $3 ,$3 ,$19
L99997: sw $16 ,1008($19)
lui $2 ,22764
lui $20 ,15614
lb $12 ,1011($0)
beq $26, $0, L99999
ori $12 ,$17 ,5777
ori $21 ,$30 ,2926
divu $0 ,$10
beq $17, $0, L99999
sub $23 ,$31 ,$5
add $7 ,$22 ,$2
ori $0 ,$15 ,17675
ori $3 ,$22 ,4065
lui $15 ,8188
mthi $0
sw $26 ,68($13)
sw $11 ,1904($0)
mflo $6
sub $13 ,$19 ,$3
lw $26 ,1916($0)
lui $6 ,29063
mult $18 ,$0
bne $7, $7, L99999
ori $26 ,$3 ,24142
sw $24 ,1204($0)
add $14 ,$5 ,$29
ori $19 ,$3 ,18057
lui $26 ,24655
andi $0 ,$12 ,28517
ori $2 ,$21 ,148
sltu $28 ,$0 ,$13
sw $24 ,1788($0)
sub $10 ,$5 ,$9
ori $3 ,$14 ,11219
lh $0 ,1520($0)
sub $27 ,$28 ,$27
sub $15 ,$16 ,$23
sw $1 ,272($0)
ori $19 ,$29 ,12098
multu $0 ,$27
beq $1, $1, L1
lw $29 ,2180($0)
L99996: ori $5 ,$23 ,14893
lui $0 ,16357
lw $5 ,588($0)
lui $22 ,11177
lw $23 ,1908($0)
lw $18 ,1524($0)
sub $17 ,$5 ,$0
beq $5, $17, L2
ori $27 ,$13 ,30409
L99995: lui $19 ,27948
lui $3 ,20563
add $4 ,$0 ,$17
beq $26, $26, L3
add $16 ,$0 ,$7
L99994: sub $5 ,$16 ,$2
sub $14 ,$7 ,$28
ori $30 ,$3 ,3117
ori $7 ,$18 ,16239
sub $24 ,$25 ,$12
lb $0 ,273($0)
sub $22 ,$11 ,$14
and $24 ,$0 ,$28
add $0 ,$30 ,$24
divu $0 ,$16
sh $27 ,2548($0)
lh $24 ,2548($0)
beq $27, $24, L4
sw $10 ,1080($0)
L99993: lui $6 ,20019
sub $4 ,$24 ,$24
add $8 ,$16 ,$5
addi $0 ,$25 ,17035
sub $17 ,$12 ,$15
sw $17 ,332($18)
lw $27 ,1760($0)
slt $26 ,$0 ,$2
lw $18 ,1992($0)
ori $10 ,$23 ,25767
and $3 ,$9 ,$0
sub $0 ,$1 ,$3
ori $30 ,$30 ,15946
sub $15 ,$5 ,$11
lw $15 ,276($0)
sh $0 ,1720($18)
sh $29 ,1544($0)
lh $16 ,1544($0)
beq $29, $16, L5
lui $19 ,9694
L99992: sub $5 ,$0 ,$30
ori $14 ,$29 ,28519
sb $29 ,2640($0)
sw $28 ,1952($0)
lw $12 ,2640($0)
ori $13 ,$14 ,29737
mult $0 ,$14
jal L6
lui $18 ,14142
lw $8 ,1868($0)
sub $18 ,$26 ,$8
sw $28 ,1408($0)
ori $6 ,$17 ,8150
add $17 ,$30 ,$5
lw $25 ,1736($0)
lw $19 ,576($0)
sw $8 ,1159($18)
lb $12 ,2887($0)
add $25 ,$23 ,$11
lui $28 ,7775
lui $24 ,11521
sw $1 ,1840($19)
ori $0 ,$17 ,23212
sub $7 ,$8 ,$6
lw $3 ,2024($0)
sw $20 ,532($0)
ori $9 ,$31 ,4766
div $0 ,$7
beq $5, $5, L7
lui $29 ,9901
L99991: sub $13 ,$24 ,$14
add $15 ,$14 ,$21
slt $15 ,$0 ,$13
beq $16, $16, L8
add $30 ,$0 ,$25
L99990: ori $23 ,$2 ,13285
lw $26 ,1124($0)
add $18 ,$4 ,$9
add $13 ,$8 ,$22
mthi $0
beq $24, $24, L9
sw $20 ,2076($0)
L99989: lui $9 ,14955
lui $18 ,6828
lw $28 ,2036($0)
sh $26 ,640($0)
beq $11, $11, L10
sw $23 ,1280($0)
L99988: ori $11 ,$29 ,29135
add $17 ,$6 ,$1
sub $27 ,$5 ,$22
mthi $0
beq $8, $8, L11
lui $5 ,18459
L99987: lw $30 ,2208($0)
lui $20 ,26898
sw $31 ,2324($0)
lui $13 ,25300
sw $12 ,2924($12)
mtlo $26
beq $0, $0, L12
add $8 ,$28 ,$18
L99986: sw $30 ,2040($0)
sw $3 ,356($0)
sw $16 ,2004($0)
sub $1 ,$2 ,$14
sub $26 ,$3 ,$18
lw $26 ,2040($0)
jal L13
sw $29 ,516($0)
sub $31 ,$14 ,$15
sub $19 ,$25 ,$22
sub $13 ,$29 ,$8
add $29 ,$16 ,$21
sb $0 ,2104($0)
bne $22, $22, L99999
lui $26 ,18843
sw $7 ,412($14)
add $28 ,$27 ,$9
sw $3 ,1748($0)
sub $28 ,$29 ,$4
mult $13 ,$0
lui $31 ,15465
mflo $20
sw $26 ,1512($0)
sw $6 ,44($0)
lui $28 ,11517
sw $29 ,208($0)
mult $6 ,$0
add $28 ,$26 ,$19
sw $30 ,2700($0)
mfhi $31
ori $31 ,$26 ,22967
ori $1 ,$2 ,3245
add $12 ,$21 ,$5
lw $20 ,3044($20)
sw $13 ,448($0)
sw $0 ,496($0)
lui $7 ,16233
add $29 ,$22 ,$11
lw $19 ,448($0)
beq $24, $24, L14
lui $22 ,15995
L99985: sub $8 ,$21 ,$22
lw $23 ,200($0)
add $24 ,$12 ,$24
sub $4 ,$22 ,$0
lui $9 ,28818
ori $19 ,$30 ,17248
sub $26 ,$0 ,$15
slt $19 ,$14 ,$0
lw $18 ,272($0)
lui $14 ,29871
lw $4 ,112($6)
sltu $24 ,$0 ,$2
lui $15 ,29282
add $22 ,$9 ,$19
lui $20 ,5683
addi $13 ,$0 ,31317
lui $30 ,8548
sw $20 ,2476($0)
ori $23 ,$15 ,22133
ori $0 ,$6 ,18414
beq $12, $12, L15
add $19 ,$7 ,$19
L99984: ori $27 ,$2 ,245
lui $3 ,21222
add $12 ,$2 ,$1
add $20 ,$0 ,$25
lh $19 ,1238($0)
sub $23 ,$13 ,$31
ori $0 ,$11 ,25980
beq $29, $29, L16
lw $9 ,304($0)
L99983: sw $30 ,1688($0)
lui $4 ,4320
add $15 ,$27 ,$8
lw $29 ,1688($0)
sub $26 ,$23 ,$21
lui $11 ,5859
add $1 ,$11 ,$30
sub $14 ,$9 ,$23
lh $21 ,172($0)
beq $8, $0, L99999
lw $18 ,1808($0)
jal End
L0: lui $17 ,9100
jal L99997
lw $13 ,1776($19)
L1: sw $25 ,544($0)
jal L99996
add $3 ,$2 ,$19
L2: lui $14 ,17222
jal L99995
sw $29 ,1696($0)
L3: sub $26 ,$6 ,$21
jal L99994
lui $2 ,14888
L4: sub $14 ,$2 ,$24
jal L99993
sw $29 ,1272($0)
L5: sub $13 ,$20 ,$26
jal L99992
ori $29 ,$5 ,11382
L6: ori $9 ,$9 ,28704
jr $31
lui $24 ,24979
L7: lui $26 ,24120
jal L99991
ori $14 ,$13 ,477
L8: sw $30 ,892($0)
jal L99990
sub $9 ,$28 ,$7
L9: lw $14 ,1144($0)
jal L99989
ori $9 ,$8 ,75
L10: sub $21 ,$15 ,$6
jal L99988
sub $29 ,$28 ,$19
L11: lui $25 ,5434
jal L99987
sub $4 ,$30 ,$29
L12: sub $21 ,$29 ,$27
jal L99986
add $16 ,$15 ,$25
L13: lui $0 ,24820
jr $31
lw $22 ,828($0)
L14: lw $6 ,335($15)
jal L99985
sub $14 ,$5 ,$8
L15: lui $16 ,3328
jal L99984
lw $11 ,1367($24)
L16: sw $25 ,864($4)
jal L99983
lw $18 ,324($11)
End: nop
beq $1, $1, -1
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
#save RF
ori $sp, $0, 0x3000
mfc0 $t0, $13
mfc0 $t1, $14
mfc0 $t2, $15
andi $t1, $t0, 0x7c	#exccode
ori $t5, $0, 4
div $t1, $t5
andi $t2, $t0, 0x1000	#int
andi $t3, $t0, 0x0800	#t1
andi $t4, $t0, 0x0400	#t0
bne $t2, $zero, HAN_INT
ori $t5, $0, 1
bne $t3, $zero, HAN_T1
ori $t5, $0, 2
bne $t4, $zero, HAN_T0
ori $t5, $0, 3
mfhi $t5
mfc0 $t6, $14
addi $t6, $t6, 4	#pc+4
beq $0, $0, EXCEND
mtc0 $t6, $14
HAN_INT:
sb $0, 0x7f20($0)
beq $0, $0, EXCEND
ori $t2, $0, 0xffff
HAN_T0:
ori $t2, $0, 0x9
sw $t2, 0x7f00($zero)
beq $0, $0, EXCEND
lw $t2, 0x7f00($zero)
HAN_T1:
ori $t2, $0, 0x9
sw $t2, 0x7f10($zero)
beq $0, $0, EXCEND
lw $t2, 0x7f10($zero)
EXCEND:
nop
eret 
