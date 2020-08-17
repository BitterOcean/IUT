`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Engineer:		Maryam Saeedmehr
//
// Create Date:   10:55:44 07/20/2020
// Design Name:   Adder 32 bit
// Module Name:   ./Add32_tb.v
// Project Name:  MIPS
// Target Device: xc6slx9-3tqg144
// Description:   Verilog Test Fixture for module: Add32
// Revision:		0.01 - File Created
////////////////////////////////////////////////////////////////////////////////

module Add32_tb;

	// Inputs
	reg [31:0] DataIn1;
	reg [31:0] DataIn2;

	// Outputs
	wire [31:0] DataOut;

	// Instantiate the Unit Under Test (UUT)
	Add32 uut (
		.DataIn1(DataIn1), 
		.DataIn2(DataIn2), 
		.DataOut(DataOut)
	);

	initial begin
		// Initialize Inputs
		DataIn1 = 0;
		DataIn2 = 0;
		#100
		$monitor("%t ns: Output is modified now. New value is %h",$time,DataOut);
		DataIn1 = 4;
		DataIn2 = 2;
		$display("%t ns: Input is modified now. New value is %h + %h",$time,DataIn1,DataIn2);
		#50
		DataIn1 = $random();
		DataIn2 = $random();
		$display("%t ns: Input is modified now. New value is %h + %h",$time,DataIn1,DataIn2);

	end
      
endmodule

