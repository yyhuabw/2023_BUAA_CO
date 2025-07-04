`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:07:33 11/19/2023 
// Design Name: 
// Module Name:    E_ALU 
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
`define aluAnd 3'b000
`define aluOr 3'b001
`define aluAdd 3'b010
`define aluSub 3'b011
`define aluLui_save 3'b100

module E_ALU(
    input [2:0] ALUOp,
    input [31:0] A,
    input [31:0] B,
    output reg [31:0] Result
    );

    always @(*) begin
        case (ALUOp)
            `aluAnd: begin
                Result = $signed(A) & $signed(B);
            end
            `aluOr: begin
                Result = $signed(A) | $signed(B);
            end
            `aluAdd: begin
                Result = $signed(A) + $signed(B);
            end
            `aluSub: begin
                Result = $signed(A) - $signed(B);
            end
            `aluLui_save: begin
                Result = B;
            end
            default: begin
                Result = 0;
            end 
        endcase
    end


endmodule
