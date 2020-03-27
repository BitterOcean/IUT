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
