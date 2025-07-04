`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:39:46 12/07/2023 
// Design Name: 
// Module Name:    Fetch 
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

module Fetch(
    input clk,
    input reset,
    input Req,
    input PC_en,
    input isBD,
    input [31:0] Instr_in,
    input [31:0] d_NPC,
    output [31:0] f_PC,
    output f_BD,
    output [4:0] f_ExcCode,
    output [31:0] fixed_Instr
    );
    wire [31:0] PCout;

    F_PC f_pc(
        .clk(clk),
        .reset(reset),
        .PC_en(PC_en),
        .Req(Req),
        .NPC(d_NPC),
        .PC(PCout)
    );

    assign f_PC = PCout;
    assign f_BD = isBD;
    assign f_ExcCode = ((PCout[1:0] != 2'b00) || (PCout < `PC_lowest) || (PCout > `PC_highest)) ? `code_AdEL : `code_None;
    assign fixed_Instr = (f_ExcCode != `code_None) ? `nop : Instr_in;


endmodule
