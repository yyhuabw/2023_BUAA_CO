`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:11:18 11/19/2023 
// Design Name: 
// Module Name:    M_DM 
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
module M_DM(
    input [31:0] PC,
    input clk,
    input reset,
    input MemWrite,
    input [31:0] DMaddr,
    input [31:0] DMin,
    output [31:0] DMout
    );
    reg [31:0] DMmemory [0:8191];
    integer i;

    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 8192; i = i + 1) begin
                DMmemory[i] <= 0;
            end
        end
        else begin
            if (MemWrite) begin
                DMmemory[DMaddr[13:2]] <= DMin;
                $display("%d@%h: *%h <= %h", $time, PC, DMaddr, DMin);
            end
            else begin
                DMmemory[DMaddr[13:2]] <= DMmemory[DMaddr[13:2]];
            end
        end
    end

    assign DMout = DMmemory[DMaddr[13:2]];



endmodule
