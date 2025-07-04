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
    output [1:0] rs_Tuse, // reg_Tuse
    output [1:0] rt_Tuse,
    output [1:0] E_Tnew, // reg_Tnew
    output [1:0] M_Tnew
    );
    wire [5:0] Op, Func; 
    wire AND, OR, ADD, SUB, SLT, SLTU;
    wire MULT, MULTU, DIV, DIVU, MTHI, MTLO;
    wire MFHI, MFLO;
    wire JR;
    wire ADDI, ANDI, ORI; 
    wire LUI;
    wire LB, LH, LW;
    wire SB, SH, SW;
    wire BEQ, BNE;
    wire JAL;

    //sort
    wire cal_rr, cal_mv, mv_to, mv_fr, cal_ri, load, store, branch;
    //JR, LUI, JAL

    assign Op = Instr[31:26];
    assign Func = Instr[5:0];

    assign AND = (Op == `R_type) && (Func == `And);
    assign OR = (Op == `R_type) && (Func == `Or);
    assign ADD = (Op == `R_type) && (Func == `Add);
    assign SUB = (Op == `R_type) && (Func == `Sub);
    assign SLT = (Op == `R_type) && (Func == `Slt);
    assign SLTU = (Op == `R_type) && (Func == `Sltu);
    assign cal_rr = AND || OR || ADD || SUB || SLT || SLTU;

    assign MULT = (Op == `R_type) && (Func == `Mult);
    assign MULTU = (Op == `R_type) && (Func == `Multu);
    assign DIV = (Op == `R_type) && (Func == `Div);
    assign DIVU = (Op == `R_type) && (Func == `Divu);
    assign MTHI = (Op == `R_type) && (Func == `Mthi);
    assign MTLO = (Op == `R_type) && (Func == `Mtlo);
    assign cal_mv = MULT || MULTU || DIV || DIVU;
    assign mv_to = MULT || MULTU || DIV || DIVU || MTHI || MTLO;

    assign MFHI = (Op == `R_type) && (Func == `Mfhi);
    assign MFLO = (Op == `R_type) && (Func == `Mflo);
    assign mv_fr = MFHI || MFLO;

    assign JR = (Op == `R_type) && (Func == `Jr); 

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

    //Control
    assign RegDst = (cal_ri || LUI || load) ? `grfWR_rt :
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
                   `grfWD_ALUOut; 

    assign RegWrite = cal_rr || mv_fr || cal_ri || LUI || load || JAL;
    
    assign PCSrc = BEQ ? `pc_Beq :
                   BNE ? `pc_Bne :
                   JAL ? `pc_Jal :
                   JR ? `pc_Jr :
                   `pc_4;

    assign EXTOp = (ADDI || load || store) ? `extSign :
                   (ANDI || ORI) ? `extZero :
                   LUI ? `extLui :
                   `extSign;

    assign DEOp = LW ? `de_Lw :
                  LH ? `de_Lh :
                  LB ? `de_Lb :
                  `de_Lw;

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
                   `mdu_Mult;

    //Tuse
    assign rs_Tuse = (JR || branch) ? 2'b00 :
                     (cal_rr || mv_to || cal_ri || load || store) ? 2'b01 :
                     2'b10;
    assign rt_Tuse = branch ? 2'b00 :
                     (cal_rr || cal_mv) ? 2'b01 :
                     2'b10;

    //Tnew
    assign E_Tnew = (Stage == `E_stage && load) ? 2'b10 :
                    (Stage == `E_stage && cal_rr || mv_fr || cal_ri) ? 2'b01 :
                    2'b00;
    assign M_Tnew = (Stage == `M_stage && load) ? 2'b01 :
                    2'b00;
    //W_Tnew == 2'b00


endmodule
