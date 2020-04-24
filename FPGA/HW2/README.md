# P Counter , Day Counter , Stopwatch 
![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)
![Builed](https://img.shields.io/azure-devops/build/totodem/8cf3ec0e-d0c2-4fcd-8206-ad204f254a96/2?style=flat)
![License](https://img.shields.io/packagist/l/doctrine/orm)
![language](https://img.shields.io/badge/language-verilog-orange)

Author : Maryam Saeedmehr  
Language : verilog

<p align="center">
<img src="https://user-images.githubusercontent.com/60509979/80210236-ac9da000-8648-11ea-946f-3fece01f1db4.png">
</p>
</br>  

## **Solution** :metal::sunglasses:    

- **P Counter**  

```verilog
module PCounter #(parameter MAX_SIZE = 7,parameter [MAX_SIZE-1:0] p = 59) (input clk, reset, output reg [MAX_SIZE-1:0] cnt_out=0 , output reg out=0);

	always @(posedge clk,negedge reset)
	begin : main
		if (reset==0) 
		begin
			cnt_out <= 0;
			disable main;
		end

		out <= 0;
		if (cnt_out < p)
			cnt_out <= cnt_out + 1;
		else
		begin
			out <= 1;
			cnt_out <= 0;
		end
	end

endmodule
```
:heavy_check_mark:   

```verilog
module PCounter_tb();

	reg clk=0;
	reg reset=0;
	wire [3:0] cnt_out;
	wire out;

	PCounter #(.MAX_SIZE(4),.p(10)) U1 (.clk(clk),.cnt_out(cnt_out),.out(out),.reset(reset));

	initial 
	begin 
		$monitor("RESER=%s Parameter=10 cnt_out=%d" ,reset?"OFF":"ON",cnt_out);

		     reset = 1 ;
		#70  reset = 0 ;
		#50  reset = 1 ;
		#100 reset = 0 ;
	end
		
	always #5 clk=~clk;

endmodule
```  

**Simulation**  

![scrQ1_1](https://user-images.githubusercontent.com/60509979/80210454-0bfbb000-8649-11ea-9dc4-90269a24c167.png)
   
   

- **Day Counter**   

```verilog
module DayCounter(input clk, reset, output [5:0] second,minute, output [4:0] hour,day, output[3:0] month, output [6:0] year);
	// minute and second are maximum 59 => 6 bit
	// hour is maximum 23 and day is maximum 29 => 5 bit
	// month is maximum 11 => 4 bit
	// year is unbounded but e.g. maximum is 99 then it should become a century => 7 bit
	wire year_out,month_out,day_out,hour_out,min_out,sec_out;

	//second
	PCounter #(.MAX_SIZE(6),.p(59)) U0 (.clk(clk),.cnt_out(second),.out(sec_out),.reset(reset));

	//minute
	PCounter #(.MAX_SIZE(6),.p(59)) U1 (.clk(sec_out),.cnt_out(minute),.out(min_out),.reset(reset));

	//hour
	PCounter #(.MAX_SIZE(5),.p(23)) U2 (.clk(min_out),.cnt_out(hour),.out(hour_out),.reset(reset));

	//day
	PCounter #(.MAX_SIZE(5),.p(29)) U3 (.clk(hour_out),.cnt_out(day),.out(day_out),.reset(reset));

	//month
	PCounter #(.MAX_SIZE(4),.p(11)) U4 (.clk(day_out),.cnt_out(month),.out(month_out),.reset(reset));

	//year
	PCounter #(.MAX_SIZE(7),.p(99)) U5 (.clk(month_out),.cnt_out(year),.out(year_out),.reset(reset));

endmodule
```
:heavy_check_mark: 
```verilog
`timescale 1 us/100 ps // clk = 1 MHz

module DayCounter_tb();

	wire [5:0] second,minute;
	wire [4:0] hour,day;
	wire [3:0] month;
	wire [6:0] year;
	reg clk=0;
	reg reset=1;

	DayCounter U1 (clk,reset,second,minute,hour,day,month,year);

	initial begin
		$monitor("RESET=%s , Date and Time : %d/%d/%d - %d:%d:%d",reset?"OFF":"ON",year,month,day,hour,minute,second);

		#10 reset=0;
		#5 reset=1;
	end
		
	always #0.5 clk=~clk;

endmodule
```
   
**Simulation**  

![scrQ1_2_1](https://user-images.githubusercontent.com/60509979/80210690-6b59c000-8649-11ea-8172-73b0ee22e66a.png)
![scrQ1_2_2](https://user-images.githubusercontent.com/60509979/80210700-6eed4700-8649-11ea-9170-b372752cadfe.png)


  
- **Stopwatch**  

```verilog
module Stopwatch(input clk, reset, start, stop, output [5:0] second,minute, output [4:0] hour,day, output[3:0] month, output [6:0] year);

wire Syncked_clk;
and U0 (Syncked_clk , clk, start, ~stop);
DayCounter U1 (Syncked_clk,reset,second,minute,hour,day,month,year);

endmodule
```
:heavy_check_mark: 
```verilog
`timescale 1 us/100 ps // clk = 1 MHz

module Stopwatch_tb();

	wire [5:0] second,minute;
	wire [4:0] hour,day;
	wire [3:0] month;
	wire [6:0] year;
	reg clk=0;
	reg reset=1;
	reg start=0;
	reg stop=0;

	Stopwatch U1 (clk,reset,start,stop,second,minute,hour,day,month,year);

	initial begin
		$monitor(" START : %s - RESET : %s - STOP : %s *** Stopwatch : %d/%d/%d - %d:%d:%d",start?"ON":"OFF",reset?"OFF":"ON",stop?"ON":"OFF",year,month,day,hour,minute,second);
		#5  start=1; 
		#10 reset=0;
		#3  reset=1;
		#20 stop=1;
	end
		
	always #0.5 clk=~clk;

endmodule
```  


**Simulation**  

![scrQ1_3_1](https://user-images.githubusercontent.com/60509979/80210855-becc0e00-8649-11ea-9d7a-6bba2a8223a6.png)


## **SUPPOERT**

Reach out to me at one of the following places!

- Telegram at <a href="https://t.me/BitterOcean" target="_blank">@BitterOcean</a>
- Gmail at <a href="mailto:maryamsaeedmehr@gmail.com" target="_blank">maryamsaeedmehr@gmail.com</a>
