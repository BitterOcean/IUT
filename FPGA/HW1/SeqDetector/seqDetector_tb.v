module seqDetector_tb();
	reg Input,clk=0;
	reg [1:0] select=0;
	wire [7:0] count;
	wire detected;

	seqDetector U1 (.Input_seq(Input),.clk(clk),.seq_select(select),.seq_detected(detected),.dseq_number(count));

	always #5 clk=~clk;
	always #7 Input=$random;
	always #100 select=$random;

endmodule
