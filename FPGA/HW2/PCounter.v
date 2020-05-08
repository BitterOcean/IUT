`timescale 1ns / 1ps

module PCounter #(parameter MAX_SIZE = 7,parameter [MAX_SIZE-1:0] p = 59) (
	input enable,
	input clk, 
	input reset, 
	output reg [MAX_SIZE-1:0] cnt_out=0 , 
	output reg out=0
	);

	always @(posedge clk,negedge reset)
	begin : main
		if (reset==0)
			cnt_out <= 0;

		else
		begin
			out <= 0;
			if (enable==1)
			begin
				if (cnt_out < p)
					cnt_out <= cnt_out + 1;
				else
				begin
					out <= 1;
					cnt_out <= 0;
				end
			end
			else
				disable main;																																					
		end
	end

endmodule
