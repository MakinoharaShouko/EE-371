// This module implements a 32x4ram
// The ram data can be accessed by giving
// a reading specific address
// if the write enable is on, the input data
// can be written to the given address
module ram32x4(addr, data, wren, clk, q);
	input logic [4:0] addr;  // accessing address
	input logic [3:0] data;  // write data
	input logic wren, clk;
	output logic [3:0] q;  // read data
	logic [3:0] ram [0: 31];  // memory storage
	
	always_ff@(posedge clk) begin
		if (wren)  // writes to the address
			ram[addr] <= data;
		// reads from the address
		q <= ram[addr];
	end
endmodule

// tests the previous module
module ram32x4_testbench();
	logic [4:0] addr;
	logic [3:0] data, q;
	logic clk, wren;
	
	ram32x4 ram(addr, data, wren, clk, q);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		wren <= 0; addr <= 5'b10101; data <= 4'b0001; @(posedge clk);
		wren <= 1;												 @(posedge clk);
		wren <= 0; 						  data <= 4'b1010; @(posedge clk);
					  addr <= 5'b11011;						 @(posedge clk);
		wren <= 1;												 @(posedge clk);
		wren <= 0;						  data <= 4'b1111; @(posedge clk);
																	 @(posedge clk);
		$stop;
	end
endmodule
