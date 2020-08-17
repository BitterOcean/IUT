`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:55:26 10/26/2016 
// Design Name: 
// Module Name:    ALU_control 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
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
		if(inst == 6'b100000)
		begin
		op = 4'b0010 ;
		end
		if(inst == 6'b011000)
		begin
		op = 4'b0010 ;
		end
		if(inst == 6'b100010)
		begin
		op = 4'b0110 ;
		end
		if(inst == 6'b100100)
		begin 
		op = 4'b0000 ;
		end
		if(inst == 6'b100101)
		begin
		op = 4'b0001 ;
		end
		if(inst == 6'b101010)
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
	end
end


endmodule
