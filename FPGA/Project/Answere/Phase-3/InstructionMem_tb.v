`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Engineer:		Maryam Saeedmehr
//
// Create Date:   10:55:44 07/20/2020
// Design Name:   InstructionMemory-128x32-bit
// Module Name:   ./InstructionMem_tb.v
// Project Name:  MIPS
// Target Device: xc6slx9-3tqg144
// Description:   Verilog Test Fixture for module: InstructionMem
// Revision:		0.01 - File Created
////////////////////////////////////////////////////////////////////////////////

module InstructionMem_tb;

	// Inputs
	reg [4:0] Address;

	// Outputs
	wire [31:0] Instruction;

	// Instantiate the Unit Under Test (UUT)
	InstructionMem uut (
		.Address(Address), 
		.Instruction(Instruction)
	);

	initial begin
		// Initialize Inputs
		Address = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		Address = 1;
		#10
		$display("Read from @%h => %b",Address,Instruction);

	end
      
endmodule

