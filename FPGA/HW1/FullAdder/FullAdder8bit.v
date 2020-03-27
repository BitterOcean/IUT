module FullAdder8bit (input [7:0] a, b , input cin , output [7:0] sum, output cout);
	wire cout1,cout2,cout3,cout4,cout5,cout6,cout7;
	FullAdder1bit U1 (.a(a[0]),.b(b[0]),.cin(cin),.sum(sum[0]),.cout(cout1));
	FullAdder1bit U2 (.a(a[1]),.b(b[1]),.cin(cout1),.sum(sum[1]),.cout(cout2));
	FullAdder1bit U3 (.a(a[2]),.b(b[2]),.cin(cout2),.sum(sum[2]),.cout(cout3));
	FullAdder1bit U4 (.a(a[3]),.b(b[3]),.cin(cout3),.sum(sum[3]),.cout(cout4));
	FullAdder1bit U5 (.a(a[4]),.b(b[4]),.cin(cout4),.sum(sum[4]),.cout(cout5));
	FullAdder1bit U6 (.a(a[5]),.b(b[5]),.cin(cout5),.sum(sum[5]),.cout(cout6));
	FullAdder1bit U7 (.a(a[6]),.b(b[6]),.cin(cout6),.sum(sum[6]),.cout(cout7));
	FullAdder1bit U8 (.a(a[7]),.b(b[7]),.cin(cout7),.sum(sum[7]),.cout(cout));
endmodule