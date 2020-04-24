`timescale 1 us/100 ps // clk = 1 MHz

module Stopwatch_tb();

	wire [5:0] second,minute;
	wire [4:0] hour,day;
	wire [3:0] month;
	wire [6:0] year;
	reg clk=0;
	reg reset=1;
	reg start=0;
	reg stop=0;

	Stopwatch U1 (clk,reset,start,stop,second,minute,hour,day,month,year);

	initial begin
		$monitor(" START : %s - RESET : %s - STOP : %s *** Stopwatch : %d/%d/%d - %d:%d:%d",start?"ON":"OFF",reset?"OFF":"ON",stop?"ON":"OFF",year,month,day,hour,minute,second);
		#5  start=1; 
		#10 reset=0;
		#3  reset=1;
		#20 stop=1;
	end
		
	always #0.5 clk=~clk;

endmodule
