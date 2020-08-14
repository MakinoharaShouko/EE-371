// This module simulates a parking lot system
// When something passes a detector, the corresponding led would be truned on
// And if a vehicle passes two detectors in sequence,
// the internal counter updates the current number of vehicle in the parking lot
// which would be shown on the hex led displays
// The maximum for vehicles in the lot is 25 and
// when that value is reached the hex display shows "FULL"
// The minimum for vehicles in the lot is 0 and
// when that is reached the hex display show "CLEAR"
module DE1_SoC(CLOCK_50, SW, KEY, GPIO_0, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input logic CLOCK_50;
	input logic [9:0] SW;
	input logic [3:0] KEY;
	output logic [35:0] GPIO_0;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;  // hex displays
	logic [4:0] count;  // counter value
	logic enter, exit;  // enter & exit signals
	
	detectors d(.clk(CLOCK_50), .a(~KEY[3]), .b(~KEY[0]), .enter, .exit);
	counter c(.clk(CLOCK_50), .reset(SW[9]), .inc(enter), .dec(exit), .count);
	
	// displays the value of the counter
	display dis(count, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	
	assign GPIO_0[3] = ~KEY[3];  // turns on led light when key is pressed
	assign GPIO_0[7] = 0;
	assign GPIO_0[18] = ~KEY[0];  // turns on led when key is pressed
	assign GPIO_0[22] = 0;
endmodule

// tests the previous module under different inputs
module DE1_SoC_testbench();
	logic clk;
	logic [9:0] SW;
	logic [3:0] KEY;
	logic [35:0] GPIO_0;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	DE1_SoC ds(clk, SW, KEY, GPIO_0, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		KEY[3] <= 0; KEY[0] <= 0; SW[9] <= 1; @(posedge clk);
										  SW[9] <= 0; @(posedge clk);
						 KEY[0] <= 1;				  @(posedge clk);
		KEY[3] <= 1; 								  @(posedge clk);
						 KEY[0] <= 0;				  @(posedge clk);
		KEY[3] <= 0;								  @(posedge clk);
		KEY[3] <= 1;								  @(posedge clk);
						 KEY[0] <= 1;				  @(posedge clk);
		KEY[3] <= 0;								  @(posedge clk);
						 KEY[0] <= 0;				  @(posedge clk);
		KEY[3] <= 1;								  @(posedge clk);
						 KEY[0] <= 1;				  @(posedge clk);
		KEY[3] <= 0;								  @(posedge clk);
						 KEY[0] <= 0;				  @(posedge clk);
														  @(posedge clk);
														  @(posedge clk);
														  @(posedge clk);
														  @(posedge clk);
														  @(posedge clk);
										  SW[9] <= 1; @(posedge clk);
		$stop;
	end
endmodule
