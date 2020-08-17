`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer:		 Maryam Saeedmehr
//
// Create Date:    10:46:19 07/20/2020 
// Design Name: 	 Adder 32bit
// Module Name:    Add32
// Project Name: 	 MIPS
// Target Devices: xc6slx9-3tqg144
// Description: 	 A 32 bit Adder.
//
// Revision:		 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module Add32(
    input [31:0] DataIn1,
    input [31:0] DataIn2,
    output [31:0] DataOut
    );

	assign DataOut = DataIn1 + DataIn2;
	
endmodule
