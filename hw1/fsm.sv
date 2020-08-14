module fsm(in, clk, out);
	input logic in, clk;
	output logic out;
	enum {s0, s1, s2, s3, s4} ps, ns;
	
	always_comb begin
		case(ps)
			s0: if(in) ns = s4;
				 else ns = s3;
			s1: if(in) ns = s4;
				 else ns = s1;
			s2: if(in) ns = s0;
				 else ns = s2;
			s3: if(in) ns = s2;
				 else ns = s1;
			s4: if(in) ns = s3;
			    else ns = s2;
		endcase
	end
	
	assign out = in & (ps != s4);
	
	always_ff@(posedge clk) begin
		ps <= ns;
	end
endmodule

module fsmTestBench();
	logic in, out, clk;
	fsm test(in, clk, out);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		in <= 0; @(posedge clk);
					@(posedge clk);
					@(posedge clk);
		in <= 1; @(posedge clk);
					@(posedge clk);
					@(posedge clk);
		in <= 0; @(posedge clk);
					@(posedge clk);
					@(posedge clk);
		in <= 1; @(posedge clk);
					@(posedge clk);
					@(posedge clk);
		in <= 0; @(posedge clk);
					@(posedge clk);
					@(posedge clk);
		in <= 1; @(posedge clk);
					@(posedge clk);
					@(posedge clk);
		in <= 0; @(posedge clk);
					@(posedge clk);
					@(posedge clk);
		in <= 1; @(posedge clk);
					@(posedge clk);
					@(posedge clk);
		in <= 0; @(posedge clk);
					@(posedge clk);
					@(posedge clk);
		in <= 1; @(posedge clk);
					@(posedge clk);
					@(posedge clk);
		$stop;
	end
endmodule
