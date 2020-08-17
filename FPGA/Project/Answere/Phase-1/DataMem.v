`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer:		 Maryam Saeedmehr
//
// Create Date:    10:46:19 07/20/2020 
// Design Name: 	 DataMemory-128x32-bit
// Module Name:    DataMem
// Project Name: 	 MIPS
// Target Devices: xc6slx9-3tqg144
// Description: 	 A module to store data and variables of a program
//
// Revision:		 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module DataMem(
    input [6:0] Address,
    input [31:0] WriteData,
	 input MemWrite,
    input MemRead,
    input clk,
    output [31:0] ReadData
    );
	reg [31:0] RAM [0:127]; 
	integer i;
	
	initial 
	begin  
		for( i = 0 ; i < 128 ; i = i + 1 )  
			RAM[i] <= 32'd0;  
		
		RAM[13] <= 32'd3;
   end  
		
	always @(posedge clk) 
	begin  
		if(MemWrite)  
			RAM[Address] <= WriteData;  
	end  
	assign ReadData = (MemRead==1'b1) ? RAM[Address]: 32'd0;

endmodule
