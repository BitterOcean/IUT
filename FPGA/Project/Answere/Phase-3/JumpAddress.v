`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer:		 Maryam Saeedmehr
//
// Create Date:    10:46:19 07/20/2020 
// Design Name: 	 JumpAddress
// Module Name:    JumpAddress
// Project Name: 	 MIPS
// Target Devices: xc6slx9-3tqg144
// Description: 	 A module to generate Jump Address
//
// Revision:		 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module JumpAddress(
    input [25:0] Address,
    input [31:0] PC2,
    output [31:0] Jump_Address
    );

	assign Jump_Address = {PC2[31:28],Address,2'b00};
	
endmodule
