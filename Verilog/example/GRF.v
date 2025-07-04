`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:51:09 11/05/2023 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input [31:0] PC,
    input clk,
    input reset,
    input RegWrite,
    input [4:0] ReadReg1,
    input [4:0] ReadReg2,
    input [4:0] WriteReg,
    input [31:0] WriteData,
    output [31:0] ReadData1,
    output [31:0] ReadData2
    );
    reg [31:0] grf [0:31];
    integer i;

    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 32; i = i +1) begin
                grf[i] <= 0;
            end
        end
        else begin
            if ((RegWrite == 1) && (WriteReg != 0)) begin
                grf[WriteReg] <= WriteData;
                $display("@%h: $%d <= %h", PC, WriteReg, WriteData);
            end
            else begin
                grf[WriteReg] <= grf[WriteReg];
            end    
        end
    end

    assign ReadData1 = grf[ReadReg1];
    assign ReadData2 = grf[ReadReg2];


endmodule
