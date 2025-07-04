`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:44:00 12/07/2023 
// Design Name: 
// Module Name:    M_DE 
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

module M_DE(
    input [31:0] DEaddr,
    input [2:0] DEOp,
    input [31:0] DEin,
    output Exc_AdEL,
    output reg [31:0] DEout
    );
    wire Exc_Align, Exc_OutOfRange, Exc_TC;

    always @(*) begin
        case (DEOp)
            `de_Lw: begin
                DEout = DEin;
            end
            `de_Lh: begin
                case (DEaddr[1])
                    1'b0: begin
                        DEout = {{16{DEin[15]}}, DEin[15:0]};
                    end
                    1'b1: begin
                        DEout = {{16{DEin[31]}}, DEin[31:16]};
                    end 
                endcase
            end
            `de_Lb: begin
                case (DEaddr[1:0])
                    2'b00: begin
                        DEout = {{24{DEin[7]}}, DEin[7:0]};
                    end
                    2'b01: begin
                        DEout = {{24{DEin[15]}}, DEin[15:8]};
                    end
                    2'b10: begin
                        DEout = {{24{DEin[23]}}, DEin[23:16]};
                    end
                    2'b11: begin
                        DEout = {{24{DEin[31]}}, DEin[31:24]};
                    end
                endcase
            end  
            default: begin
                DEout = 0;
            end
        endcase
    end

    assign Exc_Align = ((DEOp == `de_Lw) && (|DEaddr[1:0])) || 
                       ((DEOp == `de_Lh) && DEaddr[0]);
    assign Exc_OutOfRange = !((DEaddr >= `DM_lowest && DEaddr <= `DM_highest) ||
                             (DEaddr >= `TC0_lowest && DEaddr <= `TC0_highest) ||
                             (DEaddr >= `TC1_lowest && DEaddr <= `TC1_highest) ||
                             (DEaddr >= `Inter_lowest && DEaddr <= `Inter_highest));
    assign Exc_TC = ((DEOp == `de_Lh || DEOp == `de_Lb) && DEaddr >= `TC0_lowest && DEaddr <= `TC1_highest);
    assign Exc_AdEL = (DEOp == `de_Lw || DEOp == `de_Lh || DEOp == `de_Lb) && (Exc_Align || Exc_OutOfRange || Exc_TC);


endmodule
