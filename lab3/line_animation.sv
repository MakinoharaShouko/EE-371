// This module enables the line to move around the screen
// If the reset is on, the system clears the screen and
// sets the line to the initial position
module line_animation (x0, y0, x1, y1, color, clk, reset, new_line);
	output logic [10:0] x0, y0, x1, y1;
	input logic reset, clk;
	output logic color, new_line;
	logic x1_inc;
	logic x0_inc;
	
	logic [20:0] count;  // counter used to add delay
	
	enum {res, refresh, draw} ps;
	
	always_ff@(posedge clk) begin
		// draw the line
		if (ps == draw) begin
			color <= 1;
			// counter reaches max or reset, refresh screen
			// counter back to 0
			if (count == 90000 || reset) begin
				count <= 0;
				ps <= refresh;
				new_line <= 1;
			end
			// increases counter, keepdrawing
			else begin
				count <= count + 1;
				new_line <= 0;
			end
		end
		// refreshes the screen
		if (ps == refresh) begin
			color <= 0;
			// counter reaches maximum, next stage
			// counter back to 0
			if (count == 90001) begin
				count <= 0;
				new_line <= 1;
				if (reset)
					ps <= res;
				else
					ps <= draw;
				// updates the end points of the line
				if (x1_inc && x1 < 639)
					x1 <= x1 + 1;
				else if (x1 > 0)
					x1 <= x1 - 1;
				if (x0_inc && x0 < 639)
					x0 <= x0 + 1;
				else if (x0 > 0)
					x0 <= x0 - 1;
				if (x1 == 0)
					x1_inc <= 1;
				if (x1 == 639)
					x1_inc <= 0;
				if (x0 == 0)
					x0_inc <= 1;
				if (x0 == 639)
					x0_inc <= 0;
			end
			else begin
				count <= count + 1;
				new_line <= 0;
			end
		end
		// reset the end points of the line
		// set counter to 0
		// prepare to draw
		if (ps == res) begin
			color <= 0;
			x0 <= 0;
			y0 <= 0;
			x1 <= 639;
			y1 <= 479;
			x0_inc <= 1;
			x1_inc <= 0;
			new_line <= 1;
			count <= 0;
			if (~reset)
				ps <= draw;
		end
	end
endmodule

// tests the previous module
module line_animation_testbech ();
	logic [10:0] x0, y0, x1, y1;
	logic color, reset, clk, new_line;
	
	line_animation la (.*);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
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
		//$stop;
	end
endmodule
