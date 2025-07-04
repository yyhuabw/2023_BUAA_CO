`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:52:39 11/05/2023 
// Design Name: 
// Module Name:    Controller 
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
module Controller(
    input [5:0] Op,
    input [5:0] Func,
    output [1:0] RegDst,
    output ALUSrc,
    output [1:0] MemtoReg,
    output RegWrite,
    output MemWrite,
    output [1:0] PCSrc,
    output ExtOp,
    output [2:0] ALUOp
    );
    wire add, sub, ori, lw, sw, beq, lui, jal, jr;

    assign add = ((Op == 6'b000000) && (Func == 6'b100000)) ? 1 : 0;
    assign sub = ((Op == 6'b000000) && (Func == 6'b100010)) ? 1 : 0;
    assign ori = (Op == 6'b001101) ? 1 : 0;
    assign lw = (Op == 6'b100011) ? 1 : 0;
    assign sw = (Op == 6'b101011) ? 1 : 0;
    assign beq = (Op == 6'b000100) ? 1 : 0;
    assign lui = (Op == 6'b001111) ? 1 : 0;
    assign jal = (Op == 6'b000011) ? 1 : 0;
    assign jr = ((Op == 6'b000000) && (Func == 6'b001000)) ? 1 : 0;

    assign RegDst = ((ori == 1) || (lw == 1) || (lui == 1)) ? 2'b00 :
                    ((add == 1) || (sub == 1)) ? 2'b01 :
                    (jal == 1) ? 2'b10 :
                    2'b00;
    assign ALUSrc = ((ori == 1) || (lw == 1) || (sw == 1) || (lui == 1)) ? 1 : 0;
    assign MemtoReg = ((add == 1) || (sub == 1) || (ori == 1) || (lui == 1)) ? 2'b00 :
                      (lw ==1) ? 2'b01 :
                      (jal == 1) ? 2'b10 :
                      2'b00; 
    assign RegWrite = ((add == 1) || (sub == 1) || (ori == 1) || (lw == 1) || (lui == 1) || (jal == 1)) ? 1 : 0;
    assign MemWrite = (sw == 1) ? 1 : 0;
    assign PCSrc = (beq == 1) ? 2'b01 :
                   (jal == 1) ? 2'b10 :
                   (jr == 1) ? 2'b11 :
                   2'b00;
    assign ExtOp = (ori == 1) ? 1 : 0;
    assign ALUOp = (ori == 1) ? 3'b001 :
                   ((add == 1) || (lw == 1) || (sw == 1)) ? 3'b010 :
                   ((sub == 1) || (beq == 1)) ? 3'b011 :
                   (lui == 1) ? 3'b100 :
                   3'b000;


endmodule