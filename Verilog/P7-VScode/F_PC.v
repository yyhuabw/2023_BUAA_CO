`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:39:19 12/07/2023 
// Design Name: 
// Module Name:    F_PC 
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

module F_PC(
    input clk,
    input reset,
    input PC_en,//Stall
    input Req,
    input [31:0] NPC,
    output reg [31:0] PC
    );

    always @(posedge clk) begin
        if (reset) begin
            PC <= `PC_Reset;
        end
        else if (Req) begin
            PC <= `PC_ExcIn;
        end
        else if (PC_en) begin
            PC <= NPC;
        end
    end

    
endmodule

