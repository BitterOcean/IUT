module FullAdder8bit_tb;
	//variables
	reg [7:0] a,b;
	reg cin;
	wire [7:0] sum;
	wire cout;

	//call comparetor
	FullAdder8bit FA_Obj(.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));

	//Test inputs
	initial begin
		$monitor("%d a=%b , b=%b , cin=%b , sum=%b , cout=%b ",
		 	 $time,a,b,cin,sum,cout);
		#20
		a = 8'hff;
		b = 8'hff;
		cin = 1'b1;
		#20
		a = 8'hff;
		b = 8'hff;
		cin = 1'b0;
		#20
		a = 8'h00;
		b = 8'h0f;
		cin = 1'b0;
		#20
		a = 8'h00;
		b = 8'h0f;
		cin = 1'b1;
		#20
		a = 8'h56;
		b = 8'h39;
		cin = 1'b1;
	end
endmodule
