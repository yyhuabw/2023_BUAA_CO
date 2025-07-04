`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:22:13 12/07/2023 
// Design Name: 
// Module Name:    Controller 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`include "macros.v"

module Controller(
    input [31:0] Instr,
    input [2:0] Stage,
    output [1:0] RegDst,
    output [1:0] ALUSrc,
    output [2:0] WBreg,
    output RegWrite,
    output [2:0] PCSrc,
    output [1:0] EXTOp,
    output [2:0] DEOp,
    output [2:0] ALUOp,
    output Start,
    output isMDU_instr,
    output [2:0] MDUOp,
    output D_Exc_RI,//Exc
    output isAri,
    output isLd,
    output isSt,
    output CP0_en,
    output isEret,
    output isSyscall,
    output isBD,
    output [1:0] rs_Tuse, // reg_Tuse
    output [1:0] rt_Tuse,
    output [1:0] E_Tnew, // reg_Tnew
    output [1:0] M_Tnew
    );
    wire [5:0] Op, Func; 
    wire [4:0] Rs;
    wire AND, OR, ADD, SUB, SLT, SLTU;
    wire MULT, MULTU, DIV, DIVU, MTHI, MTLO;
    wire MFHI, MFLO;
    wire JR;
    wire SYSCALL;
    wire ADDI, ANDI, ORI; 
    wire LUI;
    wire LB, LH, LW;
    wire SB, SH, SW;
    wire BEQ, BNE;
    wire JAL;
    wire MFC0, MTC0, ERET;
    wire NOP;

    //sort
    wire cal_rr, cal_mv, mv_to, mv_fr, cal_ri, load, store, branch;
    //JR, LUI, JAL, SYSCALL, MFC0, MTC0

    assign Op = Instr[31:26];
    assign Rs = Instr[25:21];
    assign Func = Instr[5:0];

    assign AND = (Op == `SPECIAL) && (Func == `And);
    assign OR = (Op == `SPECIAL) && (Func == `Or);
    assign ADD = (Op == `SPECIAL) && (Func == `Add);
    assign SUB = (Op == `SPECIAL) && (Func == `Sub);
    assign SLT = (Op == `SPECIAL) && (Func == `Slt);
    assign SLTU = (Op == `SPECIAL) && (Func == `Sltu);
    assign cal_rr = AND || OR || ADD || SUB || SLT || SLTU;

    assign MULT = (Op == `SPECIAL) && (Func == `Mult);
    assign MULTU = (Op == `SPECIAL) && (Func == `Multu);
    assign DIV = (Op == `SPECIAL) && (Func == `Div);
    assign DIVU = (Op == `SPECIAL) && (Func == `Divu);
    assign MTHI = (Op == `SPECIAL) && (Func == `Mthi);
    assign MTLO = (Op == `SPECIAL) && (Func == `Mtlo);
    assign cal_mv = MULT || MULTU || DIV || DIVU;
    assign mv_to = MULT || MULTU || DIV || DIVU || MTHI || MTLO;

    assign MFHI = (Op == `SPECIAL) && (Func == `Mfhi);
    assign MFLO = (Op == `SPECIAL) && (Func == `Mflo);
    assign mv_fr = MFHI || MFLO;

    assign JR = (Op == `SPECIAL) && (Func == `Jr); 

    assign SYSCALL = (Op == `SPECIAL) && (Func == `Syscall);

    assign ADDI = (Op == `Addi);
    assign ANDI = (Op == `Andi);
    assign ORI = (Op == `Ori);
    assign cal_ri = ADDI || ANDI || ORI || LUI;

    assign LUI = (Op == `Lui);

    assign LB = (Op == `Lb);
    assign LH = (Op == `Lh);
    assign LW = (Op == `Lw);
    assign load = LB || LH || LW;

    assign SB = (Op == `Sb);
    assign SH = (Op == `Sh);
    assign SW = (Op == `Sw);
    assign store = SB || SH || SW;

    assign BEQ = (Op == `Beq);
    assign BNE = (Op == `Bne);
    assign branch = BEQ || BNE;

    assign JAL = (Op == `Jal);

    assign MFC0 = (Op == `COP0) && (Rs == `Mfc0);

    assign MTC0 = (Op == `COP0) && (Rs == `Mtc0);

    assign ERET = (Op == `COP0) && (Func == `Eret);

    assign NOP = (Instr == `nop);

    //Control
    assign RegDst = (cal_ri || LUI || load || MFC0) ? `grfWR_rt :
                    (cal_rr || mv_fr) ? `grfWR_rd :
                    JAL ? `grfWR_ra :
                    `grfWR_rt;

    assign ALUSrc = (cal_ri || LUI || load || store || JAL) ? `aluB_Dout :
                    `aluB_RD;

    assign WBreg = (cal_rr || cal_ri || LUI) ? `grfWD_ALUOut :
                   load ? `grfWD_DMout :
                   JAL ? `grfWD_pc8 :
                   MFHI ? `grfWD_HI :
                   MFLO ? `grfWD_LO :
                   MFC0 ? `grfWD_CP0 :
                   `grfWD_ALUOut; 

    assign RegWrite = cal_rr || mv_fr || cal_ri || LUI || load || JAL || MFC0;
    
    assign PCSrc = BEQ ? `pc_Beq :
                   BNE ? `pc_Bne :
                   JAL ? `pc_Jal :
                   JR ? `pc_Jr :
                   ERET ? `pc_Epc :
                   `pc_4;

    assign EXTOp = (ADDI || load || store) ? `extSign :
                   (ANDI || ORI) ? `extZero :
                   LUI ? `extLui :
                   `extSign;

    assign DEOp = LW ? `de_Lw :
                  LH ? `de_Lh :
                  LB ? `de_Lb :
                  `de_Others;

    assign ALUOp = (AND || ANDI) ? `alu_And :
                   (OR || ORI) ? `alu_Or :
                   (ADD || ADDI || load || store) ? `alu_Add :
                   SUB ? `alu_Sub :
                   (LUI || JAL) ? `alu_save :
                   SLT ? `alu_Slt :
                   SLTU ? `alu_Sltu :
                   `alu_And;

    assign Start = MULT || MULTU || DIV || DIVU;

    assign isMDU_instr = mv_to || mv_fr;

    assign MDUOp = MULT ? `mdu_Mult :
                   MULTU ? `mdu_Multu :
                   DIV ? `mdu_Div :
                   DIVU ? `mdu_Divu :
                   MTHI ? `mdu_Mthi :
                   MTLO ? `mdu_Mtlo :
                   `mdu_Others;

    //Exc
    assign D_Exc_RI = !(cal_rr | mv_to | mv_fr | JR | SYSCALL | cal_ri | LUI | load | store | branch | JAL | MFC0 | MTC0 | ERET | NOP); 
    assign isAri = ADD || ADDI || SUB;
    assign isLd = load;
    assign isSt = store;
    assign CP0_en = MTC0;
    assign isEret = ERET;
    assign isSyscall = SYSCALL;
    assign isBD = branch || JAL || JR;

    //Tuse
    assign rs_Tuse = (JR || branch) ? 2'b00 :
                     (cal_rr || mv_to || cal_ri || load || store) ? 2'b01 :
                     2'b10;
    assign rt_Tuse = branch ? 2'b00 :
                     (cal_rr || cal_mv) ? 2'b01 :
                     2'b10;

    //Tnew
    assign E_Tnew = (Stage == `E_stage && (load || MFC0)) ? 2'b10 :
                    (Stage == `E_stage && (cal_rr || mv_fr || cal_ri)) ? 2'b01 :
                    2'b00;
    assign M_Tnew = (Stage == `M_stage && (load || MFC0)) ? 2'b01 :
                    2'b00;
    //W_Tnew == 2'b00


endmodule
