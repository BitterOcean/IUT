`timescale 1ns / 1ps

module pwm_generator_tb;

	// Inputs
	reg clk=0;
	reg high_wr=0;
	reg low_wr=0;
	reg [15:0] data_in=0;
	reg [6:0] DutyCycle=7'bz;

	// Outputs
	wire pwm_out;

	// Instantiate the Unit Under Test (UUT)
	pwm_generator uut (
		.clk(clk), 
		.high_wr(high_wr), 
		.low_wr(low_wr), 
		.data_in(data_in), 
		.pwm_out(pwm_out)
	);

	always #5 clk=~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		high_wr = 0;
		low_wr = 0;
		data_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		$monitor("High_write = %s , Low_write = %s , Data_in = %d ==>> Duty Cycle = %d percent",high_wr?"ON":"OFF",low_wr?"ON":"OFF",data_in,DutyCycle);
		
		#30	DutyCycle = 10;
			data_in = 1;
			high_wr = 1;
		#10	high_wr = 0;
		#5	data_in = 9;
			low_wr = 1;
		#10	low_wr = 0;


		#200	DutyCycle = 50;
			data_in = 5;
			high_wr = 1;
		#10	high_wr = 0;
			low_wr = 1;
		#10	low_wr = 0;

		#200	DutyCycle = 90;
			data_in = 9;
			high_wr = 1;
		#10	high_wr = 0;
		#5	data_in = 1;
			low_wr = 1;
		#10	low_wr = 0;
		
	end
      
endmodule
