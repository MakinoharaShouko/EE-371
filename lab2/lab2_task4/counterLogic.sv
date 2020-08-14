// increment one signle bit from a counter
module counterLogic #(parameter WIDTH = 1) (count, ncount);
	input logic [WIDTH:0]count;
	output logic ncount;

	always_comb begin
		ncount = count[WIDTH] ^ &count[WIDTH-1:0];
	end
endmodule
