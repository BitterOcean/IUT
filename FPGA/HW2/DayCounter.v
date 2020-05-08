`timescale 1ns / 1ps

module DayCounter(
	input enable,
	input clk,
	input reset,
	output [5:0] second,
	output [5:0] minute,
	output [4:0] hour,
	output [4:0] day,
	output [3:0] month,
	output [6:0] year
	);
	// minute and second are maximum 59 => 6 bit
	// hour is maximum 23 and day is maximum 29 => 5 bit
	// month is maximum 11 => 4 bit
	// year is unbounded but e.g. maximum is 99 then it should become a century => 7 bit
	wire year_out,month_out,day_out,hour_out,min_out,sec_out;

	//second
	PCounter #(.MAX_SIZE(6),.p(59)) U0 (.enable(enable),.clk(clk),.cnt_out(second),.out(sec_out),.reset(reset));

	//minute
	PCounter #(.MAX_SIZE(6),.p(59)) U1 (.enable(enable),.clk(sec_out),.cnt_out(minute),.out(min_out),.reset(reset));

	//hour
	PCounter #(.MAX_SIZE(5),.p(23)) U2 (.enable(enable),.clk(min_out),.cnt_out(hour),.out(hour_out),.reset(reset));

	//day
	PCounter #(.MAX_SIZE(5),.p(29)) U3 (.enable(enable),.clk(hour_out),.cnt_out(day),.out(day_out),.reset(reset));

	//month
	PCounter #(.MAX_SIZE(4),.p(11)) U4 (.enable(enable),.clk(day_out),.cnt_out(month),.out(month_out),.reset(reset));

	//year
	PCounter #(.MAX_SIZE(7),.p(99)) U5 (.enable(enable),.clk(month_out),.cnt_out(year),.out(year_out),.reset(reset));

endmodule
