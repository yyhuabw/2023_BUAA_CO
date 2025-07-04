`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:22:45 12/07/2023 
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

//reset
`define PC_Reset 32'h0000_3000
`define Instr_Reset 32'h0000_0000

//Stage
`define F_stage 3'b000
`define D_stage 3'b001
`define E_stage 3'b010
`define M_stage 3'b011
`define W_stage 3'b100

//R_type instructions
  //Op
  `define R_type 6'b000000
  //Func
     //cal_rr
     `define And 6'b100100
     `define Or 6'b100101
     `define Add 6'b100000
     `define Sub 6'b100010
     `define Slt 6'b101010
     `define Sltu 6'b101011
     //mv_to
     `define Mult 6'b011000 
     `define Multu 6'b011001
     `define Div 6'b011010
     `define Divu 6'b011011
     `define Mthi 6'b010001
     `define Mtlo 6'b010011
     //mv_fr
     `define Mfhi 6'b010000
     `define Mflo 6'b010010
     //jr
     `define Jr 6'b001000

//cal_ri
  //Op
  `define Addi 6'b001000
  `define Andi 6'b001100
  `define Ori 6'b001101

//LUI
  //Op
  `define Lui 6'b001111

//load
  //Op
  `define Lb 6'b100000
  `define Lh 6'b100001
  `define Lw 6'b100011

//store
  //Op
  `define Sb 6'b101000
  `define Sh 6'b101001
  `define Sw 6'b101011

//branch
  //Op
  `define Beq 6'b000100
  `define Bne 6'b000101

//JAL
  //Op
  `define Jal 6'b000011

//RegDst
`define grfWR_rt 2'b00
`define grfWR_rd 2'b01
`define grfWR_ra 2'b10

//ALUSrc
`define aluB_RD 2'b00
`define aluB_Dout 2'b01

//WBreg
`define grfWD_ALUOut 3'b000
`define grfWD_DMout 3'b001
`define grfWD_pc8 3'b010
`define grfWD_HI 3'b011
`define grfWD_LO 3'b100

//PCSrc
`define pc_4 3'b000
`define pc_Beq 3'b001
`define pc_Bne 3'b010
`define pc_Jal 3'b011
`define pc_Jr 3'b100

//EXTOp
`define extSign 2'b00
`define extZero 2'b01
`define extLui 2'b10

//DEOp
`define de_Lw 3'b000
`define de_Lh 3'b001
`define de_Lb 3'b010

//ALUOp
`define alu_And 3'b000
`define alu_Or 3'b001
`define alu_Add 3'b010
`define alu_Sub 3'b011
`define alu_save 3'b100
`define alu_Slt 3'b101
`define alu_Sltu 3'b110

//MDUOp
`define mdu_Mult 3'b000
`define mdu_Multu 3'b001
`define mdu_Div 3'b010
`define mdu_Divu 3'b011
`define mdu_Mthi 3'b100
`define mdu_Mtlo 3'b101

//Reg
`define reg_zero 5'b00000
`define reg_ra 5'b11111
