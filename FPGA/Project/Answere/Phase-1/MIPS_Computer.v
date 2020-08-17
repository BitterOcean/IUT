`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer:		 Maryam Saeedmehr
//
// Create Date:    10:46:19 07/20/2020 
// Design Name: 	 MIPS Computer 32bit
// Module Name:    MIPS_Computer
// Project Name: 	 MIPS
// Target Devices: xc6slx9-3tqg144
// Description: 	 A complete computer.
//
// Revision:		 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

module MIPS_Computer(
	input clk,
	output [31:0] PC_Out,
	output [31:0] ALU_Result,
	output [31:0] Branched_PC,
	output [31:0] Next_PC,
	output New_clk,
	output AND_Output
    );
	 
	// wire declaration
	wire NewClk;
	wire [31:0] PC_Current;  
	wire [31:0] PC_Next,PC2,BranchedPC;  
	wire [31:0] Instruction;  
	wire [1:0] ALUop;  
	wire Branch,MemRead,MemWrite,ALUsrc,RegWrite,RegDst,MemtoReg;  
	wire [4:0] WriteReg,ReadReg1,ReadReg2;  
	wire [31:0] ReadData1,ReadData2,WriteData;  
	wire [31:0] ReadData;  
	wire [31:0] SignExtended;
	wire [3:0] ALUControlOP;  
	wire [31:0] ALUResult,ALUDataIn2;  
	wire Zero,BranchSelect;

	////////////////////////////////////////////////////////// PC
	Reg32 PC (
    .clk(NewClk), 
    .DataIn(PC_Next), 
    .DataOut(PC_Current)
    );

	Incrementer32 Generate_PC2 (
    .DataIn(PC_Current),
    .DataOut(PC2)
    );
	 
	 Add32 Branch_PC (
    .DataIn1(PC2), 
    .DataIn2(SignExtended),
    .DataOut(BranchedPC)
    );
	 
	 Mux2x1_32 PC_Selector (
    .DataIn1(PC2), 
    .DataIn2(BranchedPC), 
    .Select(BranchSelect), 
    .DataOut(PC_Next)
    );
	 
	 // Used to control that each instruction has completed and then fetch new 
	 Counter32 Count (
    .clk(clk), 
    .NewClk(NewClk)
    );
	 
	and BranchSelector(BranchSelect,Branch,Zero);
	
	////////////////////////////////////////////////////////// Instruction Memory
	 InstructionMem Instruction_Memory (
    .Address(PC_Current[4:0]), 
    .Instruction(Instruction)
    );
	 
	 ////////////////////////////////////////////////////////// Register File
	 Mux2x1_32 WriteReg_selector (
    .DataIn1({27'b0,Instruction[20:16]}), 
    .DataIn2({27'b0,Instruction[15:11]}), 
    .Select(RegDst), 
    .DataOut(WriteReg)
    );
	 
	 Mux2x1_32 WriteData_selector (
    .DataIn1(ALUResult), 
    .DataIn2(ReadData), 
    .Select(MemtoReg), 
    .DataOut(WriteData)
    );
	 
	 RegisterFile Registers (
    .ReadReg1(Instruction[25:21]), 
    .ReadReg2(Instruction[20:16]), 
    .WriteReg(WriteReg), 
    .WriteData(WriteData), 
    .RegWrite(RegWrite), 
    .clk(clk), 
    .ReadData1(ReadData1), 
    .ReadData2(ReadData2)
    );
	 
	 ////////////////////////////////////////////////////////// Control Unit	 
	 Control Control_Unit (
    .inst_in(Instruction[31:26]), 
    .RegDst(RegDst), 
    .Branch(Branch), 
    .MemRead(MemRead), 
    .MemtoReg(MemtoReg), 
    .ALUop(ALUop), 
    .MemWrite(MemWrite), 
    .ALUsrc(ALUsrc), 
    .RegWrite(RegWrite)
    );
	 
	 ////////////////////////////////////////////////////////// Sign Extend
	 SignExtend Sign_Extend (
    .DataIn(Instruction[15:0]), 
    .clk(clk), 
    .DataOut(SignExtended)
    );

	 ////////////////////////////////////////////////////////// ALU
	 Mux2x1_32 ALU_Input2_selector (
    .DataIn1(ReadData2), 
    .DataIn2(SignExtended), 
    .Select(ALUsrc), 
    .DataOut(ALUDataIn2)
    );

	 ALU32 ALU (
    .DataIn1(ReadData1), 
    .DataIn2(ALUDataIn2), 
    .Operation(ALUControlOP), 
    .clk(clk), 
    .Result(ALUResult), 
    .Zero(Zero)
    );

	 ALU_control ALU_Control_Unit (
    .ALU_op(ALUop), 
    .inst(Instruction[5:0]), 
    .op(ALUControlOP)
    );
	 
	 ////////////////////////////////////////////////////////// Data Memory
	 DataMem Data_Memory (
    .Address(ALUResult[6:0]), 
    .WriteData(ReadData2), 
    .MemWrite(MemWrite), 
    .MemRead(MemRead), 
    .clk(clk), 
    .ReadData(ReadData)
    );
	 
	////////////////////////////////////////////////////////// Assignment
	assign PC_Out = PC_Current;  
	assign ALU_Result = ALUResult;
	assign Branched_PC = BranchedPC;
	assign Next_PC = PC_Next;
	assign New_clk = NewClk;
	assign AND_Output = BranchSelect;
	 
endmodule
