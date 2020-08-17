`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Engineer:		Maryam Saeedmehr
//
// Create Date:   10:55:44 07/20/2020
// Design Name:   ArithmeticLogicUnit-32-bit
// Module Name:   ./ALU32_tb.v
// Project Name:  MIPS
// Target Device: xc6slx9-3tqg144
// Description:   Verilog Test Fixture for module: ALU32
// Revision:		0.01 - File Created
////////////////////////////////////////////////////////////////////////////////

module ALU32_tb;

	// Inputs
	reg [31:0] DataIn1;
	reg [31:0] DataIn2;
	reg [3:0] Operation;
	reg clk = 0;

	// Outputs
	wire [31:0] Result;
	wire Zero;
	
	// Variable 
	integer i;

	// Instantiate the Unit Under Test (UUT)
	ALU32 uut (
		.DataIn1(DataIn1), 
		.DataIn2(DataIn2), 
		.Operation(Operation), 
		.clk(clk), 
		.Result(Result), 
		.Zero(Zero)
	);

	// Generating Clock 50MHz
	always #10 clk = ~clk;

	initial begin
		DataIn1 = $random();
		DataIn2 = $random();
		#1
		$display("Input 1:%h , Input 2:%h => Zero:%s",DataIn1,DataIn2,Zero?"Same Inputs":"Different Inputs");
		for( i = 0 ; i < 32 ; i = i + 1 )
		begin
			Operation = i;
			#20
			$write("#%d : Operation:%s => ",i,Operation==0?"AND":(Operation==1?"OR":(Operation==2?"ADD":(Operation==6?"SUBTRACT":(Operation==7?"SET ON LESS THAN":(Operation==12?"NOR":"NO OPERATION"))))));
			$display("Result:%h",Result);
		end
		Operation = 6;
		#1
		DataIn1 = DataIn2;
		#1
		$display("Input 1:%h , Input 2:%h => Zero:%s",DataIn1,DataIn2,Zero?"Same Inputs":"Different Inputs");
		#10
		$write("#%d : Operation:%s => ",i,Operation==0?"AND":(Operation==1?"OR":(Operation==2?"ADD":(Operation==6?"SUBTRACT":(Operation==7?"SET ON LESS THAN":(Operation==12?"NOR":"NO OPERATION"))))));
		$display("Result:%h",Result);
	end
      
endmodule

