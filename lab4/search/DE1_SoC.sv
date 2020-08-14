// This module runs a binary search system on the FPGA board
// The system would start searching for the binary value input from
// switch 7 to switch 0 when switch 9 is turned on and end at an address
// and display the address on the hex leds unless
// switch 9 goes off or key 0 is pressed
// If the system finds a match in the 32x8 ram, led 9 would be be on
module DE1_SoC (SW, KEY, HEX1, HEX0, LEDR, CLOCK_50);
	input logic [9:0] SW;
	input logic [3:0] KEY;
	input logic CLOCK_50;
	output logic [9:0] LEDR;
	output logic [6:0] HEX1, HEX0;
	logic [4:0] out;

	binary_search bs (.reset(KEY[0]), .clk(CLOCK_50), .s(SW[9]), .in(SW[7:0]), .found(LEDR[9]), .out);
	// Displays the ten's place
	seg7 s1 (.val(out / 10), .leds(HEX1));
	// Displays the unit's place
	seg7 s2 (.val(out % 10), .leds(HEX0));
endmodule

// Tests the previous module
`timescale 1 ps / 1 ps
module DE1_SoC_testbench ();
	logic [9:0] SW, LEDR;
	logic [6:0] HEX1, HEX0;
	logic [3:0] KEY;
	logic clk;
	
	DE1_SoC ds (.SW, .KEY, .HEX1, .HEX0, .LEDR, .CLOCK_50(clk));
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		KEY[0] <= 0; SW[9] <= 0; SW[7:0] <= 8'b00000011; @(posedge clk);
		KEY[0] <= 1; SW[9] <= 1;								 @(posedge clk);
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
		KEY[0] <= 0; SW[9] <= 0; SW[7:0] <= 8'b01100011; @(posedge clk);
		KEY[0] <= 1; SW[9] <= 1;								 @(posedge clk);
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
		KEY[0] <= 0; SW[9] <= 0; SW[7:0] <= 8'b00000000; @(posedge clk);
		KEY[0] <= 1; SW[9] <= 1;								 @(posedge clk);
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
