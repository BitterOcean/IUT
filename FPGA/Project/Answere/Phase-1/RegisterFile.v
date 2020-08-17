`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer:		 Maryam Saeedmehr
//
// Create Date:    10:46:19 07/20/2020 
// Design Name: 	 RegisterFile-32x32bit
// Module Name:    RegisterFile
// Project Name: 	 MIPS
// Target Devices: xc6slx9-3tqg144
// Description: 	 A Registe File contains 32 32-bit-registers 
//
// Revision:		 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module RegisterFile(
    input [4:0] ReadReg1,
    input [4:0] ReadReg2,
    input [4:0] WriteReg,
    input [31:0] WriteData,
    input RegWrite,
	 input clk,
    output [31:0] ReadData1,
    output [31:0] ReadData2
    );
	reg [31:0] RegisterBank [31:0];
	
	always @(posedge clk)
	begin
		if(RegWrite) 
			RegisterBank[WriteReg] <= WriteData;
	end
	
	assign ReadData1 = ( ReadReg1 == 0)? 32'b0 : RegisterBank[ReadReg1];  
	assign ReadData2 = ( ReadReg2 == 0)? 32'b0 : RegisterBank[ReadReg2];  

endmodule
