`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:43:05 12/07/2023 
// Design Name: 
// Module Name:    MEM_WB 
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

module MEM_WB(
    input clk,
    input reset,
    input [31:0] m_PC,
    input [31:0] m_Instr,
    input [31:0] m_Mout,
    input [4:0] m_WriteReg,
    output reg [31:0] MEMWB_PC,
    output reg [31:0] MEMWB_Instr,
    output reg [31:0] MEMWB_Mout,
    output reg [4:0] MEMWB_WriteReg
    );

    always @(posedge clk) begin
        if (reset) begin
            MEMWB_PC <= `PC_Reset;
            MEMWB_Instr <= `Instr_Reset;
            MEMWB_Mout <= 0;
            MEMWB_WriteReg <= `reg_zero;
        end
        else begin
            MEMWB_PC <= m_PC;
            MEMWB_Instr <= m_Instr;
            MEMWB_Mout <= m_Mout;
            MEMWB_WriteReg <= m_WriteReg;
        end
    end


endmodule