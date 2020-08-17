`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer:		 Maryam Saeedmehr
//
// Create Date:    10:46:19 07/20/2020 
// Design Name: 	 Counter-32-bit
// Module Name:    Counter32 
// Project Name: 	 MIPS
// Target Devices: xc6slx9-3tqg144
// Description: 	 A module to increment input by 1
//
// Revision:		 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module Counter32(
    input clk,
    output NewClk
    );
   reg [1:0] DataOut = 0;
   always @(posedge clk)
      DataOut <= DataOut + 2'b01;
	assign NewClk = (DataOut==2'b10) ? 1'b1 : 1'b0;

endmodule
