`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Engineer:		Maryam Saeedmehr
//
// Create Date:   10:55:44 07/20/2020
// Design Name:   MIPS Computer 32bit
// Module Name:   ./MIPS_Computer_tb.v
// Project Name:  MIPS
// Target Device: xc6slx9-3tqg144
// Description:   Verilog Test Fixture for module: MIPS_Computer
// Revision:		0.01 - File Created
////////////////////////////////////////////////////////////////////////////////

module MIPS_Computer_tb;

	// Inputs
	reg clk = 0;

	// Instantiate the Unit Under Test (UUT)
	MIPS_Computer uut (
		.clk(clk)
	);

	// Generating Clock 50MHz
	always #10 clk = ~clk;

endmodule

