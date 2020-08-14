// This module counts the number of switches that are on
// within switch 0 to switch 7. Switch 9 is used to start
// counting and when key0 is pressed, the system would count again
// The result would be displayed on HEX0 and LED 9 would light up
// when finishes counting
module DE1_SoC (SW, KEY, LEDR, HEX0, CLOCK_50);
	input logic [9:0] SW;
	input logic [3:0] KEY;
	input logic CLOCK_50;
	output logic [9:0] LEDR;
	output logic [6:0] HEX0;
	logic [3:0] count;
	
	bitCounter b (.in(SW[7:0]), .reset(~KEY[0]), .s(SW[9]), .clk(CLOCK_50), .count, .Done(LEDR[9]));
	seg7 s (.val(count), .leds(HEX0));
endmodule
