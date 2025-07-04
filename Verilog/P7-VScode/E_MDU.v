`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:38:04 12/07/2023 
// Design Name: 
// Module Name:    E_MDU 
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

module E_MDU(
    input clk,
    input reset,
    input Req,
    input Start,
    input [2:0] MDUOp,
    input [31:0] A,
    input [31:0] B,
    output Busy, // to hazard
    output reg [31:0] HI,
    output reg [31:0] LO
    );
    reg [31:0] HI_temp, LO_temp;
    reg [3:0] cnt;

    always @(posedge clk) begin
        if (reset) begin
            HI <= 0;
            LO <= 0;
            HI_temp <= 0;
            LO_temp <= 0;
        end
        else if (Start && !Req) begin
            case (MDUOp)
                `mdu_Mult: begin
                    {HI_temp, LO_temp} <= $signed(A) * $signed(B);
                    cnt <= 5; 
                end
                `mdu_Multu: begin
                    {HI_temp, LO_temp} <= A * B;
                    cnt <= 5;
                end
                `mdu_Div: begin
                    HI_temp <= $signed(A) % $signed(B);
                    LO_temp <= $signed(A) / $signed(B);
                    cnt <= 10; 
                end
                `mdu_Divu: begin
                    HI_temp <= A % B;
                    LO_temp <= A / B;
                    cnt <= 10;
                end
                default: begin
                    HI_temp <= HI_temp;
                    LO_temp <= LO_temp;
                    cnt <= cnt;
                end
            endcase
        end
        else if (MDUOp == `mdu_Mthi && !Req) begin
            HI <= A;
        end
        else if (MDUOp == `mdu_Mtlo && !Req) begin
            LO <= A;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            cnt <= 0;
        end
        else if (Start == 0 && cnt != 0) begin
            cnt <= cnt - 1;
        end
    end

    assign Busy = (cnt != 0);

    always @(negedge Busy) begin
        HI <= HI_temp;
        LO <= LO_temp;
    end


endmodule
