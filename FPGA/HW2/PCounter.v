module PCounter #(parameter MAX_SIZE = 7,parameter [MAX_SIZE-1:0] p = 59) (input clk, reset, output reg [MAX_SIZE-1:0] cnt_out=0 , output reg out=0);

	always @(posedge clk,negedge reset)
	begin : main
		if (reset==0) 
		begin
			cnt_out <= 0;
			disable main;
		end

		out <= 0;
		if (cnt_out < p)
			cnt_out <= cnt_out + 1;
		else
		begin
			out <= 1;
			cnt_out <= 0;
		end
	end

endmodule
