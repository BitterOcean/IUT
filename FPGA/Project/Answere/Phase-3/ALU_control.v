`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer:		 TA
//
// Create Date:    10:46:19 07/20/2020 
// Design Name: 	 ALU_control
// Module Name:    ALU_control
// Project Name: 	 MIPS
// Target Devices: xc6slx9-3tqg144
// Description: 	 A module to Control the ALU
//
// Revision:		 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module ALU_control(
input [1:0]ALU_op,
input [5:0]inst,
output reg [3:0]op
 );
 
always @(*)
begin
	if(ALU_op == 2'b00)
	begin
	op = 4'b0010 ;
	end
	else if(ALU_op == 2'b01)
	begin
	op = 4'b0110 ;
	end
	else if(ALU_op == 2'b10)
	begin
		if(inst == 6'b100000)//add
		begin
		op = 4'b0010 ;
		end
		if(inst == 6'b011000)//mult
		begin
		op = 4'b0010 ;
		end
		if(inst == 6'b100010)//sub
		begin
		op = 4'b0110 ;
		end
		if(inst == 6'b100100)//and
		begin 
		op = 4'b0000 ;
		end
		if(inst == 6'b100101)//or
		begin
		op = 4'b0001 ;
		end
		if(inst == 6'b101010)//slt
		begin
		op = 4'b0111 ;
		end
		if(inst == 6'b001100)//andi
		begin
		op = 4'b0000 ;
		end
		if(inst == 6'b001101)//ori
		begin
		op = 4'b0001 ;
		end
		if(inst == 6'b001000)//jr
		begin
		op = 4'b0010;
		end
	end
end


endmodule
