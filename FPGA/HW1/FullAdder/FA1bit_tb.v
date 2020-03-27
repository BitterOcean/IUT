module FullAdder1bit_tb;
	//variables
	reg a,b;
	reg cin;
	wire sum;
	wire cout;

	//call comparetor
	FullAdder1bit FA_Obj(.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));

	//Test inputs
	initial begin
		$monitor("%d a=%b , b=%b , cin=%b , sum=%b , cout=%b ",
		 	 $time,a,b,cin,sum,cout);
		#20
		a = 1'b1;
		b = 1'b1;
		cin = 1'b1;
		#20
		a = 1'b1;
		b = 1'b1;
		cin = 1'b0;
		#20
		a = 1'b0;
		b = 1'b1;
		cin = 1'b0;
		#20
		a = 1'b0;
		b = 1'b1;
		cin = 1'b1;
		#20
		a = 1'b0;
		b = 1'b0;
		cin = 1'b1;
		#20
		a = 1'b0;
		b = 1'b0;
		cin = 1'b0;
	end
endmodule