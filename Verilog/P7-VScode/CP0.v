`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:37:38 12/12/2023 
// Design Name: 
// Module Name:    CP0 
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

module CP0(
    input clk,
    input reset,
    input en,
    input [4:0] CP0addr,
    input [31:0] CP0in,
    input [31:0] VPC,
    input BDin,
    input [4:0] ExcCodeIn,
    input [5:0] HWInt,
    input EXLclr,
    output [31:0] CP0out,
    output [31:0] EPCout,
    output Req
    );
    reg [31:0] SR, Cause, EPC;
    wire int_req, exc_req;

    always @(posedge clk) begin
        if (reset) begin
            SR <= 0;
            Cause <= 0;
            EPC <= 0;
        end
        else if (EXLclr) begin
            SR[`_EXL] <= 0;
        end
        else if (Req) begin
            SR[`_EXL] <= 1;
            Cause[`_BD] <= BDin;
            Cause[`_ExcCode] <= (int_req) ? `code_Int : ExcCodeIn;
            EPC <= BDin ? (VPC - 32'd4) : VPC;
        end
        else if (en) begin
            case (CP0addr)
                `reg_SR: begin
                    SR <= CP0in;
                end
                `reg_EPC: begin
                    EPC <= CP0in;
                end 
            endcase
        end
        if (!reset) begin
            Cause[`_IP] <= HWInt;
        end
    end

    assign int_req = (|(HWInt & SR[`_IM])) & SR[`_IE] & (!SR[`_EXL]);
    assign exc_req = (ExcCodeIn != `code_Int) & (!SR[`_EXL]);
    assign Req = int_req | exc_req;

    assign CP0out = (CP0addr == `reg_SR) ? SR :
                    (CP0addr == `reg_Cause) ? Cause :
                    (CP0addr == `reg_EPC) ? EPC :
                    0;
    assign EPCout = EPC;


endmodule