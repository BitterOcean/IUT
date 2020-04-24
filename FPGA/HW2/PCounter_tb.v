module PCounter_tb();

	reg clk=0;
	reg reset=0;
	wire [3:0] cnt_out;
	wire out;

	PCounter #(.MAX_SIZE(4),.p(10)) U1 (.clk(clk),.cnt_out(cnt_out),.out(out),.reset(reset));

	initial 
	begin 
		$monitor("RESER=%s Parameter=10 cnt_out=%d" ,reset?"OFF":"ON",cnt_out);

		     reset = 1 ;
		#70  reset = 0 ;
		#50  reset = 1 ;
		#100 reset = 0 ;
	end
		
	always #5 clk=~clk;

endmodule