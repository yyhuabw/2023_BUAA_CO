`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:27:59 12/07/2023 
// Design Name: 
// Module Name:    D_EXT 
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

module D_EXT(
    input [1:0] EXTOp,
    input [15:0] EXTin,
    output reg [31:0] EXTout
    );

    always @(*) begin
        case (EXTOp)
            `extSign: begin
                EXTout = {{16{EXTin[15]}}, EXTin};
            end
            `extZero: begin
                EXTout = {{16{1'b0}}, EXTin};
            end
            `extLui: begin
                EXTout = {EXTin, {16{1'b0}}};
            end  
            default: begin
                EXTout = 0;
            end
        endcase
    end


endmodule
