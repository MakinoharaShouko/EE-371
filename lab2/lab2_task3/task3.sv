// this module uses the implemented 32x4ram
// and loads it to the FPGA board
// the address and input data are represented
// by the switch combinations
// the write enable is also controlled by the switch
// and the value updates when key 0 is pressed
// the address, input data and read data are
// displayed on the hex LEDs
module task3(SW, HEX0, HEX2, HEX4, HEX5, KEY);
	input logic [9:0] SW;
	input logic [3:0]KEY;
	output logic [6:0] HEX0, HEX2, HEX4, HEX5;
	logic [3:0] q;
	
	ram32x4 ram(.addr(SW[8:4]), .data(SW[3:0]), .wren(SW[9]), .clk(KEY[0]), .q);
	display dis(SW, q, HEX0, HEX2, HEX4, HEX5);
endmodule

// tests the previous module
`timescale 1 ps / 1 ps
module task3_testbench();
	logic [9:0] SW;
	logic clk;
	logic [6:0] HEX0, HEX2, HEX4, HEX5;
	
	task3 t3(.SW(SW), .HEX0(HEX0), .HEX2(HEX2), .HEX4(HEX4), .HEX5(HEX5), .KEY({3'b000, clk}));
	
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
