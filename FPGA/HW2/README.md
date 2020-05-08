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
`timescale 1ns / 1ps

module PCounter #(parameter MAX_SIZE = 7,parameter [MAX_SIZE-1:0] p = 59) (
	input enable,
	input clk, 
	input reset, 
	output reg [MAX_SIZE-1:0] cnt_out=0 , 
	output reg out=0
	);

	always @(posedge clk,negedge reset)
	begin : main
		if (reset==0)
			cnt_out <= 0;

		else
		begin
			out <= 0;
			if (enable==1)
			begin
				if (cnt_out < p)
					cnt_out <= cnt_out + 1;
				else
				begin
					out <= 1;
					cnt_out <= 0;
				end
			end
			else
				disable main;																																					
		end
	end

endmodule
```
:heavy_check_mark:   

```verilog
`timescale 1ns / 1ps

module PCounter_tb();

	reg enable=0;
	reg clk=0;
	reg reset=0;
	integer i;
	wire [3:0] cnt_out;
	wire out;

	always #5 clk = ~clk;

	PCounter #(.MAX_SIZE(4),.p(10)) U1 (.enable(enable),.clk(clk),.cnt_out(cnt_out),.out(out),.reset(reset));

	initial 
	begin 
	
		for(i = 0 ; i < 4 ; i = i + 1 )
		begin 
			{enable,reset} = i;
			#50;
			$monitor("ENABLE=%s , RESER=%s Parameter=10 cnt_out=%d" ,enable?"ON":"OFF",reset?"OFF":"ON",cnt_out);
		end
		#100;
		$monitor("----------------Simulation ENDs----------------");
	end
		
endmodule

```  

**Simulation**  

![scrQ1_1](https://user-images.githubusercontent.com/60509979/80210454-0bfbb000-8649-11ea-9dc4-90269a24c167.png)
   
   
 
<p align="center">
<img src="https://user-images.githubusercontent.com/60509979/80210929-df946380-8649-11ea-8ae0-1dc83496459f.png">
</p>
</br>  

## **Solution** :metal::sunglasses:    

- **Day Counter**   

```verilog
`timescale 1ns / 1ps

module DayCounter(
	input enable,
	input clk,
	input reset,
	output [5:0] second,
	output [5:0] minute,
	output [4:0] hour,
	output [4:0] day,
	output [3:0] month,
	output [6:0] year
	);
	// minute and second are maximum 59 => 6 bit
	// hour is maximum 23 and day is maximum 29 => 5 bit
	// month is maximum 11 => 4 bit
	// year is unbounded but e.g. maximum is 99 then it should become a century => 7 bit
	wire year_out,month_out,day_out,hour_out,min_out,sec_out;

	//second
	PCounter #(.MAX_SIZE(6),.p(59)) U0 (.enable(enable),.clk(clk),.cnt_out(second),.out(sec_out),.reset(reset));

	//minute
	PCounter #(.MAX_SIZE(6),.p(59)) U1 (.enable(enable),.clk(sec_out),.cnt_out(minute),.out(min_out),.reset(reset));

	//hour
	PCounter #(.MAX_SIZE(5),.p(23)) U2 (.enable(enable),.clk(min_out),.cnt_out(hour),.out(hour_out),.reset(reset));

	//day
	PCounter #(.MAX_SIZE(5),.p(29)) U3 (.enable(enable),.clk(hour_out),.cnt_out(day),.out(day_out),.reset(reset));

	//month
	PCounter #(.MAX_SIZE(4),.p(11)) U4 (.enable(enable),.clk(day_out),.cnt_out(month),.out(month_out),.reset(reset));

	//year
	PCounter #(.MAX_SIZE(7),.p(99)) U5 (.enable(enable),.clk(month_out),.cnt_out(year),.out(year_out),.reset(reset));

endmodule
```
:heavy_check_mark: 
```verilog
`timescale 1 us/100 ps // clk = 1 MHz

module DayCounter_tb;

	// Inputs
	reg enable;
	reg clk=0;
	reg reset=1;
	integer i;

	// Outputs
	wire [5:0] second;
	wire [5:0] minute;
	wire [4:0] hour;
	wire [4:0] day;
	wire [3:0] month;
	wire [6:0] year;

	// Instantiate the Unit Under Test (UUT)
	DayCounter uut (
		.enable(enable),
		.clk(clk), 
		.reset(reset), 
		.second(second), 
		.minute(minute), 
		.hour(hour), 
		.day(day), 
		.month(month), 
		.year(year)
	);

	always #0.5 clk=~clk;
	
	initial begin
	
		for(i = 0 ; i < 4 ; i = i + 1 )
		begin 
			{enable,reset} = i;
			#50;
			$monitor("ENABLE=%s , RESET=%s , Date and Time : %d/%d/%d - %d:%d:%d",enable?"ON":"OFF",reset?"OFF":"ON",year,month,day,hour,minute,second);
		end
		#100;
		$monitor("---------------------Simulation ENDs---------------------");
		
	end
      
