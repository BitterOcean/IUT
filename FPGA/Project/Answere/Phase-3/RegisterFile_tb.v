`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer:		 Maryam Saeedmehr
//
// Create Date:    10:46:19 07/20/2020 
// Design Name: 	 RegisterFile-32x32-bit
// Module Name:    RegisterFile
// Project Name: 	 MIPS
// Target Devices: xc6slx9-3tqg144
// Description: 	 A Register File contains 32 32-bit-registers
//
// Revision:		 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module RegisterFile_tb;

	// Inputs
	reg [4:0] ReadReg1;
	reg [4:0] ReadReg2;
	reg [4:0] WriteReg;
	reg [31:0] WriteData;
	reg RegWrite;
	reg clk = 0;

	// Outputs
	wire [31:0] ReadData1;
	wire [31:0] ReadData2;

	// Instantiate the Unit Under Test (UUT)
	RegisterFile uut (
		.ReadReg1(ReadReg1), 
		.ReadReg2(ReadReg2), 
		.WriteReg(WriteReg), 
		.WriteData(WriteData), 
		.RegWrite(RegWrite), 
		.clk(clk), 
		.ReadData1(ReadData1), 
		.ReadData2(ReadData2)
	);
	
	// Generating Clock 50MHz
	always #10 clk = ~clk;

	initial begin
		// Initialize Inputs
		ReadReg1 = 0;
		ReadReg2 = 0;
		WriteReg = 0;
		WriteData = 0;
		RegWrite = 0;
		#100
		WriteReg = 10;
		WriteData = 10;
		RegWrite = 1;
		#50
		RegWrite = 0;
		$display("Write  on @%h => %d ",WriteReg,WriteData);
		WriteReg = 12;
		WriteData = 12;
		#10
		RegWrite = 1;
		#70
		RegWrite = 0;
		$display("Write  on @%h => %d ",WriteReg,WriteData);
		#20
		ReadReg1 = 10;
		#5
		$display("Read from @%h => %d",ReadReg1,ReadData1);
		#20
		ReadReg2 = 12;
		#5
		$display("Read from @%h => %d",ReadReg2,ReadData2);
	end
      
endmodule

