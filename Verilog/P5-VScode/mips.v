`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:55:26 11/19/2023 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );
    //Fetch
    wire [31:0] f_PC;
    wire [31:0] f_Instr;

    //IF_ID
    wire [31:0] IFID_PC;
    wire [31:0] IFID_Instr; 

    //Decode
    wire [31:0] d_PC;
    wire [31:0] d_Instr;
    wire [4:0] d_WriteReg;
    wire [31:0] d_Dout;
    wire [31:0] d_NPC;
    wire [31:0] d_MF_rs;
    wire [31:0] d_MF_rt;

    //ID_EX
    wire [31:0] IDEX_PC;
    wire [31:0] IDEX_Instr;
    wire [4:0] IDEX_WriteReg;
    wire [31:0] IDEX_Dout;
    wire [31:0] IDEX_RD1;
    wire [31:0] IDEX_RD2;

    //Execute
    wire e_RegWrite;
    wire [31:0] e_PC;
    wire [31:0] e_Instr;
    wire [4:0] e_WriteReg;
    wire [31:0] e_Eout;
    wire [31:0] e_RD2;

    //EX_MEM
    wire [31:0] EXMEM_PC;
    wire [31:0] EXMEM_Instr;
    wire [4:0] EXMEM_WriteReg;
    wire [31:0] EXMEM_Eout;
    wire [31:0] EXMEM_RD2;

    //Memory
    wire m_RegWrite;
    wire [31:0] m_PC;
    wire [31:0] m_Instr;
    wire [31:0] m_Mout;
    wire [4:0] m_WriteReg;

    //MEM_WB
    wire [31:0] MEMWB_PC;
    wire [31:0] MEMWB_Instr;
    wire [31:0] MEMWB_Mout;
    wire [4:0] MEMWB_WriteReg;

    //WriteBack
    wire w_RegWrite;

    //Stall
    wire Stall;
    wire not_Stall;
    //Forward
    wire [1:0] Forward_rs_D;
    wire [1:0] Forward_rt_D;
    wire [1:0] Forward_rs_E;
    wire [1:0] Forward_rt_E;
    wire [1:0] Forward_rt_M;

    Fetch fetch(
        .clk(clk),
        .reset(reset),
        .PC_en(not_Stall),
        .d_NPC(d_NPC),
        .f_PC(f_PC),
        .f_Instr(f_Instr)
    );
    IF_ID if_id(
        .clk(clk),
        .reset(reset),
        .IFID_en(not_Stall),//Stall
        .f_PC(f_PC),
        .f_Instr(f_Instr),
        .IFID_PC(IFID_PC),
        .IFID_Instr(IFID_Instr)
    );
    Decode_W decode_w(
        .clk(clk),
        .reset(reset),
        .f_PC(f_PC),
        .IFID_PC(IFID_PC),
        .IFID_Instr(IFID_Instr),
        .MEMWB_PC(MEMWB_PC),

        //Forward
        .Forward_rs_D(Forward_rs_D),//Signals
        .Forward_rt_D(Forward_rt_D),
        .IDEX_Dout(IDEX_Dout),//Data
        .EXMEM_Eout(EXMEM_Eout),
        .MEMWB_Mout(MEMWB_Mout),

        .w_RegWrite(w_RegWrite),
        .MEMWB_WriteReg(MEMWB_WriteReg),
        .d_PC(d_PC),
        .d_Instr(d_Instr),
        .d_WriteReg(d_WriteReg),
        .d_Dout(d_Dout),
        .d_NPC(d_NPC),
        .d_MF_rs(d_MF_rs),
        .d_MF_rt(d_MF_rt)
    );
    ID_EX id_ex(
        .clk(clk),
        .reset(reset),
        .IDEX_clear(Stall),//Stall
        .d_PC(d_PC),
        .d_Instr(d_Instr),
        .d_WriteReg(d_WriteReg),
        .d_Dout(d_Dout),
        .d_MF_rs(d_MF_rs),
        .d_MF_rt(d_MF_rt),
        .IDEX_PC(IDEX_PC),
        .IDEX_Instr(IDEX_Instr),
        .IDEX_WriteReg(IDEX_WriteReg),
        .IDEX_Dout(IDEX_Dout),
        .IDEX_RD1(IDEX_RD1),
        .IDEX_RD2(IDEX_RD2)
    );
    Execute execute(
        .IDEX_PC(IDEX_PC),
        .IDEX_Instr(IDEX_Instr),

        //Forward
        .Forward_rs_E(Forward_rs_E),//Signals
        .Forward_rt_E(Forward_rt_E),
        .EXMEM_Eout(EXMEM_Eout),//Data
        .MEMWB_Mout(MEMWB_Mout),

        .IDEX_WriteReg(IDEX_WriteReg),
        .IDEX_Dout(IDEX_Dout),
        .IDEX_RD1(IDEX_RD1),
        .IDEX_RD2(IDEX_RD2),
        .e_RegWrite(e_RegWrite),
        .e_PC(e_PC),
        .e_Instr(e_Instr),
        .e_WriteReg(e_WriteReg),
        .e_Eout(e_Eout),
        .e_RD2(e_RD2)
    );
    EX_MEM ex_mem(
        .clk(clk),
        .reset(reset),
        .e_PC(e_PC),
        .e_Instr(e_Instr),
        .e_WriteReg(e_WriteReg),
        .e_Eout(e_Eout),
        .e_RD2(e_RD2),
        .EXMEM_PC(EXMEM_PC),
        .EXMEM_Instr(EXMEM_Instr),
        .EXMEM_WriteReg(EXMEM_WriteReg),
        .EXMEM_Eout(EXMEM_Eout),
        .EXMEM_RD2(EXMEM_RD2)
    );
    Memory memory(
        .clk(clk),
        .reset(reset),
        .EXMEM_PC(EXMEM_PC),
        .EXMEM_Instr(EXMEM_Instr),

        //Forward
        .Forward_rt_M(Forward_rt_M),//Signals
        .MEMWB_Mout(MEMWB_Mout),//Data

        .EXMEM_WriteReg(EXMEM_WriteReg),
        .EXMEM_Eout(EXMEM_Eout),
        .EXMEM_RD2(EXMEM_RD2),
        .m_RegWrite(m_RegWrite),
        .m_PC(m_PC),
        .m_Instr(m_Instr),
        .m_Mout(m_Mout),
        .m_WriteReg(m_WriteReg)
    );
    MEM_WB mem_wb(
        .clk(clk),
        .reset(reset),
        .m_PC(m_PC),
        .m_Instr(m_Instr),
        .m_Mout(m_Mout),
        .m_WriteReg(m_WriteReg),
        .MEMWB_PC(MEMWB_PC),
        .MEMWB_Instr(MEMWB_Instr),
        .MEMWB_Mout(MEMWB_Mout),
        .MEMWB_WriteReg(MEMWB_WriteReg)
    );

    //WriteBack
    Controller w_control(
        .Instr(MEMWB_Instr),
        .RegWrite(w_RegWrite)
    );

    Hazard hazard(
        //Instr
        .D_Instr(d_Instr),
        .E_Instr(e_Instr),
        .M_Instr(m_Instr),
        .W_Instr(MEMWB_Instr),

        //WriteReg
        .E_WriteReg(e_WriteReg),
        .M_WriteReg(m_WriteReg),
        .W_WriteReg(MEMWB_WriteReg),

        //Control Signals
        .E_RegWrite(e_RegWrite),
        .M_RegWrite(m_RegWrite),
        .W_RegWrite(w_RegWrite),

        //Stall Signals
        .Stall(Stall),

        //Forwasrd Signals
        .Forward_rs_D(Forward_rs_D),
        .Forward_rt_D(Forward_rt_D),
        .Forward_rs_E(Forward_rs_E),
        .Forward_rt_E(Forward_rt_E),
        .Forward_rt_M(Forward_rt_M)
    );

    assign not_Stall = !Stall;


endmodule