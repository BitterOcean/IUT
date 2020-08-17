`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer:		 Maryam Saeedmehr
//
// Create Date:    10:46:19 07/20/2020 
// Design Name: 	 JRControl
// Module Name:    JRControl
// Project Name: 	 MIPS
// Target Devices: xc6slx9-3tqg144
// Description: 	 A module to Control Jump,Jal,J operations
//
// Revision:		 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module JR_Control(
    input [1:0] ALU_op,
    input [3:0] Func,
    output JRControl
    );

	assign JRControl = ({ALU_op,Funct}==6'b001000) ? 1'b1 : 1'b0;

endmodule
