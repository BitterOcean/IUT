module AddSub8bit (input [7:0] In1, In2 , input mode , output [7:0] result, output carry_sign);
// mode : 1 for adder , 0 for subtractor
	wire cout1,cout2,cout3,cout4,cout5,cout6,cout7;
	wire [7:0] a,b;
	assign a = In1;
	assign b = In2^(mode?8'h00:8'hff);
	FullAdder1bit U1 (.a(a[0]),.b(b[0]),.cin(~mode),.sum(result[0]),.cout(cout1));
	FullAdder1bit U2 (.a(a[1]),.b(b[1]),.cin(cout1),.sum(result[1]),.cout(cout2));
	FullAdder1bit U3 (.a(a[2]),.b(b[2]),.cin(cout2),.sum(result[2]),.cout(cout3));
	FullAdder1bit U4 (.a(a[3]),.b(b[3]),.cin(cout3),.sum(result[3]),.cout(cout4));
	FullAdder1bit U5 (.a(a[4]),.b(b[4]),.cin(cout4),.sum(result[4]),.cout(cout5));
	FullAdder1bit U6 (.a(a[5]),.b(b[5]),.cin(cout5),.sum(result[5]),.cout(cout6));
	FullAdder1bit U7 (.a(a[6]),.b(b[6]),.cin(cout6),.sum(result[6]),.cout(cout7));
	FullAdder1bit U8 (.a(a[7]),.b(b[7]),.cin(cout7),.sum(result[7]),.cout(carry_sign));
endmodule