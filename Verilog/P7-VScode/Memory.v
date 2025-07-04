`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:46:34 12/07/2023 
// Design Name: 
// Module Name:    Memory 
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

module Memory(
    input clk,
    input reset,
    input [31:0] EXMEM_PC,
    input [31:0] EXMEM_Instr,

    //Forward
    input [1:0] Forward_EPC_M,//Signals
    input [1:0] Forward_rt_M,
    input [31:0] MEMWB_Mout,//Data

    input [4:0] EXMEM_WriteReg,
    input [31:0] EXMEM_Eout,
    input [31:0] EXMEM_RD2,
    input [31:0] m_DMout,
    input EXMEM_BD,
    input [4:0] EXMEM_ExcCode,
    input [5:0] HWInt,
    output m_RegWrite,
    output [31:0] m_PC,
    output [31:0] m_Instr,
    output [3:0] m_Byte_en,
    output Req_out,
    output [31:0] EPC,
    output [31:0] WData, 
    output [31:0] m_Mout,
    output [1:0] M_Tnew,
    output [4:0] m_WriteReg
    );
    wire [2:0] m_Stage = `M_stage;
    wire [2:0] m_WBreg, m_DEOp;
    wire Req, m_Exc_AdES, m_Exc_AdEL, m_CP0_en, m_isEret;
    wire [4:0] m_ExcCode;
    wire [31:0] m_DEout, M_MF_rt, m_CP0out, m_EPC;

    Controller m_control(
        .Instr(EXMEM_Instr),
        .Stage(m_Stage),
        .WBreg(m_WBreg),
        .RegWrite(m_RegWrite),
        .DEOp(m_DEOp),
        .CP0_en(m_CP0_en),
        .isEret(m_isEret),
        .M_Tnew(M_Tnew)
    );
    M_BE m_be(
        .BEaddr(EXMEM_Eout),
        .Instr(EXMEM_Instr),
        .Req(Req),
        .BEdata(M_MF_rt),
        .Exc_AdES(m_Exc_AdES),
        .Byte_en(m_Byte_en),
        .WData(WData)
    );
    M_DE m_de(
        .DEaddr(EXMEM_Eout),
        .DEOp(m_DEOp),
        .DEin(m_DMout),
        .Exc_AdEL(m_Exc_AdEL),
        .DEout(m_DEout)
    );
    CP0 cp0(
        .clk(clk),
        .reset(reset),
        .en(m_CP0_en),
        .CP0addr(EXMEM_Instr[15:11]),
        .CP0in(M_MF_rt),
        .VPC(EXMEM_PC),
        .BDin(EXMEM_BD),
        .ExcCodeIn(m_ExcCode),
        .HWInt(HWInt),
        .EXLclr(m_isEret),
        .CP0out(m_CP0out),
        .EPCout(m_EPC),
        .Req(Req)
    );

    //Forward
    assign M_MF_rt = (Forward_rt_M == 2'b01) ? MEMWB_Mout :
                     EXMEM_RD2;
    assign EPC = (Forward_EPC_M == 2'b01) ? M_MF_rt :
                 m_EPC;

    assign Req_out = Req;
    assign m_PC = EXMEM_PC;
    assign m_Instr = EXMEM_Instr;
    assign m_Mout = (m_WBreg == `grfWD_DMout) ? m_DEout :
                    (m_WBreg == `grfWD_CP0) ? m_CP0out :
                    EXMEM_Eout;
    assign m_WriteReg = EXMEM_WriteReg;

    assign m_ExcCode = (EXMEM_ExcCode != `code_None) ? EXMEM_ExcCode :
                       m_Exc_AdEL ? `code_AdEL :
                       m_Exc_AdES ? `code_AdES :
                       `code_None;


endmodule