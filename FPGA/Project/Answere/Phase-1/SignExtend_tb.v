`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Engineer:		Maryam Saeedmehr
//
// Create Date:   10:55:44 07/20/2020
// Design Name:   SignExtend-16to32bit
// Module Name:   ./SignExtend_tb.v
// Project Name:  MIPS
// Target Device: xc6slx9-3tqg144
// Description:   Verilog Test Fixture for module: SignExtend
// Revision:		0.01 - File Created
////////////////////////////////////////////////////////////////////////////////

module SignExtend_tb;

	// Inputs
	reg [15:0] DataIn;
	reg clk = 0;

	// Outputs
	wire [31:0] DataOut;

	// Instantiate the Unit Under Test (UUT)
	SignExtend uut (
		.DataIn(DataIn), 
		.clk(clk), 
		.DataOut(DataOut)
	);

	// Generating Clock 50MHz
	always #10 clk = ~clk;

	initial begin
		DataIn = 16'b0000_0000_0000_0011;
		#10
		$write("Input : %b => Output : ",DataIn);
		$monitor("%b",DataOut);
		#30
		DataIn = 16'b1111_1111_1111_1101;
		#10
		$write("Input : %b => Output : ",DataIn);
		$monitor("%b",DataOut);
	end
      
endmodule

