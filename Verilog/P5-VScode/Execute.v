`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:08:14 11/19/2023 
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
`define aluB_Dout 2'b01

module Execute(
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
    output e_RegWrite,
    output [31:0] e_PC,
    output [31:0] e_Instr,
    output [4:0] e_WriteReg,
    output [31:0] e_Eout,
    output [31:0] e_RD2
    );
    wire [1:0] e_ALUSrc;
    wire [2:0] e_ALUOp;
    wire [31:0] B;

    //Forward
    wire [31:0] E_MF_rs;
    wire [31:0] E_MF_rt;

    Controller e_control(
        .Instr(IDEX_Instr),
        .ALUSrc(e_ALUSrc),
        .RegWrite(e_RegWrite),
        .ALUOp(e_ALUOp)
    );
    E_ALU e_alu(
        .ALUOp(e_ALUOp),
        .A(E_MF_rs),
        .B(B),
        .Result(e_Eout)
    );

    //Forward
    assign E_MF_rs = (Forward_rs_E == 2'b01) ? EXMEM_Eout :
                     (Forward_rs_E == 2'b10) ? MEMWB_Mout :
                     IDEX_RD1;
    assign E_MF_rt = (Forward_rt_E == 2'b01) ? EXMEM_Eout :
                     (Forward_rt_E == 2'b10) ? MEMWB_Mout :
                     IDEX_RD2;

    assign B = (e_ALUSrc == `aluB_Dout) ? IDEX_Dout :
               E_MF_rt;

    assign e_PC = IDEX_PC;
    assign e_Instr = IDEX_Instr;
    assign e_WriteReg = IDEX_WriteReg;
    assign e_RD2 = E_MF_rt;


endmodule