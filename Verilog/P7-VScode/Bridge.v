`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:17:46 12/12/2023 
// Design Name: 
// Module Name:    Bridge 
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

module Bridge(
    input [31:0] m_data_addr,    // DM读写地址
    input [31:0] m_data_rdata,   // DM 读取数据   
    input [3:0] cpu_m_data_byteen,  // DM字节使能信号
    input [31:0] TC0_Dout,
    input [31:0] TC1_Dout,
    output [3:0] m_data_byteen,
    output TC0_WE,
    output TC1_WE,
    output [3:0] m_int_byteen,   // 中断发生器字节使能信号
    output [31:0] cpu_m_data_rdata
    );

    assign m_data_byteen = (m_data_addr >= `DM_lowest && m_data_addr <= `DM_highest) ? cpu_m_data_byteen  : 4'b0000;
    assign TC0_WE = (m_data_addr >= `TC0_lowest && m_data_addr <= `TC0_highest) ? |cpu_m_data_byteen : 1'b0;
    assign TC1_WE = (m_data_addr >= `TC1_lowest && m_data_addr <= `TC1_highest) ? |cpu_m_data_byteen : 1'b0;
    assign m_int_byteen = (m_data_addr >= `Inter_lowest && m_data_addr <= `Inter_highest) ? cpu_m_data_byteen  : 4'b0000;
    assign cpu_m_data_rdata = (m_data_addr >= `DM_lowest && m_data_addr <= `DM_highest) ? m_data_rdata :
                          (m_data_addr >= `TC0_lowest && m_data_addr <= `TC0_highest) ? TC0_Dout :
                          (m_data_addr >= `TC1_lowest && m_data_addr <= `TC1_highest) ? TC1_Dout :
                          0;


endmodule
