`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:57:35 11/19/2023 
// Design Name: 
// Module Name:    F_IM 
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

module F_IM(
    input [31:0] PC,
    output [31:0] Instr
    );
    reg [31:0] IMmemory [0:4095];
    wire [31:0] PC_im;

    initial begin
        $readmemh("code.txt", IMmemory);
    end

    assign PC_im = PC - `PC_Reset;
    assign Instr = IMmemory[PC_im[13:2]];


endmodule