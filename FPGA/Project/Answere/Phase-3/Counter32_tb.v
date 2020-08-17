`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Engineer:		Maryam Saeedmehr
//
// Create Date:   10:55:44 07/20/2020
// Design Name:   Counter 32bit
// Module Name:   ./Counter32_tb.v
// Project Name:  MIPS
// Target Device: xc6slx9-3tqg144
// Description:   Verilog Test Fixture for module: Counter32
// Revision:		0.01 - File Created
////////////////////////////////////////////////////////////////////////////////

module Counter32_tb;

	// Inputs
	reg clk = 0;

	// Outputs
	wire NewClk;

	// Instantiate the Unit Under Test (UUT)
	Counter32 uut (
		.clk(clk), 
		.NewClk(NewClk)
	);

	// Generating Clock 50MHz
	always #10 clk = ~clk;
      
endmodule

