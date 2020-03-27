# Full Adder 8 bit using FA 1 bit
![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)
![Builed](https://img.shields.io/azure-devops/build/totodem/8cf3ec0e-d0c2-4fcd-8206-ad204f254a96/2?style=flat)
![License](https://img.shields.io/packagist/l/doctrine/orm)
![language](https://img.shields.io/badge/language-verilog-orange)

Author : Maryam Saeedmehr  
Language : verilog

<p align="center">
<img src="https://user-images.githubusercontent.com/60509979/77750066-c7c4c200-7040-11ea-98f2-fb53b5ef3243.png">
</p>
</br>  

## **Solution** :metal::sunglasses:
:one: Full Adder 1 bit
```verilog
module FullAdder1bit (input a,b,cin, output sum , cout);
	assign {cout,sum} = a + b + cin;
endmodule
```
  :heavy_check_mark: Full Adder 1 bit **testbench**
  ```verilog
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
  ```
:two: Full Adder 8 bit
```verilog
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
```  
  
  :heavy_check_mark: Full Adder 8 bit **testbench**
  ```verilog
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
  ```
  
## **Simulation**
:one: Full Adder 1 bit
![ScrQ1_1](https://user-images.githubusercontent.com/60509979/77751967-4d963c80-7044-11ea-9bd0-ef72c2aaf36e.PNG)

   
:two: Full Adder 8 bit
![ScrQ1_2](https://user-images.githubusercontent.com/60509979/77752064-774f6380-7044-11ea-8d15-14255143bfe9.png)


## **SUPPOERT**

Reach out to me at one of the following places!

- Telegram at <a href="https://t.me/BitterOcean" target="_blank">@BitterOcean</a>
- Gmail at <a href="mailto:maryamsaeedmehr@gmail.com" target="_blank">maryamsaeedmehr@gmail.com</a>
