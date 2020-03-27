module Mux4to1_1bit(input a,b,c,d, input [1:0] select, output outBus);
	assign outBus = select[1]?(select[0]?d:c):(select[0]?b:a);
endmodule