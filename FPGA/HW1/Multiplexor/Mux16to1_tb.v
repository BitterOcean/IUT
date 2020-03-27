module Mux16to1_tb;
	reg [7:0] In1=1,In2=2,In3=3,In4=4,
		  In5=5,In6=6,In7=7,In8=8,
		  In9=9,In10=10,In11=11,
		  In12=12,In13=13,In14=14,
		  In15=15,In16=16;
	reg [3:0] sel;
	wire [7:0] out;
	Mux16to1_8bit U1(.a(In1),.b(In2),.c(In3),.d(In4),
			.e(In5),.f(In6),.g(In7),.h(In8),
			.i(In9),.j(In10),.k(In11),.l(In12),
			.m(In13),.n(In14),.o(In15),.p(In16),
			.select(sel),
			.outBus(out));
	initial begin
		$monitor("%d a=%b , b=%b , c=%b , d=%b , e=%b , f=%b , g=%b , h=%b , i=%b , j=%b , k=%b , l=%b , m=%b , n=%b , o=%b , p=%b , select=%b , output=%b ",
		 	 $time,In1,In2,In3,In4,In5,In6,In7,In8,In9,In10,In11,In12,In13,In14,In15,In16,sel,out);
		
		sel=0;
		#10
		sel=1;
		#10
		sel=2;
		#10
		sel=3;
		#10
		sel=4;
		#10
		sel=5;
		#10
		sel=6;
		#10
		sel=7;
		#10
		sel=8;
		#10
		sel=9;
		#10
		sel=10;
		#10
		sel=11;
		#10
		sel=12;
		#10
		sel=13;
		#10
		sel=14;
		#10
		sel=15;
	end
endmodule

module Mux4to1_8bit_tb;
	reg [7:0] In1=1,In2=2,In3=3,In4=4;
	reg [1:0] sel;
	wire [7:0] out;
	Mux4to1_8bit U1(.a(In1),
			.b(In2),
			.c(In3),
			.d(In4),
			.select(sel),
			.outBus(out));
	initial begin
		$monitor("%d a=%b , b=%b , c=%b , d=%b , select=%b output=%b ",
		 	 $time,In1,In2,In3,In4,sel,out);
		
		sel=0;
		#10
		
		sel=1;
		#10
		
		sel=2;
		#10
		
		sel=3;
	end
endmodule