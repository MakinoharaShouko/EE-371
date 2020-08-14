// This module displays the value on the hex led display
module seg7(val, leds);
	input logic [4:0] val;
	output logic [6:0] leds;
	
	always_comb begin case
	(val)
	//          Light: 6543210
		5'b00000: leds = 7'b1000000; // 0
		5'b00001: leds = 7'b1111001; // 1
		5'b00010: leds = 7'b0100100; // 2
		5'b00011: leds = 7'b0110000; // 3
		5'b00100: leds = 7'b0011001; // 4
		5'b00101: leds = 7'b0010010; // 5
		5'b00110: leds = 7'b0000010; // 6
		5'b00111: leds = 7'b1111000; // 7
		5'b01000: leds = 7'b0000000; // 8
		5'b01001: leds = 7'b0010000; // 9
		default: leds = 7'bX;   endcase
	end
endmodule
