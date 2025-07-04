`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:46:34 12/07/2023 
// Design Name: 
// Module Name:    Memory 
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

module Memory(
    input clk,
    input reset,
    input [31:0] EXMEM_PC,
    input [31:0] EXMEM_Instr,

    //Forward
    input [1:0] Forward_rt_M,//Signals
    input [31:0] MEMWB_Mout,//Data

    input [4:0] EXMEM_WriteReg,
    input [31:0] EXMEM_Eout,
    input [31:0] EXMEM_RD2,
    input [31:0] m_DMout,
    output m_RegWrite,
    output [31:0] m_PC,
    output [31:0] m_Instr,
    output [3:0] m_Byte_en,
    output [31:0] WData, 
    output [31:0] m_Mout,
    output [1:0] M_Tnew,
    output [4:0] m_WriteReg
    );
    wire [2:0] m_Stage = `M_stage;
    wire [2:0] m_WBreg, m_DEOp;
    wire [31:0] m_DEout, M_MF_rt;

    Controller m_control(
        .Instr(EXMEM_Instr),
        .Stage(m_Stage),
        .WBreg(m_WBreg),
        .RegWrite(m_RegWrite),
        .DEOp(m_DEOp),
        .M_Tnew(M_Tnew)
    );
    M_BE m_be(
        .BEaddr(EXMEM_Eout[1:0]),
        .BEdata(M_MF_rt),
        .Instr(EXMEM_Instr),
        .Byte_en(m_Byte_en),
        .WData(WData)
    );
    M_DE m_de(
        .DEaddr(EXMEM_Eout[1:0]),
        .DEOp(m_DEOp),
        .DEin(m_DMout),
        .DEout(m_DEout)
    );

    //Forward
    assign M_MF_rt = (Forward_rt_M == 2'b01) ? MEMWB_Mout :
                     EXMEM_RD2;

    assign m_PC = EXMEM_PC;
    assign m_Instr = EXMEM_Instr;
    assign m_Mout = (m_WBreg == `grfWD_DMout) ? m_DEout :
                    EXMEM_Eout;
    assign m_WriteReg = EXMEM_WriteReg;


endmodule
