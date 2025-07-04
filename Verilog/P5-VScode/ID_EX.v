`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:06:37 11/19/2023 
// Design Name: 
// Module Name:    ID_EX 
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
`define Instr_Reset 32'h0000_0000
`define reg_zero 5'b00000

module ID_EX(
    input clk,
    input reset,
    input IDEX_clear,//Stall
    input [31:0] d_PC,
    input [31:0] d_Instr,
    input [4:0] d_WriteReg,
    input [31:0] d_Dout,
    input [31:0] d_MF_rs,
    input [31:0] d_MF_rt,
    output reg [31:0] IDEX_PC,
    output reg [31:0] IDEX_Instr,
    output reg [4:0] IDEX_WriteReg,
    output reg [31:0] IDEX_Dout,
    output reg [31:0] IDEX_RD1,
    output reg [31:0] IDEX_RD2
    );

    always @(posedge clk) begin
        if (reset || IDEX_clear) begin
            IDEX_PC <= `PC_Reset;
            IDEX_Instr <= `Instr_Reset;
            IDEX_WriteReg <= `reg_zero;
            IDEX_Dout <= 0;
            IDEX_RD1 <= 0;
            IDEX_RD2 <= 0;
        end
        else begin
            IDEX_PC <= d_PC;
            IDEX_Instr <= d_Instr;
            IDEX_WriteReg <= d_WriteReg;
            IDEX_Dout <= d_Dout;
            IDEX_RD1 <= d_MF_rs;
            IDEX_RD2 <= d_MF_rt;
        end
    end


endmodule
