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
    input [31:0] BEaddr,
    input [31:0] Instr,
    input Req,
    input [31:0] BEdata,
    output Exc_AdES,
    output [3:0] Byte_en,
    output reg [31:0] WData
    );
    wire [5:0] Op;
    reg [3:0] byte_en;
    wire Exc_Align, Exc_OutOfRange, Exc_TC;

    assign Op = Instr[31:26];

    always @(*) begin
        case (Op)
            `Sw: begin
                byte_en = 4'b1111;
                WData = BEdata;
            end
            `Sh: begin
                case (BEaddr[1])
                    1'b0: begin
                        byte_en = 4'b0011;
                        WData = BEdata;
                    end
                    1'b1: begin
                        byte_en = 4'b1100;
                        WData = BEdata << 16;
                    end 
                endcase
            end
            `Sb: begin
                case (BEaddr[1:0])
                    2'b00: begin
                        byte_en = 4'b0001;
                        WData = BEdata;
                    end
                    2'b01: begin
                        byte_en = 4'b0010;
                        WData = BEdata << 8;
                    end
                    2'b10: begin
                        byte_en = 4'b0100;
                        WData = BEdata << 16;
                    end
                    2'b11: begin
                        byte_en = 4'b1000;
                        WData = BEdata << 24;
                    end 
                endcase
            end
            default: begin
                byte_en = 0;
                WData = 0;
            end
        endcase
    end

    assign Byte_en = Req ? 4'b0000 : byte_en;
    assign Exc_Align = ((Op == `Sw) && (|BEaddr[1:0])) || 
                       ((Op == `Sh) && BEaddr[0]);
    assign Exc_OutOfRange = !((BEaddr >= `DM_lowest && BEaddr <= `DM_highest) ||
                             (BEaddr >= `TC0_lowest && BEaddr <= `TC0_highest) ||
                             (BEaddr >= `TC1_lowest && BEaddr <= `TC1_highest) ||
                             (BEaddr >= `Inter_lowest && BEaddr <= `Inter_highest));
    assign Exc_TC = (BEaddr >= `TC0_Count && BEaddr <= `TC0_highest) ||
                    (BEaddr >= `TC1_Count && BEaddr <= `TC1_highest) ||
                    ((Op == `Sh || Op == `Sb) && BEaddr >= `TC0_lowest && BEaddr <= `TC1_highest);
    assign Exc_AdES = (Op == `Sw || Op == `Sh || Op == `Sb) && (Exc_Align || Exc_OutOfRange || Exc_TC);


endmodule
