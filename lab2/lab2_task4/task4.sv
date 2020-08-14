// This module downloads a two port ram onto the FPGA board
// one port is used for reading. The reading address changes
// about every 1 second and scrolls through all addresses,
// its value is displayed on HEX3-2
// the read value is displayed on HEX0
// write address and write values are controlled by the switches
// The write address is displayed on HEX5-4 and the write value on
// HEX1. If the write switch is enabled, write value will be written
// to the specified write address
// when the reset key is pushed, the read address returns to 0
module task4(CLOCK_50, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY);
	input logic [9:0] SW;
	input logic [3:0] KEY;
	input logic CLOCK_50;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [3:0] q, data;
	logic [4:0] rdaddress, wraddress;
	logic [31:0] clk;
	logic wren;
	
	// create a slower clock from 50M Hz clock
	clock_divider div(CLOCK_50, clk);
	// runs ram function
	ram32x4 ram(.clock(CLOCK_50), .data, .rdaddress, .wraddress, .wren, .q);
	// display read and write information
	display dis(SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, q, rdaddress);
	
	// control write address and value from the switches
	always_comb begin
		wraddress = SW[8:4];
		data = SW[3:0];
		wren = SW[9];
	end
	
	// update read address
	always_ff@(posedge clk[25]) begin
		if (~KEY[0] || rdaddress == 31)
			rdaddress <= 0;
		else
			rdaddress <= rdaddress + 1;
	end
endmodule

// This module chooses at what frequency the clock is running
module clock_divider (clock, divided_clocks);
    input logic clock;
    output logic [31:0] divided_clocks;
    initial begin
		divided_clocks <= 0;
    end
    always_ff @(posedge clock) begin
		divided_clocks <= divided_clocks + 1;
	 end
endmodule
/*
// Tests the previous module
`timescale 1 ps / 1 ps
module task4_testbench();
	logic clk;
	logic [9:0] SW; 
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [3:0] KEY;

	task4 t4(.CLOCK_50(clk), .SW, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		SW <= 10'b0000111100; KEY[0] <= 0; @(posedge clk);			 
									 KEY[0] <= 1; @(posedge clk);
		SW <= 10'b1000111100;				  @(posedge clk);
		SW <= 10'b0000111100;				  @(posedge clk);
		SW <= 10'b0000111010;				  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
									 KEY[0] <= 0; @(posedge clk);
													  @(posedge clk);
		$stop;
	end
endmodule
*/