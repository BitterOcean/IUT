module pwm_generator_tb();
	
	reg clk=0;
	reg high_wr=0;
	reg low_wr=0;
	reg [15:0] data_in = 0;
	wire pwm_out;
	reg [6:0] DutyCycle=0;

	always #5 clk=~clk;

	pwm_generator U1 (clk,high_wr,low_wr,data_in,pwm_out);
	
	initial begin
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