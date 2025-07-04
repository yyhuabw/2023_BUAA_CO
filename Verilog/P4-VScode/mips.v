`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:44:13 11/05/2023 
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
    reg [31:0] PC; // PC
    wire [31:0] PCin; // PC - 32'h0000_3000
    wire [31:0] NPC;
    wire [31:0] pc4; // PC + 4
    wire [31:0] Instr; // Instruction

    wire [1:0] RegDst;
    wire [1:0] MemtoReg;
    wire [1:0] PCSrc;
    wire [2:0] ALUOp;
    wire ALUSrc, RegWrite, MemWrite, ExtOp; // control signal

    wire [31:0] Wr;
    wire [31:0] Wd;
    wire [31:0] Rd1;
    wire [31:0] Rd2;
    wire [31:0] B;
    wire [31:0] Extout;
    wire Zero;
    wire [31:0] ALUout;
    wire [31:0] DMout; // wire


    IM IM(
        .IMaddr(PCin[13:2]),
        .IMout(Instr)
    );
    Controller Controller(
        .Op(Instr[31:26]),
        .Func(Instr[5:0]),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .PCSrc(PCSrc),
        .ExtOp(ExtOp),
        .ALUOp(ALUOp)
    );
    PCcounter PCcounter(
        .PCSrc(PCSrc),
        .Zero(Zero),
        .PC(PC),
        .instr_index(Instr[25:0]),
        .GPR_ra(Rd1),
        .NPC(NPC),
        .pc4(pc4)
    );
    GRF GRF(
        .PC(PC),
        .clk(clk),
        .reset(reset),
        .RegWrite(RegWrite),
        .ReadReg1(Instr[25:21]),
        .ReadReg2(Instr[20:16]),
        .WriteReg(Wr),
        .WriteData(Wd),
        .ReadData1(Rd1),
        .ReadData2(Rd2)
    );
    ALU ALU(
        .ALUOp(ALUOp),
        .A(Rd1),
        .B(B),
        .Zero(Zero),
        .Result(ALUout)
    );
    DM DM(
        .PC(PC),
        .clk(clk),
        .reset(reset),
        .MemWrite(MemWrite),
        .DMaddr(ALUout),
        .DMin(Rd2),
        .DMout(DMout)
    );
    Ext Ext(
        .ExtOp(ExtOp),
        .Extin(Instr[15:0]),
        .Extout(Extout)
    );

    always @(posedge clk) begin
        if (reset) begin
            PC <= 32'h0000_3000;
        end
        else begin
            PC <= NPC;
        end
    end

    assign PCin = PC - 32'h0000_3000;
    assign Wr = (RegDst == 2'b00) ? Instr[20:16] : 
                (RegDst == 2'b01) ? Instr[15:11] :
                (RegDst == 2'b10) ? 5'b11111 : 
                Instr[20:16];

    assign Wd = (MemtoReg == 2'b00) ? ALUout :
                (MemtoReg == 2'b01) ? DMout :
                (MemtoReg == 2'b10) ? pc4 :
                ALUout;

    assign B = (ALUSrc == 0) ? Rd2 : Extout;


endmodule