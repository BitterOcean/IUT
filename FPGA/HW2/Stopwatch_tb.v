`timescale 1us / 1ps

module Stopwatch_tb;

	// Inputs
	reg clk=0;
	reg reset=1;
	reg start=0;
	reg stop=0;
	integer i;

	// Outputs
	wire [5:0] second;
	wire [5:0] minute;
	wire [4:0] hour;
	wire [4:0] day;
	wire [3:0] month;
	wire [6:0] year;

	// Instantiate the Unit Under Test (UUT)
	Stopwatch uut (
		.start(start),
		.stop(stop),
		.clk(clk), 
		.reset(reset), 
		.second(second), 
		.minute(minute), 
		.hour(hour), 
		.day(day), 
		.month(month), 
		.year(year)
	);


	always #0.5 clk=~clk;

	initial begin

		for(i = 0 ; i < 4 ; i = i + 1 )
		begin 
			{start,reset} = i;
			#50;
			$monitor("START : %s - RESET : %s - STOP : %s *** Stopwatch : %d/%d/%d - %d:%d:%d",start?"ON":"OFF",reset?"OFF":"ON",stop?"ON":"OFF",year,month,day,hour,minute,second);
		end
		#500;
		stop = 1;
		$monitor("---------------------Simulation ENDs---------------------");

	end
      
endmodule
