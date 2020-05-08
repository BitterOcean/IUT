`timescale 1ns / 1ps

module pwm_generator (
	input clk,
	input high_wr,
	input low_wr, 
	input [15:0] data_in, 
	output reg pwm_out=0
	);

	reg [15:0] Low=0;
	reg [15:0] High=0;
	reg [15:0] HighCounter=0;
	reg [15:0] LowCounter=0;
	reg turn=1'bx;// "turn" decides when pwm_out should be 1 and when 0

	always @(posedge clk)
	begin

		if (high_wr)
		begin
			High <= data_in;
			HighCounter <= data_in;
			turn <= 1;
		end

		if (low_wr) 
		begin
			Low <= data_in;
			LowCounter <= data_in;
		end

		if (turn==1) 
		begin : up
			pwm_out <= 1;
			if( HighCounter==1 )
			begin 
				HighCounter <= High;
				turn <= 0;
				disable up;
			end
			HighCounter <= HighCounter - 1 ;
		end

		if (turn==0) 
		begin : down
			pwm_out <= 0;
			if( LowCounter==1 )
			begin 
				LowCounter <= Low;
				turn <= 1;
				disable down;
			end
			LowCounter <= LowCounter - 1 ;
		end

	end

endmodule
