module flipFlopAdder (clk, x, y, C, S);
	input logic clk, x, y;
	logic Q;
	output logic C, S;
	
	fullAdder fa(.a(x), .b(y), .cin(Q), .sum(S), .cout(C));
	
	always_ff@(posedge clk) begin
		Q <= C;
	end
	
endmodule

module flipFlopAdderTestBench();
	logic clk, x, y, C, S;
	flipFlopAdder ffa(clk, x, y, C, S);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		x <= 0; y <= 0; @(posedge clk);
							 @(posedge clk);
							 @(posedge clk);
		x <= 1;			 @(posedge clk);
							 @(posedge clk);
							 @(posedge clk);
							 @(posedge clk);
							 @(posedge clk);
				  y <= 1; @(posedge clk);
							 @(posedge clk);
							 @(posedge clk);
		x <= 0; y <= 0; @(posedge clk);
							 @(posedge clk);
							 @(posedge clk);
		$stop;
	end
	
endmodule
	