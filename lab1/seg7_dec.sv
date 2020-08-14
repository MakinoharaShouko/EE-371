// This module updates the hex led display of
// the ten's place of the counter
// When counter drops to 0 the led would show "R"
module seg7_dec(val_dec, val_dig, leds);
	input logic [4:0] val_dec, val_dig;
	output logic [6:0] leds;
	
	always_comb begin
		if (val_dec == 0) begin
			if (val_dig == 0)
				leds = 7'b0001000;  // R;
			else
				leds = 7'b1111111;  // off
		end
		else if (val_dec == 1)
			leds = 7'b1111001; // 1
		else if (val_dec == 2)
			leds = 7'b0100100; // 2
		else if (val_dec == 3)
			leds = 7'b0110000; // 3
		else if (val_dec == 4)
			leds = 7'b0011001; // 4
		else if (val_dec == 5)
			leds = 7'b0010010; // 5
		else if (val_dec == 6)
			leds = 7'b0000010; // 6
		else if (val_dec == 7)
			leds = 7'b1111000; // 7
		else if (val_dec == 8)
			leds = 7'b0000000; // 8
		else if (val_dec == 9)
			leds = 7'b0010000; // 9
		else
			leds = 7'bX;
	end
endmodule
