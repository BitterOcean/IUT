module AddSub8bit_tb;
	//variables
	reg [7:0] a,b;
	reg mode;
	wire [7:0] result;
	wire carry_sign;

	//call comparetor
	AddSub8bit AS_Obj(.In1(a),.In2(b),.mode(mode),.result(result),.carry_sign(carry_sign));


	//Test inputs
	initial begin

		$monitor("%d Input1=%b , Input2=%b , Mode=%b , Result=%b , Carry/Sign=%b",
		 	 $time,a,b,mode,result,carry_sign);
		#20
		a = 8'hff;
		b = 8'hff;
		mode = 1'b1;//Add
		#20
		a = 8'hff;
		b = 8'hff;
		mode = 1'b0;//Sub
		#20
		a = 8'h00;
		b = 8'h0f;
		mode = 1'b0;//Sub
		#20
		a = 8'h00;
		b = 8'h0f;
		mode = 1'b1;//Add
		#20
		a = 8'h56;
		b = 8'h39;
		mode = 1'b1;//Add
		#20
		a = 8'h56;
		b = 8'h39;
		mode = 1'b0;//Sub
	end
endmodule