`timescale 1 us/100 ps // clk = 1 MHz

module DayCounter_tb;

	// Inputs
	reg enable;
	reg clk=0;
	reg reset=1;
	integer i;

	// Outputs
	wire [5:0] second;
	wire [5:0] minute;
	wire [4:0] hour;
	wire [4:0] day;
	wire [3:0] month;
	wire [6:0] year;

	// Instantiate the Unit Under Test (UUT)
	DayCounter uut (
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

	always #0.5 clk=~clk;
	
	initial begin
	
		for(i = 0 ; i < 4 ; i = i + 1 )
		begin 
			{enable,reset} = i;
			#50;
			$monitor("ENABLE=%s , RESET=%s , Date and Time : %d/%d/%d - %d:%d:%d",enable?"ON":"OFF",reset?"OFF":"ON",year,month,day,hour,minute,second);
		end
		#100;
		$monitor("---------------------Simulation ENDs---------------------");
		
	end
      
endmodule
