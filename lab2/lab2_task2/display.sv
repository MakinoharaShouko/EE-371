// Displays the accessing address, read value and
// write value on the hex LEDs
module display(SW, q, HEX0, HEX2, HEX4, HEX5);
	input logic [9:0] SW;
	input logic [3:0] q;
	output logic [6:0] HEX0, HEX2, HEX4, HEX5;
	
	// display accessing address
	address_display ad(.address(SW[8:4]), .LED1(HEX5), .LED2(HEX4));
	// display write value
	seg7 in(.val(SW[3:0]), .leds(HEX2));
	// display read value
	seg7 out(.val(q), .leds(HEX0));
endmodule

// Tests the previous module
module display_testbench();
	logic [9:0] SW;
	logic [3:0] q;
	logic [6:0] HEX0, HEX2, HEX4, HEX5;
	
	display dis(SW, q, HEX0, HEX2, HEX4, HEX5);
	
	initial begin
		q = 4'b0000; SW = 10'b0000000000; #10
		q = 4'b0001; SW = 10'b0101011100; #10
		q = 4'b1010; SW = 10'b0110111101; #10
		$stop;
	end
endmodule
