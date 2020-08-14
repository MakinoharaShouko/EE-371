// controls the hex LED display
module display(SW, q, HEX0, HEX2, HEX4, HEX5);
	input logic [9:0] SW;
	input logic [3:0] q;
	output logic [6:0] HEX0, HEX2, HEX4, HEX5;
	
	// address
	address_display ad(.address(SW[8:4]), .LED1(HEX5), .LED2(HEX4));
	// input data
	seg7 in(.val(SW[3:0]), .leds(HEX2));
	// output data
	seg7 out(.val(q), .leds(HEX0));
endmodule

// tests the previous module
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
