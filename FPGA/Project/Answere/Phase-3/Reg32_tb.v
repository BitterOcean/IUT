`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Engineer:		Maryam Saeedmehr
//
// Create Date:   10:55:44 07/20/2020
// Design Name:   Reg32
// Module Name:   ./Reg32_tb.v
// Project Name:  MIPS
// Target Device: xc6slx9-3tqg144
// Description:   Verilog Test Fixture for module: Reg32
// Revision:		0.01 - File Created
////////////////////////////////////////////////////////////////////////////////

module Reg32_tb;

	// Inputs
	reg clk = 0;
	reg [31:0] DataIn;

	// Outputs
	wire [31:0] DataOut;

	// Instantiate the Unit Under Test (UUT)
	Reg32 uut (
		.clk(clk), 
		.DataIn(DataIn), 
		.DataOut(DataOut)
	);

	// Generating Clock 50MHz
	always #10 clk = ~clk;
	
	initial begin
		$display("Clock Period: 20ns");
		$display("Clock Frequency: 50MHz");
		$monitor("%t ns: Output is modified now. New value=%h",$time,DataOut);
		#51
		DataIn = $random(510);
		$display("%t ns: Input is modified now. New value=%h",$time,DataIn);
		#23
		DataIn = $random(230);
		$display("%t ns: Input is modified now. New value=%h",$time,DataIn);
	end
      
endmodule

