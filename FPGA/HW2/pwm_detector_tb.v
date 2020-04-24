module pwm_detector_tb();
	
	reg clk=0;
	reg high_r=0;
	reg low_r=0;
	reg pwm_in=0;
	wire [15:0] data_out;

	always #5 clk=~clk;

	always 
	begin 
		repeat (3) begin #10 pwm_in = 1; #50 pwm_in = 0; end
		repeat (3) begin #50 pwm_in = 1; #10 pwm_in = 0; end
		repeat (3) begin #30 pwm_in = 1; #30 pwm_in = 0; end
	end

	pwm_detector U1 (clk,pwm_in,high_r,low_r,data_out);
	
	initial begin
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