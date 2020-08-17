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
	wire [31:0] PC_Current,PC_FinalNext;  
	wire [31:0] PC_Next,PC_JRNext,PC2,BranchedPC,Jump_Address;  
	wire [31:0] Instruction;  
	wire [1:0] ALUop;  
	wire JRControl,Jump,Link,Branch,MemRead,MemWrite,ALUsrc,RegWrite,RegWrite_Final,RegDst,MemtoReg;  
	wire [4:0] WriteReg,WriteReg_Final,ReadReg1,ReadReg2;  
	wire [31:0] ReadData1,ReadData2,WriteData,WriteData_Final;  
	wire [31:0] ReadData;  
	wire [31:0] SignExtended;
	wire [3:0] ALUControlOP;  
	wire [31:0] ALUResult,ALUDataIn2;  
	wire Zero,BranchSelect;

	////////////////////////////////////////////////////////// PC
	Reg32 PC (
    .clk(NewClk), 
    .DataIn(PC_FinalNext), 
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
	
	////////////////////////////////// New Parts
	
	// JR Controler
	JR_Controler JumpCtrl (
    .OP_Code(Instruction[31:26]), 
    .Func(Instruction[5:0]), 
    .JRControl(JRControl)
    );
	
	Mux2x1_32 PC_Selector_JR (
    .DataIn1(PC_Next), 
    .DataIn2(ReadData1), 
    .Select(JRControl), 
    .DataOut(PC_JRNext)
    );
	
	// Jump Controler
	JumpAddress Jump_Addr (
    .Address(Instruction[25:0]), 
    .PC2(PC2), 
    .Jump_Address(Jump_Address)
    );
	 
	Mux2x1_32 PC_Selector_Jump (
    .DataIn1(PC_JRNext), 
    .DataIn2(Jump_Address), 
    .Select(Jump), 
    .DataOut(PC_FinalNext)
    );	 
	 
	////////////////////////////////// New Parts

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
	 
	 ////////////////////////////////// New Parts
	 
	 // Jump and Link
	 Mux2x1_32 RegWrite_Selector_Link (
    .DataIn1(WriteReg), 
    .DataIn2(5'b11111), // $31
    .Select(Link), 
    .DataOut(WriteReg_Final)
    );	 
	 
	 Mux2x1_32 DataWrite_Selector_Link (
    .DataIn1(WriteData), 
    .DataIn2(PC2), 
    .Select(Link), 
    .DataOut(WriteData_Final)
    );	 
	 
	 ////////////////////////////////// New Parts
	 
	 RegisterFile Registers (
    .ReadReg1(Instruction[25:21]), 
    .ReadReg2(Instruction[20:16]), 
    .WriteReg(WriteReg_Final), 
    .WriteData(WriteData_Final), 
    .RegWrite(RegWrite_Final), 
    .clk(clk), 
    .ReadData1(ReadData1), 
    .ReadData2(ReadData2)
    );
	 
	 ////////////////////////////////////////////////////////// Control Unit	 
	 Control Control_Unit (
    .inst_in(Instruction[31:26]), 
    .RegDst(RegDst),
	 .Jump(Jump),
	 .Link(Link),
    .Branch(Branch), 
    .MemRead(MemRead), 
    .MemtoReg(MemtoReg), 
    .ALUop(ALUop), 
    .MemWrite(MemWrite), 
    .ALUsrc(ALUsrc), 
    .RegWrite(RegWrite)
    );
	 
	 and JR_RegWrite(RegWrite_Final,RegWrite,~JRControl);
	 
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
