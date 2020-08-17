`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer:		 Maryam Saeedmehr
//
// Create Date:    10:46:19 07/20/2020 
// Design Name: 	 Register-32-bit
// Module Name:    Reg32 
// Project Name: 	 MIPS
// Target Devices: xc6slx9-3tqg144
// Description: 	 A reg to latch the input with posedge clock 
//						 known as "Program Counter" (PC)
// Revision:		 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module Reg32(
	input clk,
	input [31:0] DataIn,
	output reg [31:0] DataOut
    );

	always @(posedge clk)
	begin 
		DataOut <= DataIn;
		if( DataIn === 'bx )
			DataOut <= 0;
	end
endmodule
