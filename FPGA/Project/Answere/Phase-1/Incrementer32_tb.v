`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Engineer:		Maryam Saeedmehr
//
// Create Date:   10:55:44 07/20/2020
// Design Name:   Incrementer32
// Module Name:   ./Incrementer32_tb.v
// Project Name:  MIPS
// Target Device: xc6slx9-3tqg144
// Description:   Verilog Test Fixture for module: Incrementer32
// Revision:		0.01 - File Created
////////////////////////////////////////////////////////////////////////////////

module Incrementer32_tb;

	// Inputs
	reg [31:0] DataIn;

	// Outputs
	wire [31:0] DataOut;

	// Instantiate the Unit Under Test (UUT)
	Incrementer32 uut (
		.DataIn(DataIn), 
		.DataOut(DataOut)
	);

	initial begin
		$monitor("%t ns: Output is modified now. New value is %h",$time,DataOut);
		DataIn = 0;
		$display("%t ns: Input is modified now. New value is %h",$time,DataIn);
		#50
		DataIn = $random();
		$display("%t ns: Input is modified now. New value is %h",$time,DataIn);
	end
      
endmodule

