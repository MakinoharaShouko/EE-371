// This module utilizes a 32x4 ram to store data
// The user can access an address throught the switches
// and write a value into that address
// The accessing address, read value and write value
// are displayed on the hex LEDs
module task2(SW, HEX0, HEX2, HEX4, HEX5, KEY);
	input logic [9:0] SW;
	input logic [3:0] KEY;
	output logic [6:0] HEX0, HEX2, HEX4, HEX5;
	logic [3:0] q;
	
	// utilizes the ram
	ram32x4 ram(.address(SW[8:4]), .clock(KEY[0]), .data(SW[3:0]), .wren(SW[9]), .q);
	// displays the address and values
	display dis(SW, q, HEX0, HEX2, HEX4, HEX5);
endmodule

// tests the previous module
`timescale 1 ps / 1 ps
module task2_testbench();
	logic [9:0] SW;
	logic clk;
	logic [6:0] HEX0, HEX2, HEX4, HEX5;
	
	task2 t2(.SW, .HEX0, .HEX2, .HEX4, .HEX5, .KEY({3'b000, clk}));
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		SW <= 0101010011; @(posedge clk);
							   @(posedge clk);
		SW <= 1101010011; @(posedge clk);
		SW <= 0101011111; @(posedge clk);
							   @(posedge clk);
		SW <= 1101011111; @(posedge clk);
		SW <= 0101011111; @(posedge clk);
							   @(posedge clk);
		$stop;
	end
endmodule
