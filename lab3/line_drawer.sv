// This module realizes the logic to draw a line
// for the given starting and ending point
// The module walks through every point from the
// two end points at each clock cycle to draw
module line_drawer(
	input logic clk, reset,
	input logic [10:0]	x0, y0, x1, y1, //the end points of the line
	output logic [10:0]	x, y //outputs corresponding to the pair (x, y)
	);
	
	/*
	 * You'll need to create some registers to keep track of things
	 * such as error and direction
	 * Example: */
	logic [11:0] y_diff, x_diff, y_start, x_start, y_end, x_end,
					 y_start1, x_start1, y_end1, x_end1,
					 deltax, deltay, x_temp, y_temp;
	reg signed [11:0] error, nerror;
	logic is_steep, y_dir;
	
	// calculates the absolute value of x and y differences
	// and determines if the line is steep or not
	assign y_diff = (y1 > y0)? (y1 - y0):(y0 - y1);
	assign x_diff = (x1 > x0)? (x1 - x0):(x0 - x1);
	assign is_steep = y_diff > x_diff;
	
	// if the line is steep, switch axis
	assign x_start1 = (is_steep)? y0:x0;
	assign x_end1 = (is_steep)? y1:x1;
	assign y_start1 = (is_steep)? x0:y0;
	assign y_end1 = (is_steep)? x1:y1;
	
	// if the start x is larger than end, switch start and end
	assign x_start = (x_start1 > x_end1)? x_end1:x_start1;
	assign x_end = (x_start1 > x_end1)? x_start1:x_end1;
	assign y_start = (x_start1 > x_end1)? y_end1:y_start1;
	assign y_end = (x_start1 > x_end1)? y_start1:y_end1;
	
	// calculates the difference of the current x and y
	// determines if y is increasing or not
	assign deltax = x_end - x_start;
	assign deltay = (y_start > y_end)? (y_start - y_end):(y_end - y_start);
	assign y_dir = y_start < y_end;
	
	// updates the error value and sees if y needs to increase
	// when error becomes non-negative, increases y and set error
	// back to the initial condition
	always_comb begin
		if (error >= 0)
			nerror = error - deltax + deltay;
		else
			nerror = error + deltay;
	end
	
	always_ff@(posedge clk) begin
	/*
	 * Your code here
	 */
		// reset the x y value to the start
		// set up the intial error value
		if (reset) begin
			y_temp <= y_start;
			x_temp <= x_start;
			error <= -(deltax / 2);
		end
		// keep increasing x and y
		else if (x_temp <= x_end) begin
			// if steep, switch the output
			if (is_steep) begin
				x <= y_temp;
				y <= x_temp;
			end
			else begin
				x <= x_temp;
				y <= y_temp;
			end
			// increase y when error value is positive
			if (error >= 0) begin
				if (y_dir)
					y_temp <= y_temp + 1;
				else
					y_temp <= y_temp - 1;
			end
			error <= nerror;
			x_temp <= x_temp + 1;
		end
	end
endmodule

// This module tests the previous module
module line_drawer_testbench();
	logic clk, reset;
	logic [10:0] x0, y0, x1, y1, x, y;
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	line_drawer ld (.*);
	
	initial begin
		reset <= 1;	x0 <= 0; x1 <= 600; y0 <= 0; y1 <= 400; @(posedge clk);
		reset <= 0; 													 @(posedge clk);
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
																			@(posedge clk);
																			@(posedge clk);
																			@(posedge clk);
																			@(posedge clk);														@(posedge clk);
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
		$stop;
	end
endmodule
