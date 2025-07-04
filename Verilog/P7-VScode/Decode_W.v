`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:30:13 12/07/2023 
// Design Name: 
// Module Name:    Decode_W 
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

module Decode_W(
    input clk,
    input reset,
    input [31:0] f_PC,
    input [31:0] IFID_PC,
    input IFID_BD,
    input [4:0] IFID_ExcCode,
    input [31:0] IFID_Instr,

    //Forward
    input [1:0] Forward_rs_D,//Signals
    input [1:0] Forward_rt_D,
    input [31:0] IDEX_Dout,//Data
    input [31:0] EXMEM_Eout,
    input [31:0] MEMWB_Mout,

    input w_RegWrite,
    input [4:0] MEMWB_WriteReg,
    input [31:0] EPC,
    output d_isMDU_instr,
    output [31:0] d_PC,
    output [31:0] d_Instr,
    output isBD,
    output isEret,
    output [1:0] rs_Tuse,
    output [1:0] rt_Tuse,
    output [4:0] d_WriteReg,
    output [31:0] d_Dout,
    output [31:0] d_NPC,
    output [31:0] d_MF_rs,
    output [31:0] d_MF_rt,
    output d_BD,
    output [4:0] d_ExcCode
    );
    wire d_Beq_judge, d_Bne_judge, d_Exc_RI, d_isSyscall;
    wire [1:0] d_RegDst, d_EXTOp;
    wire [2:0] d_WBreg, d_PCSrc;
    wire [31:0] RD1, RD2, d_EXTout, d_pc8;

    //Forward
    wire [31:0] D_MF_rs, D_MF_rt;

    Controller d_control(
        .Instr(IFID_Instr),
        .RegDst(d_RegDst),
        .WBreg(d_WBreg),
        .PCSrc(d_PCSrc),
        .EXTOp(d_EXTOp),
        .isMDU_instr(d_isMDU_instr),
        .D_Exc_RI(d_Exc_RI),
        .isEret(isEret),
        .isSyscall(d_isSyscall),
        .isBD(isBD),
        .rs_Tuse(rs_Tuse), // reg_Tuse
        .rt_Tuse(rt_Tuse)
    );
    D_GRF d_grf(
        .clk(clk),
        .reset(reset),
        .RegWrite(w_RegWrite),
        .ReadReg1(IFID_Instr[25:21]),
        .ReadReg2(IFID_Instr[20:16]),
        .WriteReg(MEMWB_WriteReg),
        .WriteData(MEMWB_Mout),
        .ReadData1(RD1),
        .ReadData2(RD2)
    );
    D_CMP d_cmp(
        .A(D_MF_rs),
        .B(D_MF_rt),
        .Beq_judge(d_Beq_judge),
        .Bne_judge(d_Bne_judge)
    );
    D_EXT d_ext(
        .EXTOp(d_EXTOp),
        .EXTin(IFID_Instr[15:0]),
        .EXTout(d_EXTout)
    );
    D_PCcounter d_pccounter(
        .PCSrc(d_PCSrc),
        .Beq_judge(d_Beq_judge),
        .Bne_judge(d_Bne_judge),
        .f_PC(f_PC),
        .IFID_PC(IFID_PC),
        .imm26(IFID_Instr[25:0]),
        .GPR_jump(D_MF_rs),
        .EPC(EPC),
        .NPC(d_NPC),
        .pc8(d_pc8)
    );

    //Forward
    assign D_MF_rs = (Forward_rs_D == 2'b01) ? IDEX_Dout :
                     (Forward_rs_D == 2'b10) ? EXMEM_Eout :
                     (Forward_rs_D == 2'b11) ? MEMWB_Mout :
                     RD1;
    assign D_MF_rt = (Forward_rt_D == 2'b01) ? IDEX_Dout :
                     (Forward_rt_D == 2'b10) ? EXMEM_Eout :
                     (Forward_rt_D == 2'b11) ? MEMWB_Mout :
                     RD2;

    assign d_PC = IFID_PC;
    assign d_Instr = d_Exc_RI ? `nop : IFID_Instr;
    assign d_WriteReg = Stage_WriteReg(IFID_Instr, d_RegDst);//function
    assign d_Dout = (d_WBreg == `grfWD_pc8) ? d_pc8 :
                    d_EXTout;
    assign d_MF_rs = D_MF_rs;
    assign d_MF_rt = D_MF_rt;
    assign d_BD = IFID_BD;
    assign d_ExcCode = (IFID_ExcCode != `code_None) ? IFID_ExcCode : 
                       d_isSyscall ? `code_Syscall :
                       d_Exc_RI ? `code_RI :
                       `code_None;


    //function entity
    function [4:0] Stage_WriteReg;
        input [31:0] Stage_Instr;
        input [1:0] Stage_RegDst;
        begin
            case (Stage_RegDst)
                `grfWR_rt: begin
                    Stage_WriteReg = Stage_Instr[20:16];
                end
                `grfWR_rd: begin
                    Stage_WriteReg = Stage_Instr[15:11];
                end
                `grfWR_ra: begin
                    Stage_WriteReg = `reg_ra;
                end
                default: begin
                    Stage_WriteReg = `reg_zero;
                end
            endcase
        end
    endfunction                     


endmodule
