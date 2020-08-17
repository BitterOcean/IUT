`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer:		 Maryam Saeedmehr
//
// Create Date:    10:46:19 07/20/2020 
// Design Name: 	 InstructionMemory-32x32-bit
// Module Name:    InstructionMem
// Project Name: 	 MIPS
// Target Devices: xc6slx9-3tqg144
// Description: 	 A module to store Instruction codes of a program
//
// Revision:		 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module InstructionMem(
    input [4:0] Address,
    output [31:0] Instruction
    );
	reg [31:0] ROM [31:0];
	
	initial  
	begin  
		$readmemb("instruction.mem",ROM,0,4);
	end  
	
	assign Instruction = ROM[Address];

endmodule
