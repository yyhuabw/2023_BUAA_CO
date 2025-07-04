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

//Req
`define PC_ExcIn 32'h0000_4180

//NOP
`define nop 32'h0000_0000

//Address Range
`define PC_lowest 32'h0000_3000
`define PC_highest 32'h0000_6ffc
`define DM_lowest 32'h0000_0000
`define DM_highest 32'h0000_2fff
`define TC0_lowest 32'h0000_7f00
`define TC0_Count 32'h0000_7f08
`define TC0_highest 32'h0000_7f0b
`define TC1_lowest 32'h0000_7f10
`define TC1_Count 32'h0000_7f18
`define TC1_highest 32'h0000_7f1b
`define Inter_lowest 32'h0000_7f20
`define Inter_highest 32'h0000_7f23

//Stage
`define F_stage 3'b000
`define D_stage 3'b001
`define E_stage 3'b010
`define M_stage 3'b011
`define W_stage 3'b100

//SPECIAL instructions
  //Op
  `define SPECIAL 6'b000000
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
     //JR
     `define Jr 6'b001000
     //SYSCALL
     `define Syscall 6'b001100

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

//COP0
  //Op
  `define COP0 6'b010000
  //Rs
  `define Mfc0 5'b00000
  `define Mtc0 5'b00100
  //Func
  `define Eret 6'b011000

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
`define grfWD_CP0 3'b101

//PCSrc
`define pc_4 3'b000
`define pc_Beq 3'b001
`define pc_Bne 3'b010
`define pc_Jal 3'b011
`define pc_Jr 3'b100
`define pc_Epc 3'b101

//EXTOp
`define extSign 2'b00
`define extZero 2'b01
`define extLui 2'b10

//DEOp
`define de_Lw 3'b000
`define de_Lh 3'b001
`define de_Lb 3'b010
`define de_Others 3'b011

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
`define mdu_Others 3'b110

//Reg
`define reg_zero 5'b00000
`define reg_ra 5'b11111

//CP0
  //CP0 Reg
  `define reg_SR 5'd12
  `define reg_Cause 5'd13
  `define reg_EPC 5'd14

  //Bit Field
  `define _IM 15:10
  `define _EXL 1
  `define _IE 0
  `define _BD 31
  `define _IP 15:10
  `define _ExcCode 6:2

//Int and Exc
`define code_Int 5'd0
`define code_AdEL 5'd4
`define code_AdES 5'd5
`define code_Syscall 5'd8
`define code_RI 5'd10
`define code_Ov 5'd12
`define code_None 5'd0