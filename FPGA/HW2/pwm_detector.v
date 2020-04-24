module pwm_detector(input clk,pwm_in,high_read,low_read, output reg [15:0] data_out=16'bz);

	reg [15:0] Low=0;
	reg [15:0] High=0;
	reg [15:0] HighCounter=0;
	reg [15:0] LowCounter=0;

	always @(posedge clk)
	begin
		if (pwm_in==1)
		begin 
			if(Low != LowCounter && HighCounter==0) Low <= LowCounter;
			LowCounter <= 0; 
			HighCounter <= HighCounter + 1; 
		end

		if(pwm_in==0)
		begin 
			if(High != HighCounter && LowCounter==0) High <= HighCounter;
			HighCounter <= 0; 
			LowCounter <= LowCounter + 1; 
		end
	end

	always @(posedge clk)
	begin 
		if (high_read==1)
			data_out <= High;

		else if (low_read==1)
			data_out <= Low;

		else
			data_out <= 16'bz;
	end

endmodule