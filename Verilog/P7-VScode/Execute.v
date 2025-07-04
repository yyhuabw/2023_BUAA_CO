`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:38:44 12/07/2023 
// Design Name: 
// Module Name:    Execute 
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

module Execute(
    input clk,
    input reset,
    input [31:0] IDEX_PC,
    input [31:0] IDEX_Instr,

    //Forward
    input [1:0] Forward_rs_E,//Signals
    input [1:0] Forward_rt_E,
    input [31:0] EXMEM_Eout,//Data
    input [31:0] MEMWB_Mout,

    input [4:0] IDEX_WriteReg,
    input [31:0] IDEX_Dout,
    input [31:0] IDEX_RD1,
    input [31:0] IDEX_RD2,
    input IDEX_BD,
    input Req,
    input [4:0] IDEX_ExcCode,
    output e_RegWrite,
    output e_MDUing,
    output [31:0] e_PC,
    output [31:0] e_Instr,
    output [1:0] E_Tnew,
    output [4:0] e_WriteReg,
    output [31:0] e_Eout,
    output [31:0] e_RD2,
    output e_BD,
    output [4:0] e_ExcCode
    );
    wire [2:0] e_Stage = `E_stage;
    wire [1:0] e_ALUSrc;
    wire e_Start, e_Busy, e_isAri, e_isLd, e_isSt, e_Exc_AriOv, e_Exc_LdOv, e_Exc_StOv;
    wire [2:0] e_WBreg, e_ALUOp, e_MDUOp;
    wire [31:0] e_B, e_ALUout, e_HI, e_LO;

    //Forward
    wire [31:0] E_MF_rs, E_MF_rt;

    Controller e_control(
        .Instr(IDEX_Instr),
        .Stage(e_Stage),
        .ALUSrc(e_ALUSrc),
        .WBreg(e_WBreg),
        .RegWrite(e_RegWrite),
        .ALUOp(e_ALUOp),
        .Start(e_Start),
        .MDUOp(e_MDUOp),
        .isAri(e_isAri),
        .isLd(e_isLd),
        .isSt(e_isSt),
        .E_Tnew(E_Tnew)
    );
    E_ALU e_alu(
        .ALUOp(e_ALUOp),
        .isAri(e_isAri),
        .isLd(e_isLd),
        .isSt(e_isSt),
        .A(E_MF_rs),
        .B(e_B),
        .Exc_AriOv(e_Exc_AriOv),
        .Exc_LdOv(e_Exc_LdOv),
        .Exc_StOv(e_Exc_StOv),
        .Result(e_ALUout)
    );
    E_MDU e_mdu(
        .clk(clk),
        .reset(reset),
        .Req(Req),
        .Start(e_Start),
        .MDUOp(e_MDUOp),
        .A(E_MF_rs),
        .B(e_B),
        .Busy(e_Busy), // to hazard
        .HI(e_HI),
        .LO(e_LO)
    );

    //Forward
    assign E_MF_rs = (Forward_rs_E == 2'b01) ? EXMEM_Eout :
                     (Forward_rs_E == 2'b10) ? MEMWB_Mout :
                     IDEX_RD1;
    assign E_MF_rt = (Forward_rt_E == 2'b01) ? EXMEM_Eout :
                     (Forward_rt_E == 2'b10) ? MEMWB_Mout :
                     IDEX_RD2;

    assign e_B = (e_ALUSrc == `aluB_Dout) ? IDEX_Dout :
                 E_MF_rt;

    assign e_PC = IDEX_PC;
    assign e_Instr = IDEX_Instr;
    assign e_WriteReg = IDEX_WriteReg;
    assign e_MDUing = e_Start || e_Busy;
    assign e_Eout = (e_WBreg == `grfWD_HI) ? e_HI :
                    (e_WBreg == `grfWD_LO) ? e_LO :
                    e_ALUout;
    assign e_RD2 = E_MF_rt;
    assign e_BD = IDEX_BD;
    assign e_ExcCode = (IDEX_ExcCode != `code_None) ? IDEX_ExcCode :
                       e_Exc_LdOv ? `code_AdEL :
                       e_Exc_StOv ? `code_AdES :
                       e_Exc_AriOv ? `code_Ov :
                       `code_None;


endmodule
