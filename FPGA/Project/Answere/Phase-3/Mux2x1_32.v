`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer:		 Maryam Saeedmehr
//
// Create Date:    10:46:19 07/20/2020 
// Design Name: 	 Multiplexor-32-bit
// Module Name:    Mux2x1_32 
// Project Name: 	 MIPS
// Target Devices: xc6slx9-3tqg144
// Description: 	 A module to select an input according to select pin
//
// Revision:		 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module Mux2x1_32(
    input [31:0] DataIn1,
    input [31:0] DataIn2,
    input Select,
    output [31:0] DataOut
    );

	assign DataOut = Select ? DataIn2 : DataIn1 ;

endmodule