endmodule

```
   
**Simulation**  

![scrQ1_2_1](https://user-images.githubusercontent.com/60509979/80210690-6b59c000-8649-11ea-8172-73b0ee22e66a.png)
![scrQ1_2_2](https://user-images.githubusercontent.com/60509979/80210700-6eed4700-8649-11ea-9170-b372752cadfe.png)


<p align="center">
<img src="https://user-images.githubusercontent.com/60509979/80211000-0f436b80-864a-11ea-9fe7-647e0e1ba933.png">
</p>
</br>  

## **Solution** :metal::sunglasses:    

- **Stopwatch**  

```verilog
`timescale 1ns / 1ps

module Stopwatch(
	input clk, 
	input reset,
	input start, 
	input stop, 
	output [5:0] second,
	output [5:0] minute, 
	output [4:0] hour,
	output [4:0] day, 
	output[3:0] month, 
	output [6:0] year
	);

	reg enable=0;

	DayCounter uu1(
		.enable(enable),
		.clk(clk),
		.reset(reset),
		.second(second),
		.minute(minute),
		.hour(hour),
		.day(day),
		.month(month),
		.year(year)
	);
	
	always @(posedge start or posedge stop)
	begin
	
		if(start==1)
			enable <= 1;
		if(stop==1)
			enable <= 0; // stop has a higher priority
	
	end

endmodule
```
:heavy_check_mark: 
```verilog
`timescale 1us / 1ps

module Stopwatch_tb;

	// Inputs
	reg clk=0;
	reg reset=1;
	reg start=0;
	reg stop=0;
	integer i;

	// Outputs
	wire [5:0] second;
	wire [5:0] minute;
	wire [4:0] hour;
	wire [4:0] day;
	wire [3:0] month;
	wire [6:0] year;

	// Instantiate the Unit Under Test (UUT)
	Stopwatch uut (
		.start(start),
		.stop(stop),
		.clk(clk), 
		.reset(reset), 
		.second(second), 
		.minute(minute), 
		.hour(hour), 
		.day(day), 
		.month(month), 
		.year(year)
	);


	always #0.5 clk=~clk;

	initial begin

		for(i = 0 ; i < 4 ; i = i + 1 )
		begin 
			{start,reset} = i;
			#50;
			$monitor("START : %s - RESET : %s - STOP : %s *** Stopwatch : %d/%d/%d - %d:%d:%d",start?"ON":"OFF",reset?"OFF":"ON",stop?"ON":"OFF",year,month,day,hour,minute,second);
		end
		#500;
		stop = 1;
		$monitor("---------------------Simulation ENDs---------------------");

	end
      
endmodule

```  


**Simulation**  

![scrQ1_3_1](https://user-images.githubusercontent.com/60509979/80210855-becc0e00-8649-11ea-9d7a-6bba2a8223a6.png)


<p align="center">
<img src="https://user-images.githubusercontent.com/60509979/80211315-bde7ac00-864a-11ea-99ce-0a942fe6b98b.png">
</p>
</br>   


## **Solution** :metal::sunglasses:    

- **PWM Generator**    
```verilog
`timescale 1ns / 1ps

module pwm_generator (
	input clk,
	input high_wr,
	input low_wr, 
	input [15:0] data_in, 
	output reg pwm_out=0
	);

	reg [15:0] Low=0;
	reg [15:0] High=0;
	reg [15:0] HighCounter=0;
	reg [15:0] LowCounter=0;
	reg turn=1'bx;// "turn" decides when pwm_out should be 1 and when 0

	always @(posedge clk)
	begin

		if (high_wr)
		begin
			High <= data_in;
			HighCounter <= data_in;
			turn <= 1;
		end

		if (low_wr) 
		begin
			Low <= data_in;
			LowCounter <= data_in;
		end

		if (turn==1) 
		begin : up
			pwm_out <= 1;
			if( HighCounter==1 )
			begin 
				HighCounter <= High;
				turn <= 0;
				disable up;
			end
			HighCounter <= HighCounter - 1 ;
		end

		if (turn==0) 
		begin : down
			pwm_out <= 0;
			if( LowCounter==1 )
			begin 
				LowCounter <= Low;
				turn <= 1;
				disable down;
			end
			LowCounter <= LowCounter - 1 ;
		end

	end

endmodule

```
:heavy_check_mark: 
```verilog
`timescale 1ns / 1ps

