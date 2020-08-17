`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Engineer:		Maryam Saeedmehr
//
// Create Date:   10:55:44 07/20/2020
// Design Name:   DataMemory-128x32-bit
// Module Name:   ./DataMem_tb.v
// Project Name:  MIPS
// Target Device: xc6slx9-3tqg144
// Description:   Verilog Test Fixture for module: DataMem
// Revision:		0.01 - File Created
////////////////////////////////////////////////////////////////////////////////

module DataMem_tb;

	// Inputs
	reg [6:0] Address;
	reg [31:0] WriteData;
	reg MemWrite;
	reg MemRead;
	reg clk = 0;

	// Outputs
	wire [31:0] ReadData;

	// Instantiate the Unit Under Test (UUT)
	DataMem uut (
		.Address(Address), 
		.WriteData(WriteData), 
		.MemWrite(MemWrite), 
		.MemRead(MemRead), 
		.clk(clk), 
		.ReadData(ReadData)
	);
	
	// Generating Clock 50MHz
	always #10 clk = ~clk;

	initial begin
		// Initialize Inputs
		Address = 0;
		WriteData = 0;
		MemWrite = 0;
		MemRead = 0;
		#100
		Address = $random();
		WriteData = $random(50);
		MemWrite = 1;
		#70
		MemWrite = 0;
		#10
		$display("Write  on @%h => %d ",Address,WriteData);
		#20
		MemRead = 1;
		#10
		$display("Read from @%h => %d",Address,ReadData);
		#10
		MemRead = 0;
	end
      
endmodule

