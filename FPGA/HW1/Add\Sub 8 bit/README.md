# Add/Sub 8 bit
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
```verilog
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
```
  :heavy_check_mark: Full Adder 1 bit **testbench**
  ```verilog
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
  ```
  
## **Simulation**
![ScrQ1_3](https://user-images.githubusercontent.com/60509979/77752420-2724d100-7045-11ea-94c5-c7db9c953a71.png)


## **SUPPOERT**

Reach out to me at one of the following places!

- Telegram at <a href="https://t.me/BitterOcean" target="_blank">@BitterOcean</a>
- Gmail at <a href="mailto:maryamsaeedmehr@gmail.com" target="_blank">maryamsaeedmehr@gmail.com</a>
