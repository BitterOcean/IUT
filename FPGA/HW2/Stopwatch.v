`timescale 1ns / 1ps

module Stopwatch(
	input clk, 
	input reset,
	input start, 
	input stop, 
	output [5:0] second,
	output [5:0] minute, 
	output [4:0] hour,
	output [4:0] day, 
	output[3:0] month, 
	output [6:0] year
	);

	reg enable=0;

	DayCounter uu1(
		.enable(enable),
		.clk(clk),
		.reset(reset),
		.second(second),
		.minute(minute),
		.hour(hour),
		.day(day),
		.month(month),
		.year(year)
	);
	
	always @(posedge start or posedge stop)
	begin
	
		if(start==1)
			enable <= 1;
		if(stop==1)
			enable <= 0; // stop has a higher priority
	
	end

endmodule
