// This module does binary search for an input value from
// a 32x8 ram and outputs a signal whether the input is found or not
// and a value of the resultant address in the ram
module binary_search #(parameter data_width = 8, addr_width = 5) (reset, clk, s, in, found, out);
	input logic reset, clk, s;
	input logic [data_width - 1:0] in;
	output logic found;
	output logic [addr_width - 1:0] out;
	logic [addr_width - 1:0] addr;
	logic [data_width - 1:0] q;
	logic z;
	
	// The ram to search from
	ram32x8 r (.address(addr), .clock(clk), .data(0), .wren(0), .q);
	// Doing value comparison and updates the current state
	binary_search_control bsc (.*);
	
	// assign output address
	assign out = addr;
	// assign found signal
	assign found = z;
endmodule

// tests the previous module
`timescale 1 ps / 1 ps
module binary_search_testbench ();
	logic reset, clk, s, found;
	logic [4:0] out;
	logic [7:0] in;
	
	binary_search bs (.*);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 0; s <= 0; in <= 8'b00000011; @(posedge clk);
		reset <= 1; s <= 1;							@(posedge clk);
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
		reset <= 0; s <= 0; in <= 8'b01100011; @(posedge clk);
		reset <= 1; s <= 1;							@(posedge clk);
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
		reset <= 0; s <= 0; in <= 8'b11111111; @(posedge clk);
		reset <= 1; s <= 1;							@(posedge clk);
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
