# Sequence Detector
![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)
![Builed](https://img.shields.io/azure-devops/build/totodem/8cf3ec0e-d0c2-4fcd-8206-ad204f254a96/2?style=flat)
![License](https://img.shields.io/packagist/l/doctrine/orm)
![language](https://img.shields.io/badge/language-verilog-orange)

`Author : Maryam Saeedmehr`   
`Language : verilog`

<p align="center">
<img src="https://user-images.githubusercontent.com/60509979/77752672-a31f1900-7045-11ea-9eda-8bd3ad3f6cae.png">
</p>
</br>  

## **Solution** :metal::sunglasses:   

```verilog
module seqDetector(input Input_seq,clk, input [1:0] seq_select,
		   output reg seq_detected, output reg [7:0] dseq_number=0);

	parameter [2:0] s0=3'b000,s1=3'b001,s2=3'b010,s3=3'b011,s4=3'b100;
	reg [2:0] current=s0;

	always @(posedge clk) begin
		case(seq_select)
			0:case(current) // 1001
				s0: if(Input_seq) current<=s1;else current<=s0;
				s1: if(Input_seq) current<=s1;else current<=s2;
				s2: if(Input_seq) current<=s1;else current<=s3;
				s3: if(Input_seq) current<=s4;else current<=s0;
				s4: if(Input_seq) current<=s1;else current<=s2;
				endcase
			1:case(current) // 0110
				s0: if(Input_seq) current<=s0;else current<=s1;
				s1: if(Input_seq) current<=s2;else current<=s1;
				s2: if(Input_seq) current<=s3;else current<=s1;
				s3: if(Input_seq) current<=s0;else current<=s4;
				s4: if(Input_seq) current<=s2;else current<=s1;
				endcase
			2:case(current) // 1010
				s0: if(Input_seq) current<=s1;else current<=s0;
				s1: if(Input_seq) current<=s1;else current<=s2;
				s2: if(Input_seq) current<=s3;else current<=s0;
				s3: if(Input_seq) current<=s1;else current<=s4;
				s4: if(Input_seq) current<=s3;else current<=s0;
				endcase
			3:case(current) // 1100
				s0: if(Input_seq) current<=s1;else current<=s0;
				s1: if(Input_seq) current<=s2;else current<=s0;
				s2: if(Input_seq) current<=s2;else current<=s3;
				s3: if(Input_seq) current<=s1;else current<=s4;
				s4: if(Input_seq) current<=s1;else current<=s0;
				endcase
		endcase
	end

	always @(seq_select) begin
		current<=s0;
	end
	always @(seq_detected) begin
		dseq_number<=(seq_detected)?dseq_number+1:dseq_number;
	end
	always @(posedge clk) begin
		seq_detected<=(current==s4)?1:0;
	end
endmodule
```
:heavy_check_mark:   

```verilog
module seqDetector_tb();
	reg Input,clk=0;
	reg [1:0] select=0;
	wire [7:0] count;
	wire detected;

	seqDetector U1 (.Input_seq(Input),.clk(clk),.seq_select(select),.seq_detected(detected),.dseq_number(count));

	always #5 clk=~clk;
	always #7 Input=$random;
	always #100 select=$random;

endmodule
```
  
## **Simulation**
![ScrQ2](https://user-images.githubusercontent.com/60509979/77752917-1aed4380-7046-11ea-99b1-8e89ed47d77c.png)


## **SUPPOERT**

Reach out to me at one of the following places!

- Telegram at <a href="https://t.me/BitterOcean" target="_blank">@BitterOcean</a>
- Gmail at <a href="mailto:maryamsaeedmehr@gmail.com" target="_blank">maryamsaeedmehr@gmail.com</a>
