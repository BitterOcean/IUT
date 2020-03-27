# Sequence Detector
![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)
![Builed](https://img.shields.io/azure-devops/build/totodem/8cf3ec0e-d0c2-4fcd-8206-ad204f254a96/2?style=flat)
![License](https://img.shields.io/packagist/l/doctrine/orm)
![language](https://img.shields.io/badge/language-verilog-orange)

Author : Maryam Saeedmehr  
Language : verilog

<p align="center">
<img src="https://user-images.githubusercontent.com/60509979/77753227-baaad180-7046-11ea-8469-3e35a6c14027.png">
</p>
</br>  

## **Solution** :metal::sunglasses:   
:one: Mux4x1 1 bit
```verilog
module Mux4to1_1bit(input a,b,c,d, input [1:0] select, output outBus);
	assign outBus = select[1]?(select[0]?d:c):(select[0]?b:a);
endmodule
```
:heavy_check_mark:   

```verilog
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
```
:two: Mux4x1 8 bit 
```verilog
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
```
:heavy_check_mark: 
```verilog
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
```
:three: Mux16x1 8 bit
```verilog
module Mux16to1_8bit(input [7:0] a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p, input [3:0] select, output [7:0] outBus);
	wire [7:0] out [3:0];
	Mux4to1_8bit U0 (.a(a),.b(b),.c(c),.d(d),.select(select[1:0]),.outBus(out[0]));
	Mux4to1_8bit U1 (.a(e),.b(f),.c(g),.d(h),.select(select[1:0]),.outBus(out[1]));
	Mux4to1_8bit U2 (.a(i),.b(j),.c(k),.d(l),.select(select[1:0]),.outBus(out[2]));
	Mux4to1_8bit U3 (.a(m),.b(n),.c(o),.d(p),.select(select[1:0]),.outBus(out[3]));
	Mux4to1_8bit U4 (.a(out[0]),.b(out[1]),.c(out[2]),.d(out[3]),.select(select[3:2]),.outBus(outBus));
endmodule
```
:heavy_check_mark: 
```verilog
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
```
  
## **Simulation**
:one: Mux4x1 1 bit
![ScrQ3_1](https://user-images.githubusercontent.com/60509979/77753652-900d4880-7047-11ea-94a6-2e7d2189fae7.png)

:two: Mux4x1 8 bit
![ScrQ3_1 5](https://user-images.githubusercontent.com/60509979/77753747-b6cb7f00-7047-11ea-94cb-7008a57be619.png)

:three: Mux16x1 8 bit
![ScrQ3_2](https://user-images.githubusercontent.com/60509979/77753777-c34fd780-7047-11ea-9887-30ee4ced18c1.png)


## **SUPPOERT**

Reach out to me at one of the following places!

- Telegram at <a href="https://t.me/BitterOcean" target="_blank">@BitterOcean</a>
- Gmail at <a href="mailto:maryamsaeedmehr@gmail.com" target="_blank">maryamsaeedmehr@gmail.com</a>
