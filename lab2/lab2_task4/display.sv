// This module controls the hex display of the ram
module display(SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, q, rdaddress);
	input logic [9:0] SW;
	input logic [4:0] rdaddress;
	input logic [3:0] q;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	// display the read value
	seg7 read(.val(q), .leds(HEX0));
	
	// display the unit digit of the read address
	seg7 rdaddr(.val(rdaddress[3:0]), .leds(HEX2));
	
	// display the input value
	seg7 in(.val(SW[3:0]), .leds(HEX1));
	
	// display the unit digit of the write address
	seg7 wraddr(.val(SW[7:4]), .leds(HEX4));
	
	always_comb begin
	   // display the ten digit of the write address
		if (SW[8] == 1)
			HEX5 = 7'b1111001; // 1
		else
			HEX5 = 7'b1000000; // 0
		// display the ten digit of the read address
		if (rdaddress[4] == 1)
			HEX3 = 7'b1111001; // 1
		else
			HEX3 = 7'b1000000; // 0
	end
endmodule
