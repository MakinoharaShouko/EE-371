// increment every bit of the counter if a new input is given
// when the update button is pressed
module counter (count, clk, reset);
	logic [4:0]ncount;
	input logic clk, reset;
	output logic [4:0]count;
	logic [4:0]temp;
	genvar i;

	always_comb begin
		// increment the last two bits of the counter
		ncount[0] = ~count[0];
		ncount[1] = count[1] ^ count[0];
	end
	
	generate
		for(i = 2; i <= 4; i ++) begin: _COUNT_
		// update other bits
			counterLogic #(i) cl(.count(count[i:0]), .ncount(ncount[i]));
		end
	endgenerate

	// feed the updated version to the counter 
	always_ff@(posedge clk) begin
		if (reset)
			count <= 0;
		else
			count <= ncount;
	end
endmodule
