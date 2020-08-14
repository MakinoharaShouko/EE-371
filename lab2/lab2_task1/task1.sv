// This module utilizes the built in 32x4ram from
// IP catlog to store data
module task1(address, clock, data, wren, q);
	input logic [4:0] address;  // access address
	input logic [3:0] data;  // input data
	input logic clock, wren;
	output logic [3:0] q;  // read data
	
	ram32x4 ram(address, clock, data, wren, q);
endmodule

// tests the previous module
`timescale 1 ps / 1 ps
module task1_testbench();
	logic [4:0] address;
	logic [3:0] data, q;
	logic clock, wren;
	
	task1 t1(address, clock, data, wren, q);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clock <= 0;
		forever #(CLOCK_PERIOD/2) clock <= ~clock;
	end
	
	initial begin
		address <= 5'b00000; data <= 4'b0001; wren <= 0; @(posedge clock);
																		 @(posedge clock);
														  wren <= 1; @(posedge clock);
																		 @(posedge clock);
														  wren <= 0; @(posedge clock);
		address <= 5'b10100; data <= 4'b1001; wren <= 1; @(posedge clock);
														  wren <= 0; @(posedge clock);
		$stop;
	end
endmodule
