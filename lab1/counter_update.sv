// This module calculates the new counter value
// based on the input signals inc and dec
module counter_update(clk, inc, dec, count, ncount);
	input logic [4:0] count;  // original counter value
	input logic clk, inc, dec;
	output logic [4:0] ncount;  // new counter value
	
	always_comb begin
		if (inc & (count != 25))  // counter haven't reached max and needs to increase
			ncount = count + 1;
		else if (dec & (count != 0))  // counter haven't reached min and needs to decrease
			ncount = count - 1;
		else  // keep the original value
			ncount = count;
	end
endmodule
