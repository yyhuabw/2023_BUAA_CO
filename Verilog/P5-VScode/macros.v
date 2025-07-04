`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:04:11 11/19/2023 
// Design Name: 
// Module Name:    macros 
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

//R_type instructions
//Op
`define R_type 6'b000000
//Func
//Cal_r
`define Add 6'b100000
`define Sub 6'b100010
//jr
`define Jr 6'b001000

//other instructions
//Op
`define Ori 6'b001101
`define Lw 6'b100011
`define Sw 6'b101011
`define Beq 6'b000100
`define Lui 6'b001111
`define Jal 6'b000011

//RegDst
`define grfWR_rt 2'b00
`define grfWR_rd 2'b01
`define grfWR_ra 2'b10

//ALUSrc
`define aluB_RD 2'b00
`define aluB_Dout 2'b01

//WBreg
`define grfWD_ALUOut 2'b00
`define grfWD_DMout 2'b01
`define grfWD_pc8 2'b10

//PCSrc
`define pc_4 3'b000
`define b_type 3'b001
`define j_jump 3'b010
`define j_reg 3'b011

//EXTOp
`define extSign 2'b00
`define extZero 2'b01
`define extLui 2'b10

//ALUOp
`define aluAnd 3'b000
`define aluOr 3'b001
`define aluAdd 3'b010
`define aluSub 3'b011
`define aluLui_save 3'b100

//Reg
`define reg_zero 5'b00000
`define reg_ra 5'b11111
