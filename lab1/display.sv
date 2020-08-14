// This module controls the display on the 6 hex leds
// to show the correct count value;
module display(count, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input logic [4:0] count;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;  // hex displays
	
	seg7 s(.val(count % 10), .leds(HEX0));
	seg7_dec sd(.val_dec(count / 10), .val_dig(count % 10), .leds(HEX1));
	
	
	// control the display of HEX2 TO HEX5
	always_comb begin
		if (count == 0) begin  // min
			HEX5 = 7'b1000110;  // C
			HEX4 = 7'b1000111;  // L
			HEX3 = 7'b0000110;  // E
			HEX2 = 7'b1001000;  // A
		end
		else if (count == 25) begin  // max
				HEX5 = 7'b0001110;  // F
				HEX4 = 7'b1000001;  // U
				HEX3 = 7'b1000111;  // L
				HEX2 = 7'b1000111;  // L
		end
		else begin
			HEX5 = 7'b1111111;  // off
			HEX4 = 7'b1111111;  // off
			HEX3 = 7'b1111111;  // off
			HEX2 = 7'b1111111;  // off
		end
	end
endmodule

// tests the previous module under different inputs
module display_testbench();
	logic [4:0] count;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	display d(count, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	
	initial begin
		count = 0; #10;
		count = 2; #10;
		count = 5; #10;
		count = 7; #10;
		count = 9; #10;
		count = 10; #10;
		count = 13; #10;
		count = 15; #10;
		count = 18; #10;
		count = 22; #10;
		count = 25; #10;
		$stop;
	end
endmodule
