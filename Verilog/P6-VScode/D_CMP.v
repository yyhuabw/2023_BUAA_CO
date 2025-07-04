`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:27:31 12/07/2023 
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
    output Beq_judge,
    output Bne_judge
    );

    assign Beq_judge = (A == B);
    assign Bne_judge = (A != B);


endmodule