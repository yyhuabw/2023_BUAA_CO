`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:00:41 11/19/2023 
// Design Name: 
// Module Name:    D_CMP 
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
module D_CMP(
    input [31:0] A,
    input [31:0] B,
    output Equ
    );

    assign Equ = (A == B);


endmodule