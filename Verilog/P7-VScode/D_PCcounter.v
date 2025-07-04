`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:29:00 12/07/2023 
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
`include "macros.v"

module D_PCcounter(
    input [2:0] PCSrc,
    input Beq_judge,
    input Bne_judge,
    input [31:0] f_PC,
    input [31:0] IFID_PC,
    input [25:0] imm26,
    input [31:0] GPR_jump,
    input [31:0] EPC,
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
            `pc_Beq: begin
                if (Beq_judge) begin
                    NPC = IFID_PC + 4 + {{14{imm16[15]}}, imm16, {2{1'b0}}};
                end
                else begin
                    NPC = f_PC + 4;
                end
            end
            `pc_Bne: begin
                if (Bne_judge) begin
                    NPC = IFID_PC + 4 + {{14{imm16[15]}}, imm16, {2{1'b0}}};
                end
                else begin
                    NPC = f_PC + 4;
                end
            end
            `pc_Jal: begin
                NPC = {IFID_PC_4[31:28], imm26, {2{1'b0}}};
            end
            `pc_Jr: begin
                NPC = GPR_jump;
            end
            `pc_Epc: begin
                NPC = EPC;
            end
        endcase
    end 
 
    assign IFID_PC_4 = IFID_PC + 4;
    assign pc8 = IFID_PC + 8;


endmodule
