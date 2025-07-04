`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:40:17 12/07/2023 
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

    //Tuse
    input [1:0] rs_Tuse, 
    input [1:0] rt_Tuse,

    //Tnew
    input [1:0] E_Tnew, 
    input [1:0] M_Tnew,

    //MDU
    input isMDU_instr,
    input MDUing,

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
    output [1:0] Forward_EPC_M,
    output [1:0] Forward_rt_M
    );

    //ERET MTC0
    wire D_MTC0, E_ERET;

    //Instructions-Reg
    wire [4:0] D_rs, D_rt, E_rs, E_rt, E_rd, M_rt, M_rd;

    //Stall Signals
    wire stall_rs_E, stall_rt_E, stall_mdu, stall_rs_M, stall_rt_M, stall_epc;

    //ERET MTC0
    assign D_ERET = (D_Instr[31:26] == `COP0) && (D_Instr[5:0] == `Eret);
    assign E_MTC0 = (E_Instr[31:26] == `COP0) && (E_Instr[25:21] == `Mtc0);
    assign M_MTC0 = (M_Instr[31:26] == `COP0) && (M_Instr[25:21] == `Mtc0);
    
    //reg 
    assign D_rs = D_Instr[25:21];
    assign D_rt = D_Instr[20:16];
    assign E_rs = E_Instr[25:21];
    assign E_rt = E_Instr[20:16];
    assign E_rd = E_Instr[15:11];
    assign M_rt = M_Instr[20:16];
    assign M_rd = M_Instr[15:11];

    //Stall
    assign stall_rs_E = (rs_Tuse < E_Tnew) && (D_rs == E_WriteReg) && (D_rs != `reg_zero) && E_RegWrite;
    assign stall_rt_E = (rt_Tuse < E_Tnew) && (D_rt == E_WriteReg) && (D_rt != `reg_zero) && E_RegWrite;
    assign stall_mdu = isMDU_instr && MDUing;
    assign stall_rs_M = (rs_Tuse < M_Tnew) && (D_rs == M_WriteReg) && (D_rs != `reg_zero) && M_RegWrite;
    assign stall_rt_M = (rt_Tuse < M_Tnew) && (D_rt == M_WriteReg) && (D_rt != `reg_zero) && M_RegWrite;
    assign stall_epc = D_ERET && E_MTC0 && (E_rd == `reg_EPC); 
    
    assign Stall = stall_rs_E || stall_rt_E || stall_mdu || stall_rs_M || stall_rt_M || stall_epc;

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
    assign Forward_EPC_M = (M_MTC0 && D_ERET && (M_rd == `reg_EPC)) ? 2'b01 :
                           2'b00;
    assign Forward_rt_M = (M_rt == W_WriteReg && M_rt != `reg_zero && W_RegWrite) ? 2'b01 :
                          2'b00;


endmodule
