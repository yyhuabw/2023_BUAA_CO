`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:56:01 11/19/2023 
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
`define PC_Reset 32'h0000_3000

module F_PC(
    input clk,
    input reset,
    input PC_en,//Stall
    input [31:0] NPC,
    output reg [31:0] PC
    );

    always @(posedge clk) begin
        if (reset) begin
            PC <= `PC_Reset;
        end
        else if (PC_en) begin
            PC <= NPC;
        end
        else begin
            PC <= PC;
        end
    end

    
endmodule
