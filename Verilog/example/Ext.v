`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:51:46 11/05/2023 
// Design Name: 
// Module Name:    Ext 
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
module Ext(
    input ExtOp,
    input [15:0] Extin,
    output [31:0] Extout
    );

    assign Extout = (ExtOp == 1) ? {{16{1'b0}}, Extin} : {{16{Extin[15]}}, Extin};


endmodule
