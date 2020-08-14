// This module counts the number of "1"s appearing in
// a binary value. The module does not run until a start
// signal is given and would hold the final result unless
// start is set back to 0. Upon reset, the module would
// count the number of "1"s again
module bitCounter #(parameter width = 8, parameter outWidth = 4)
						  (
						   input logic [width - 1:0] in,  // input value to count
							input logic reset, s, clk,
							output logic [outWidth - 1:0] count,  // number of "1"
							output logic Done
						  );
	logic [width - 1:0] A;  // remaining values to count "1"
	
	enum {S1, S2, S3} ps, ns;
	
	always_comb begin
		case (ps)
			S1: if (s) ns = S2;  // start
				 else ns = S1;
			S2: if (Done) ns = S3;
				 else ns = S2;
			S3: if (s) ns = S3;
				 else ns = S1;  // start set back to 0
		endcase
	end
	
	always_ff@(posedge clk) begin
		if (reset)
			ps <= S1;
		else
			ps <= ns;
		
		case (ps)
			S1: begin
			    // initialization
				 A <= in;
				 count <= 0;
				 Done <= 0;
				 end
			S2: begin
			    // if A = 0, there is no more "1" in it
				 Done <= (A == 0);
				 if (A[0] == 1)  // check the last bit
					count <= count + 1;
				 A <= A / 2;  // shift to right by 1 bit
				 end
		endcase
	end
endmodule

// tests the previous module
module bitCounter_testbench ();
	logic [7:0] in;
	logic [3:0] count;
	logic reset, s, clk, Done;
	
	bitCounter b (.*);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; s <= 0; in <= 7'b11010001; @(posedge clk);
		reset <= 0; s <= 1;							@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
		$stop;
	end
endmodule
