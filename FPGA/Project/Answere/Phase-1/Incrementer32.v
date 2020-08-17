`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer:		 Maryam Saeedmehr
//
// Create Date:    10:46:19 07/20/2020 
// Design Name: 	 Incrementer-32-bit
// Module Name:    Incrementer32 
// Project Name: 	 MIPS
// Target Devices: xc6slx9-3tqg144
// Description: 	 A module to increment input by 1
//
// Revision:		 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module Incrementer32(
    input [31:0] DataIn,
    output [31:0] DataOut
    );

	assign DataOut = DataIn + 1;

endmodule
