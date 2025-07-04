`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:43:28 12/07/2023 
// Design Name: 
// Module Name:    M_BE 
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

module M_BE(
    input [1:0] BEaddr,
    input [31:0] Instr,
    input [31:0] BEdata,
    output reg [3:0] Byte_en,
    output reg [31:0] WData
    );
    wire [5:0] Op;

    assign Op = Instr[31:26];

    always @(*) begin
        case (Op)
            `Sw: begin
                Byte_en = 4'b1111;
                WData = BEdata;
            end
            `Sh: begin
                case (BEaddr[1])
                    1'b0: begin
                        Byte_en = 4'b0011;
                        WData = BEdata;
                    end
                    1'b1: begin
                        Byte_en = 4'b1100;
                        WData = BEdata << 16;
                    end 
                endcase
            end
            `Sb: begin
                case (BEaddr)
                    2'b00: begin
                        Byte_en = 4'b0001;
                        WData = BEdata;
                    end
                    2'b01: begin
                        Byte_en = 4'b0010;
                        WData = BEdata << 8;
                    end
                    2'b10: begin
                        Byte_en = 4'b0100;
                        WData = BEdata << 16;
                    end
                    2'b11: begin
                        Byte_en = 4'b1000;
                        WData = BEdata << 24;
                    end 
                endcase
            end
            default: begin
                Byte_en = 0;
                WData = 0;
            end
        endcase
    end


endmodule
