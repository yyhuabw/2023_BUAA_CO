`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:41:51 12/07/2023 
// Design Name: 
// Module Name:    IF_ID 
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

module IF_ID(
    input clk,
    input reset,
    input Req,
    input Stall,//Stall
    input [31:0] f_PC,
    input f_BD,
    input d_isEret,
    input [4:0] f_ExcCode,
    input [31:0] f_Instr,
    input [31:0] EPC,
    output reg [31:0] IFID_PC,
    output reg IFID_BD,
    output reg [4:0] IFID_ExcCode,
    output reg [31:0] IFID_Instr
    );

    always @(posedge clk) begin
        if (reset || Req) begin
            IFID_PC <= `PC_Reset;
            IFID_BD <= 0;
            IFID_ExcCode <= `code_None;
            IFID_Instr <= `Instr_Reset;
        end
        else if (d_isEret && !Stall) begin
            IFID_PC <= EPC;
            IFID_BD <= 0;
            IFID_ExcCode <= `code_None;
            IFID_Instr <= `Instr_Reset;
        end
        else if (!Stall) begin
            IFID_PC <= f_PC;
            IFID_BD <= f_BD;
            IFID_ExcCode <= f_ExcCode;
            IFID_Instr <= f_Instr;
        end
    end


endmodule
