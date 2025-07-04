`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:58:42 11/19/2023 
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
module Fetch(
    input clk,
    input reset,
    input PC_en,
    input [31:0] d_NPC,
    output [31:0] f_PC,
    output [31:0] f_Instr
    );
    wire [31:0] PC;

    F_PC f_pc(
        .clk(clk),
        .reset(reset),
        .PC_en(PC_en),
        .NPC(d_NPC),
        .PC(PC)
    );
    F_IM f_im(
        .PC(PC),
        .Instr(f_Instr)
    );

    assign f_PC = PC;


endmodule
