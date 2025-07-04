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
    input IFID_en,//Stall
    input [31:0] f_PC,
    input [31:0] f_Instr,
    output reg [31:0] IFID_PC,
    output reg [31:0] IFID_Instr
    );

    always @(posedge clk) begin
        if (reset) begin
            IFID_PC <= `PC_Reset;
            IFID_Instr <= `Instr_Reset;
        end
        else if (IFID_en) begin
            IFID_PC <= f_PC;
            IFID_Instr <= f_Instr;
        end
        else begin
            IFID_PC <= IFID_PC;
            IFID_Instr <= IFID_Instr;
        end
    end


endmodule
