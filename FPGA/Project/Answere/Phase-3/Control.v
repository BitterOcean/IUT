`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer:		 TA
//	Edited by :		 Maryam Saeedmehr
//
// Create Date:    10:46:19 07/20/2020 
// Design Name: 	 Control
// Module Name:    Control
// Project Name: 	 MIPS
// Target Devices: xc6slx9-3tqg144
// Description: 	 A module to Control the whole computer
//
// Revision:		 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module Control(
    input [5:0] inst_in,
    output reg RegDst,
	 output reg Jump,//New Output port
	 output reg Link,//New Output port
	 output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUop,
    output reg MemWrite,
    output reg ALUsrc,		
    output reg RegWrite
    );
	 
always @(*)
begin
   if(inst_in == 6'b000000)//R_type
	begin
	RegDst = 1;
	Jump = 0;
	Link = 0;
	ALUsrc = 0;
	MemtoReg = 0;
	RegWrite = 1;
	MemRead = 0;
	MemWrite = 0;
	Branch = 0;
	ALUop[1] = 1;
	ALUop[0] = 0;
	end
	
	////////////////////////////////New Parts
	
	else if(inst_in == 6'b000010)//jump
	begin
	RegDst = 0;
	Jump = 1;
	Link = 0;
	ALUsrc = 0;
	MemtoReg = 0;
	RegWrite = 0;
	MemRead = 0;
	MemWrite = 0;
	Branch = 0;
	ALUop[1] = 0;
	ALUop[0] = 0;
	end
	
	else if(inst_in == 6'b000011)//jal
	begin
	RegDst = 0;
	Jump = 1;
	Link = 1;
	ALUsrc = 0;
	MemtoReg = 0;
	RegWrite = 1;
	MemRead = 0;
	MemWrite = 0;
	Branch = 0;
	ALUop[1] = 0;
	ALUop[0] = 0;
	end
	
	////////////////////////////////New Parts
	
	else if(inst_in == 6'b100011)//load
	begin
	RegDst = 0;
	Jump = 0;
	Link = 0;
	ALUsrc = 1;
	MemtoReg = 1;
	RegWrite = 1;
	MemRead = 1;
	MemWrite = 0;
	Branch = 0;
	ALUop[1] = 0;
	ALUop[0] = 0;
	end
	
	else if(inst_in == 6'b001000)//addi
	begin
	RegDst = 0;
	Jump = 0;
	Link = 0;
	ALUsrc = 1;
	MemtoReg = 0;
	RegWrite = 1;
	MemRead = 1;
	MemWrite = 0;
	Branch = 0;
	ALUop[1] = 0;
	ALUop[0] = 0;
	end
	
	else if(inst_in == 6'b001100)//andi
	begin
	RegDst = 0;
	Jump = 0;
	Link = 0;
	ALUsrc = 1;
	MemtoReg = 0;
	RegWrite = 1;
	MemRead = 1;
	MemWrite = 0;
	Branch = 0;
	ALUop[1] = 1;
	ALUop[0] = 0;
	end
	
	else if(inst_in == 6'b001101)//ori
	begin
	RegDst = 0;
	Jump = 0;
	Link = 0;
	ALUsrc = 1;
	MemtoReg = 0;
	RegWrite = 1;
	MemRead = 1;
	MemWrite = 0;
	Branch = 0;
	ALUop[1] = 1;
	ALUop[0] = 0;
	end

	else if(inst_in == 6'b000100)//branch
	begin
	ALUsrc = 0;
	Jump = 0;
	Link = 0;
	RegWrite = 0;
	MemRead = 0;
	MemWrite = 0;
	Branch = 1;
	ALUop[1] = 0;
	ALUop[0] = 1;
	end
end

endmodule
