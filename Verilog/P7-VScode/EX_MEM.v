`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:42:38 12/07/2023 
// Design Name: 
// Module Name:    EX_MEM 
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

module EX_MEM(
    input clk,
    input reset,
    input [31:0] e_PC,
    input [31:0] e_Instr,
    input [4:0] e_WriteReg,
    input [31:0] e_Eout,
    input [31:0] e_RD2,
    input e_BD,
    input Req,
    input [4:0] e_ExcCode,
    output reg [31:0] EXMEM_PC,
    output reg [31:0] EXMEM_Instr,
    output reg [4:0] EXMEM_WriteReg,
    output reg [31:0] EXMEM_Eout,
    output reg [31:0] EXMEM_RD2,
    output reg EXMEM_BD,
    output reg [4:0] EXMEM_ExcCode
    );

    always @(posedge clk) begin
        if (reset || Req) begin
            EXMEM_PC <= `PC_Reset;
            EXMEM_Instr <= `Instr_Reset;
            EXMEM_WriteReg <= `reg_zero;
            EXMEM_Eout <= 0;
            EXMEM_RD2 <= 0;
            EXMEM_BD <= 0;
            EXMEM_ExcCode <= `code_None;
        end
        else begin
            EXMEM_PC <= e_PC;
            EXMEM_Instr <= e_Instr;
            EXMEM_WriteReg <= e_WriteReg; 
            EXMEM_Eout <= e_Eout;
            EXMEM_RD2 <= e_RD2;
            EXMEM_BD <= e_BD;
            EXMEM_ExcCode <= e_ExcCode;
        end
    end


endmodule
