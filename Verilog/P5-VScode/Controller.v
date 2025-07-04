`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:03:31 11/19/2023 
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
    output [1:0] RegDst,
    output [1:0] ALUSrc,
    output [1:0] WBreg,
    output RegWrite,
    output MemWrite,
    output [2:0] PCSrc,
    output [1:0] EXTOp,
    output [2:0] ALUOp
    );
    wire [5:0] Op;
    wire [5:0] Func; 
    wire add, sub, ori, lw, sw, beq, lui, jal, jr;

    assign Op = Instr[31:26];
    assign Func = Instr[5:0];

    assign add = (Op == `R_type) && (Func == `Add);
    assign sub = (Op == `R_type) && (Func == `Sub);
    assign ori = (Op == `Ori);
    assign lw = (Op == `Lw);
    assign sw = (Op == `Sw);
    assign beq = (Op == `Beq);
    assign lui = (Op == `Lui);
    assign jal = (Op == `Jal);
    assign jr = (Op == `R_type) && (Func == `Jr);

    assign RegDst = (ori || lw || lui) ? `grfWR_rt :
                    (add || sub) ? `grfWR_rd :
                    jal ? `grfWR_ra :
                    `grfWR_rt;
    assign ALUSrc = (ori || lw || sw || lui || jal) ? `aluB_Dout :
                    `aluB_RD;
    assign WBreg = (add || sub || ori || lui) ? `grfWD_ALUOut :
                      lw ? `grfWD_DMout :
                      jal ? `grfWD_pc8 :
                      `grfWD_ALUOut; 
    assign RegWrite = add || sub || ori || lw || lui || jal;
    assign MemWrite = sw;
    assign PCSrc = beq ? `b_type :
                   jal ? `j_jump :
                   jr ? `j_reg :
                   `pc_4;
    assign EXTOp = ori ? `extZero :
                   lui ? `extLui :
                   `extSign;
    assign ALUOp = ori ? `aluOr :
                   (add || lw || sw) ? `aluAdd :
                   sub ? `aluSub :
                   (lui || jal) ? `aluLui_save :
                   `aluAnd;


endmodule
