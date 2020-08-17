`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer:		 Maryam Saeedmehr
//
// Create Date:    10:46:19 07/20/2020 
// Design Name: 	 JR_Controler
// Module Name:    JR_Controler
// Project Name: 	 MIPS
// Target Devices: xc6slx9-3tqg144
// Description: 	 A module to Control whether to jump to a register or not
//
// Revision:		 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module JR_Controler(
    input [5:0] OP_Code,
    input [5:0] Func,
    output JRControl
    );

	assign JRControl = ({OP_Code,Func}==12'b000000_001000)?1'b1:1'b0;
	
endmodule
