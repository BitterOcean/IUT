module Mux4to1_tb;
	reg In1,In2,In3,In4;
	reg [1:0] sel;
	wire out;
	Mux4to1_1bit U1(.a(In1),
			.b(In2),
			.c(In3),
			.d(In4),
			.select(sel),
			.outBus(out));
	initial begin
		$monitor("%d a=%b , b=%b , c=%b , d=%b , select=%b output=%b ",
		 	 $time,In1,In2,In3,In4,sel,out);
		In1=1;
		In2=0;
		In3=0;
		In4=0;
		sel=0;
		#10
		In1=0;
		In2=1;
		In3=0;
		In4=0;
		sel=1;
		#10
		In1=0;
		In2=0;
		In3=1;
		In4=0;
		sel=2;
		#10
		In1=0;
		In2=0;
		In3=0;
		In4=1;
		sel=3;
	end
endmodule