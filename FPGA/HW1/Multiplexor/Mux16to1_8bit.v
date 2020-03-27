module Mux4to1_8bit (input [7:0] a,b,c,d, input [1:0] select, output [7:0] outBus);
	Mux4to1_1bit U0 (.a(a[0]),.b(b[0]),.c(c[0]),.d(d[0]),.select(select),.outBus(outBus[0]));
	Mux4to1_1bit U1 (.a(a[1]),.b(b[1]),.c(c[1]),.d(d[1]),.select(select),.outBus(outBus[1]));
	Mux4to1_1bit U2 (.a(a[2]),.b(b[2]),.c(c[2]),.d(d[2]),.select(select),.outBus(outBus[2]));
	Mux4to1_1bit U3 (.a(a[3]),.b(b[3]),.c(c[3]),.d(d[3]),.select(select),.outBus(outBus[3]));
	Mux4to1_1bit U4 (.a(a[4]),.b(b[4]),.c(c[4]),.d(d[4]),.select(select),.outBus(outBus[4]));
	Mux4to1_1bit U5 (.a(a[5]),.b(b[5]),.c(c[5]),.d(d[5]),.select(select),.outBus(outBus[5]));
	Mux4to1_1bit U6 (.a(a[6]),.b(b[6]),.c(c[6]),.d(d[6]),.select(select),.outBus(outBus[6]));
	Mux4to1_1bit U7 (.a(a[7]),.b(b[7]),.c(c[7]),.d(d[7]),.select(select),.outBus(outBus[7]));
endmodule


module Mux16to1_8bit(input [7:0] a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p, input [3:0] select, output [7:0] outBus);
	wire [7:0] out [3:0];
	Mux4to1_8bit U0 (.a(a),.b(b),.c(c),.d(d),.select(select[1:0]),.outBus(out[0]));
	Mux4to1_8bit U1 (.a(e),.b(f),.c(g),.d(h),.select(select[1:0]),.outBus(out[1]));
	Mux4to1_8bit U2 (.a(i),.b(j),.c(k),.d(l),.select(select[1:0]),.outBus(out[2]));
	Mux4to1_8bit U3 (.a(m),.b(n),.c(o),.d(p),.select(select[1:0]),.outBus(out[3]));
	Mux4to1_8bit U4 (.a(out[0]),.b(out[1]),.c(out[2]),.d(out[3]),.select(select[3:2]),.outBus(outBus));
endmodule