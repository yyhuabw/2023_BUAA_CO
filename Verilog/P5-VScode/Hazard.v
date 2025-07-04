`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:15:05 11/19/2023 
// Design Name: 
// Module Name:    Hazard 
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

module Hazard(
    //Instr
    input [31:0] D_Instr,
    input [31:0] E_Instr,
    input [31:0] M_Instr,
    input [31:0] W_Instr,

    //WriteReg
    input [4:0] E_WriteReg,
    input [4:0] M_WriteReg,
    input [4:0] W_WriteReg,

    //Control Signals
    input E_RegWrite,
    input M_RegWrite,
    input W_RegWrite,

    //Stall Signals
    output Stall,

    //Forwasrd Signals
    output [1:0] Forward_rs_D,
    output [1:0] Forward_rt_D,
    output [1:0] Forward_rs_E,
    output [1:0] Forward_rt_E,
    output [1:0] Forward_rt_M
    );

    //Instructions
    wire [5:0] D_Op;//Op
    wire [5:0] E_Op;
    wire [5:0] M_Op;
    wire [5:0] W_Op;
    wire [5:0] D_Func;//Func
    wire [5:0] E_Func;
    wire [4:0] D_rs;//Reg
    wire [4:0] D_rt;
    wire [4:0] E_rs;
    wire [4:0] E_rt;
    wire [4:0] M_rt;

    //reg_Tuse
    wire [1:0] rs_Tuse;
    wire [1:0] rt_Tuse;

    //reg_Tnew
    wire [1:0] E_Tnew;
    wire [1:0] M_Tnew;

    //Stall Signals
    wire stall_rs_E;
    wire stall_rt_E;
    wire stall_rs_M;
    wire stall_rt_M;

    //Instr
    assign D_Op = D_Instr[31:26];
    assign E_Op = E_Instr[31:26];
    assign M_Op = M_Instr[31:26];
    assign W_Op = W_Instr[31:26];
    //Func
    assign D_Func = D_Instr[5:0];
    assign E_Func = E_Instr[5:0];
    //reg 
    assign D_rs = D_Instr[25:21];
    assign D_rt = D_Instr[20:16];
    assign E_rs = E_Instr[25:21];
    assign E_rt = E_Instr[20:16];
    assign M_rt = M_Instr[20:16];

    //Tuse
    assign rs_Tuse = ((D_Op == `R_type && D_Func != `Jr) || D_Op == `Ori || D_Op == `Lw || D_Op == `Sw) ? 2'b01 :
                     (D_Op == `Beq || (D_Op == `R_type && D_Func == `Jr)) ? 2'b00 :
                     2'b10;
    assign rt_Tuse = (D_Op == `R_type && D_Func != `Jr) ? 2'b01 :
                     (D_Op == `Beq) ? 2'b00 :
                     2'b10;

    //Tnew
    assign E_Tnew = (E_Op == `Lw) ? 2'b10 :
                    ((E_Op == `R_type && E_Func != `Jr) || E_Op == `Ori) ? 2'b01 :
                    2'b00;
    assign M_Tnew = (M_Op == `Lw) ? 2'b01 :
                    2'b00;
    //W_Tnew == 2'b00

    //Stall
    assign stall_rs_E = (rs_Tuse < E_Tnew) && (D_rs == E_WriteReg) && (D_rs != `reg_zero) && E_RegWrite;
    assign stall_rt_E = (rt_Tuse < E_Tnew) && (D_rt == E_WriteReg) && (D_rt != `reg_zero) && E_RegWrite;
    assign stall_rs_M = (rs_Tuse < M_Tnew) && (D_rs == M_WriteReg) && (D_rs != `reg_zero) && M_RegWrite;
    assign stall_rt_M = (rt_Tuse < M_Tnew) && (D_rt == M_WriteReg) && (D_rt != `reg_zero) && M_RegWrite;
    
    assign Stall = stall_rs_E || stall_rt_E || stall_rs_M || stall_rt_M;

    //Forward
    assign Forward_rs_D = (D_rs == E_WriteReg && D_rs != `reg_zero && E_Tnew == 2'b00 && E_RegWrite) ? 2'b01 :
                          (D_rs == M_WriteReg && D_rs != `reg_zero && M_Tnew == 2'b00 && M_RegWrite) ? 2'b10 :
                          (D_rs == W_WriteReg && D_rs != `reg_zero && W_RegWrite) ? 2'b11 :
                          2'b00;
    assign Forward_rt_D = (D_rt == E_WriteReg && D_rt != `reg_zero && E_Tnew == 2'b00 && E_RegWrite) ? 2'b01 :
                          (D_rt == M_WriteReg && D_rt != `reg_zero && M_Tnew == 2'b00 && M_RegWrite) ? 2'b10 :
                          (D_rt == W_WriteReg && D_rt != `reg_zero && W_RegWrite) ? 2'b11 :
                          2'b00;
    assign Forward_rs_E = (E_rs == M_WriteReg && E_rs != `reg_zero && M_Tnew == 2'b00 && M_RegWrite) ? 2'b01 :
                          (E_rs == W_WriteReg && E_rs != `reg_zero && W_RegWrite) ? 2'b10 :
                          2'b00;
    assign Forward_rt_E = (E_rt == M_WriteReg && E_rt != `reg_zero && M_Tnew == 2'b00 && M_RegWrite) ? 2'b01 :
                          (E_rt == W_WriteReg && E_rt != `reg_zero && W_RegWrite) ? 2'b10 :
                          2'b00;
    assign Forward_rt_M = (M_rt == W_WriteReg && M_rt != `reg_zero && W_RegWrite) ? 2'b01 :
                          2'b00;


endmodule