`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer:		 Maryam Saeedmehr
//
// Create Date:    10:46:19 07/20/2020 
// Design Name: 	 SignExtend-16to32bit
// Module Name:    SignExtend
// Project Name: 	 MIPS
// Target Devices: xc6slx9-3tqg144
// Description: 	 A module to sign extend the 15bit input to 32bit output
//
// Revision:		 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module SignExtend(
    input [15:0] DataIn,
	 input clk,
    output reg [31:0] DataOut
    );

	always @( posedge clk ) 
	begin
		 DataOut[31:0] <= { {16{DataIn[15]}}, DataIn[15:0] };
	end

endmodule
