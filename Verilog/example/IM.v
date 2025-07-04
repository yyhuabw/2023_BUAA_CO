`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:51:56 11/05/2023 
// Design Name: 
// Module Name:    IM 
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
module IM(
    input [13:2] IMaddr,
    output [31:0] IMout
    );
    reg [31:0] IMmemory [0:4095];
    integer i;

    initial begin
        $readmemh("code.txt", IMmemory);
    end

    assign IMout = IMmemory[IMaddr];


endmodule
