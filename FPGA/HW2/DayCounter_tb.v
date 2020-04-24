`timescale 1 us/100 ps // clk = 1 MHz

module DayCounter_tb();

	wire [5:0] second,minute;
	wire [4:0] hour,day;
	wire [3:0] month;
	wire [6:0] year;
	reg clk=0;
	reg reset=1;

	DayCounter U1 (clk,reset,second,minute,hour,day,month,year);

	initial begin
		$monitor("RESET=%s , Date and Time : %d/%d/%d - %d:%d:%d",reset?"OFF":"ON",year,month,day,hour,minute,second);

		#10 reset=0;
		#5 reset=1;
	end
		
	always #0.5 clk=~clk;

endmodule