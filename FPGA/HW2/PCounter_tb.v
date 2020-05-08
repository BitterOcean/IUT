`timescale 1ns / 1ps

module PCounter_tb();

	reg enable=0;
	reg clk=0;
	reg reset=0;
	integer i;
	wire [3:0] cnt_out;
	wire out;

	always #5 clk = ~clk;

	PCounter #(.MAX_SIZE(4),.p(10)) U1 (.enable(enable),.clk(clk),.cnt_out(cnt_out),.out(out),.reset(reset));

	initial 
	begin 
	
		for(i = 0 ; i < 4 ; i = i + 1 )
		begin 
			{enable,reset} = i;
			#50;
			$monitor("ENABLE=%s , RESER=%s Parameter=10 cnt_out=%d" ,enable?"ON":"OFF",reset?"OFF":"ON",cnt_out);
		end
		#100;
		$monitor("----------------Simulation ENDs----------------");
	end
		
endmodule
