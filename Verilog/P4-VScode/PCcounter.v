`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:52:21 11/05/2023 
// Design Name: 
// Module Name:    PCcounter 
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
module PCcounter(
    input [1:0] PCSrc,
    input Zero,
    input [31:0] PC,
    input [25:0] instr_index,
    input [31:0] GPR_ra,
    output reg [31:0] NPC,
    output [31:0] pc4
    );
    wire [15:0] offset = instr_index[15:0];

    always @(*) begin
        case (PCSrc)
            2'b00: begin
                NPC = PC + 4;
            end
            2'b01: begin
                if (Zero) begin
                    NPC = PC + 4 + {{14{offset[15]}}, offset, {2{1'b0}}};
                end
                else begin
                    NPC = PC + 4;
                end
            end
            2'b10: begin
                NPC = {PC[31:28], instr_index, {2{1'b0}}};
            end
            2'b11: begin
                NPC = GPR_ra;
            end 
        endcase
    end 

    assign pc4 = PC + 32'd4;


endmodule
