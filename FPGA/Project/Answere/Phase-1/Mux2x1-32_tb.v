`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Engineer:		Maryam Saeedmehr
//
// Create Date:   10:55:44 07/20/2020
// Design Name:   Multiplexor2x1_32
// Module Name:   ./Mux2x1_32_tb.v
// Project Name:  MIPS
// Target Device: xc6slx9-3tqg144
// Description:   Verilog Test Fixture for module: Mux2x1_32
// Revision:		0.01 - File Created
////////////////////////////////////////////////////////////////////////////////

module Mux2x1_32_tb;

	// Inputs
	reg [31:0] DataIn1;
	reg [31:0] DataIn2;
	reg Select;

	// Outputs
	wire [31:0] DataOut;
	
	// Variables
	integer i;

	// Instantiate the Unit Under Test (UUT)
	Mux2x1_32 uut (
		.DataIn1(DataIn1), 
		.DataIn2(DataIn2), 
		.Select(Select), 
		.DataOut(DataOut)
	);

	initial begin
		// Initialize Inputs
		DataIn1 = 0;
		DataIn2 = 0;
		Select = 0;
		
      for( i = 0 ; i < 10 ; i = i + 1 )
		begin 
			#20
			DataIn1 = $random();
			#1
			DataIn2 = $random();
			#1
			Select = $random();
			#1
			$display("%t ns: Input 1=%h , Input 2=%h , Select=%s ==> Output=%h | Module works %s",$time,DataIn1,DataIn2,Select?"Input 2":"Input 1",DataOut,Select?(DataOut==DataIn2?"Correctly":"Incorrectly"):(DataOut==DataIn1?"Correctly":"Incorrectly")); 
		end

	end
      
endmodule

