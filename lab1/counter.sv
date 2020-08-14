// This module includes a counter that would
// count up or down according to the input signals.
// The counter cannot exceed the maximum of 25
// and cannot goes below a minimum of 0.
module counter(clk, reset, inc, dec, count);
	input logic clk, reset, inc, dec;
	output logic [4:0] count;
	logic [4:0] ncount;
	
	counter_update cu(clk, inc, dec, count, ncount);
	
	always_ff@(posedge clk) begin
		if (reset)
			count <= 0;  // reset counter to initial value(0)
		else
			count <= ncount;  // update counter value
	end
endmodule

// This module tests the previous module under different inputs
module counter_testbench();
	logic clk, reset, inc, dec;
	logic [4:0] count;
	counter c(clk, reset, inc, dec, count);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		inc <= 0; dec <= 0; reset <= 1; @(posedge clk);
								  reset <= 0; @(posedge clk);
		// keep incrementing the counter value and see if it exceeds the maximum
		inc <= 1; 			  				  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
   											  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
	// keep decrementing the counter value and see if it goes below the minimum
	inc <= 0; dec <= 1;					  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
												  @(posedge clk);
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
