// display the address
module address_display(address, LED1, LED2);
	input logic [4:0] address;
	output logic [6:0] LED1, LED2;
	
	// unit digit
	seg7 s7(.val(address[3:0]), .leds(LED2));
	
	// ten digit
	always_comb begin
		if(address[4] == 1)
			LED1 = 7'b1111001; // 1
		else
			LED1 = 7'b1000000; // 0
	end
endmodule
