`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer:		 Maryam Saeedmehr
//
// Create Date:    10:46:19 07/20/2020 
// Design Name: 	 ArithmeticLogicUnit-32-bit
// Module Name:    ALU_32 
// Project Name: 	 MIPS
// Target Devices: xc6slx9-3tqg144
// Description: 	 A module to calculate some Arithmetic operations on Inputs
//
// Revision:		 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module ALU32(
    input [31:0] DataIn1,
    input [31:0] DataIn2,
    input [3:0] Operation,
	 input clk,
    output reg [31:0] Result,
    output Zero
    );
	 
	always @(posedge clk)
	begin
		case(Operation)
			4'b0000: Result <= DataIn1 & DataIn2;// And
			4'b0001: Result <= DataIn1 | DataIn2;// OR
			4'b0010: Result <= DataIn1 + DataIn2;// ADD
			4'b0110: Result <= DataIn1 - DataIn2;// SUBTRACT
			4'b0111: Result <= (DataIn1 < DataIn2)? DataIn1 : DataIn2;// SET ON LESS THAN
			4'b1100: Result <= ~(DataIn1 | DataIn2);// NOR
			default: Result <= 32'bx;// OTHERWISE
		endcase
	end
	
	assign Zero = DataIn1 == DataIn2;

endmodule
