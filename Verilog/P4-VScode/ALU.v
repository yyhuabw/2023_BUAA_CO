`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:52:53 11/05/2023 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [2:0] ALUOp,
    input [31:0] A,
    input [31:0] B,
    input Zero,
    output reg [31:0] Result
    );

    always @(*) begin
        case (ALUOp)
            3'b000: begin
                Result = $signed(A) & $signed(B);
            end
            3'b001: begin
                Result = $signed(A) | $signed(B);
            end
            3'b010: begin
                Result = $signed(A) + $signed(B);
            end
            3'b011: begin
                Result = $signed(A) - $signed(B);
            end
            3'b100: begin
                Result = B << 16;
            end
            default: begin
                Result = 0;
            end 
        endcase
    end

    assign Zero = (A == B) ? 1 : 0 ;


endmodule
