`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:02:38 11/19/2023 
// Design Name: 
// Module Name:    D_PCcounter 
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
`define pc_4 3'b000
`define b_type 3'b001
`define j_jump 3'b010
`define j_reg 3'b011

module D_PCcounter(
    input [2:0] PCSrc,
    input Equ,
    input [31:0] f_PC,
    input [31:0] IFID_PC,
    input [25:0] imm26,
    input [31:0] GPR_jump,
    output reg [31:0] NPC,
    output [31:0] pc8
    );
    wire [15:0] imm16 = imm26[15:0];
    wire [31:0] IFID_PC_4;

    always @(*) begin
        case (PCSrc)
            `pc_4: begin
                NPC = f_PC + 4;
            end
            `b_type: begin
                if (Equ) begin
                    NPC = IFID_PC + 4 + {{14{imm16[15]}}, imm16, {2{1'b0}}};
                end
                else begin
                    NPC = f_PC + 4;
                end
            end
            `j_jump: begin
                NPC = {IFID_PC_4[31:28], imm26, {2{1'b0}}};
            end
            `j_reg: begin
                NPC = GPR_jump;
            end
        endcase
    end 
 
    assign IFID_PC_4 = IFID_PC + 4;
    assign pc8 = IFID_PC + 8;


endmodule