module pwm_generator_tb;

	// Inputs
	reg clk=0;
	reg high_wr=0;
	reg low_wr=0;
	reg [15:0] data_in=0;
	reg [6:0] DutyCycle=7'bz;

	// Outputs
	wire pwm_out;

	// Instantiate the Unit Under Test (UUT)
	pwm_generator uut (
		.clk(clk), 
		.high_wr(high_wr), 
		.low_wr(low_wr), 
		.data_in(data_in), 
		.pwm_out(pwm_out)
	);

	always #5 clk=~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		high_wr = 0;
		low_wr = 0;
		data_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		$monitor("High_write = %s , Low_write = %s , Data_in = %d ==>> Duty Cycle = %d percent",high_wr?"ON":"OFF",low_wr?"ON":"OFF",data_in,DutyCycle);
		
		#30	DutyCycle = 10;
			data_in = 1;
			high_wr = 1;
		#10	high_wr = 0;
		#5	data_in = 9;
			low_wr = 1;
		#10	low_wr = 0;


		#200	DutyCycle = 50;
			data_in = 5;
			high_wr = 1;
		#10	high_wr = 0;
			low_wr = 1;
		#10	low_wr = 0;

		#200	DutyCycle = 90;
			data_in = 9;
			high_wr = 1;
		#10	high_wr = 0;
		#5	data_in = 1;
			low_wr = 1;
		#10	low_wr = 0;
		
	end
      
endmodule

```  

**Simulation**  

![scrQ2_1](https://user-images.githubusercontent.com/60509979/80211441-01421a80-864b-11ea-83c4-04b50301e2fd.png)
  
  

<p align="center">
<img src="https://user-images.githubusercontent.com/60509979/80211530-233b9d00-864b-11ea-9d3b-fcb05c7cbc79.png">
<img src="https://user-images.githubusercontent.com/60509979/80211566-32224f80-864b-11ea-974a-7582aa531d3b.png">
</p>
</br>   


## **Solution** :metal::sunglasses:    

- **PWM Detector**    
```verilog
`timescale 1ns / 1ps

module pwm_detector(
	input clk,
	input pwm_in,
	input high_read,
	input low_read, 
	output reg [15:0] data_out=16'bz
	);

	reg [15:0] Low=0;
	reg [15:0] High=0;
	reg [15:0] HighCounter=0;
	reg [15:0] LowCounter=0;

	always @(posedge clk)
	begin
		if (pwm_in==1)
		begin 
			if(Low != LowCounter && HighCounter==0) Low <= LowCounter;
			LowCounter <= 0; 
			HighCounter <= HighCounter + 1; 
		end

		if(pwm_in==0)
		begin 
			if(High != HighCounter && LowCounter==0) High <= HighCounter;
			HighCounter <= 0; 
			LowCounter <= LowCounter + 1; 
		end
	end

	always @(posedge clk)
	begin 
		if (high_read==1)
			data_out <= High;

		else if (low_read==1)
			data_out <= Low;

		else
			data_out <= 16'bz;
	end

endmodule
```  

:heavy_check_mark: 
```verilog
`timescale 1ns / 1ps

module pwm_detector_tb;

	// Inputs
	reg clk=0;
	reg pwm_in=0;
	reg high_read=0;
	reg low_read=0;

	// Outputs
	wire [15:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	pwm_detector uut (
		.clk(clk), 
		.pwm_in(pwm_in), 
		.high_read(high_read), 
		.low_read(low_read), 
		.data_out(data_out)
	);

	always #5 clk=~clk;

	always 
	begin 
		repeat (3) begin #10 pwm_in = 1; #50 pwm_in = 0; end
		repeat (3) begin #50 pwm_in = 1; #10 pwm_in = 0; end
		repeat (3) begin #30 pwm_in = 1; #30 pwm_in = 0; end
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		pwm_in = 0;
		high_read = 0;
		low_read = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		$monitor("%d : Data_Out = %d ==> %s ",$time ,data_out,high_r?"High Value":(low_r?"Low Value":"Not Set"));
		
		#30	high_r = 1;
		#30	high_r = 0;
			low_r = 1;

		#30	low_r = 0;
		#100	high_r = 1;
		#30	high_r = 0;
			low_r = 1;

		#30	low_r = 0;
		#120	high_r = 1;
		#30	high_r = 0;
			low_r = 1;
		#30	low_r = 0;
			high_r = 1;
		#30	high_r = 0;
		
	end
      
endmodule

```  

**Simulation**  

![scrQ2_2](https://user-images.githubusercontent.com/60509979/80211717-6f86dd00-864b-11ea-896a-db7e7a1d0090.png)



## **SUPPOERT**

Reach out to me at one of the following places!

- Telegram at <a href="https://t.me/BitterOcean" target="_blank">@BitterOcean</a>
- Gmail at <a href="mailto:maryamsaeedmehr@gmail.com" target="_blank">maryamsaeedmehr@gmail.com</a>
