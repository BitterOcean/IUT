`timescale 1ns / 1ps

module pwm_detector_tb;

	// Inputs
	reg clk=0;
	reg pwm_in=0;
	reg high_read=0;
	reg low_read=0;

	// Outputs
	wire [15:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	pwm_detector uut (
		.clk(clk), 
		.pwm_in(pwm_in), 
		.high_read(high_read), 
		.low_read(low_read), 
		.data_out(data_out)
	);

	always #5 clk=~clk;

	always 
	begin 
		repeat (3) begin #10 pwm_in = 1; #50 pwm_in = 0; end
		repeat (3) begin #50 pwm_in = 1; #10 pwm_in = 0; end
		repeat (3) begin #30 pwm_in = 1; #30 pwm_in = 0; end
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		pwm_in = 0;
		high_read = 0;
		low_read = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		$monitor("%d : Data_Out = %d ==> %s ",$time ,data_out,high_r?"High Value":(low_r?"Low Value":"Not Set"));
		
		#30	high_r = 1;
		#30	high_r = 0;
			low_r = 1;

		#30	low_r = 0;
		#100	high_r = 1;
		#30	high_r = 0;
			low_r = 1;

		#30	low_r = 0;
		#120	high_r = 1;
		#30	high_r = 0;
			low_r = 1;
		#30	low_r = 0;
			high_r = 1;
		#30	high_r = 0;
		
	end
      
endmodule
