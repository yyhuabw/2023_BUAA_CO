`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:12:03 11/19/2023 
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
`define grfWD_DMout 2'b01

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
    output m_RegWrite,
    output [31:0] m_PC,
    output [31:0] m_Instr,
    output [31:0] m_Mout,
    output [4:0] m_WriteReg
    );
    wire m_MemWrite;
    wire [1:0] m_WBreg;
    wire [31:0] m_DMout;

    //Forward
    wire [31:0] M_MF_rt;

    Controller m_control(
        .Instr(EXMEM_Instr),
        .WBreg(m_WBreg),
        .RegWrite(m_RegWrite),
        .MemWrite(m_MemWrite)
    );
    M_DM m_dm(
        .PC(EXMEM_PC),
        .clk(clk),
        .reset(reset),
        .MemWrite(m_MemWrite),
        .DMaddr(EXMEM_Eout),
        .DMin(M_MF_rt),
        .DMout(m_DMout)
    );

    //Forward
    assign M_MF_rt = (Forward_rt_M == 2'b01) ? MEMWB_Mout :
                     EXMEM_RD2;

    assign m_PC = EXMEM_PC;
    assign m_Instr = EXMEM_Instr;
    assign m_Mout = (m_WBreg == `grfWD_DMout) ? m_DMout :
                    EXMEM_Eout;
    assign m_WriteReg = EXMEM_WriteReg;


endmodule