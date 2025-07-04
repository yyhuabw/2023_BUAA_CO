`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:37:35 12/07/2023 
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
`include "macros.v"

module E_ALU(
    input [2:0] ALUOp,
    input [31:0] A,
    input [31:0] B,
    output reg [31:0] Result
    );

    always @(*) begin
        case (ALUOp)
            `alu_And: begin
                Result = $signed(A) & $signed(B);
            end
            `alu_Or: begin
                Result = $signed(A) | $signed(B);
            end
            `alu_Add: begin
                Result = $signed(A) + $signed(B);
            end
            `alu_Sub: begin
                Result = $signed(A) - $signed(B);
            end
            `alu_save: begin
                Result = B;
            end
            `alu_Slt: begin
                if ($signed(A) < $signed(B)) begin
                    Result = {{31{1'b0}}, 1'b1};
                end
                else begin
                    Result = {32{1'b0}};
                end
            end
            `alu_Sltu: begin
                if (A < B) begin
                    Result = {{31{1'b0}}, 1'b1};
                end
                else begin
                    Result = {32{1'b0}};
                end
            end
            default: begin
                Result = 0;
            end 
        endcase
    end


endmodule
