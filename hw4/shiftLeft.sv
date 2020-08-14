module shiftLeft #(parameter width = 8) (Data, nData, tail);
	input logic [width - 1:0] Data;
	output logic [width - 1:0] nData;
	input logic tail;
	integer k;
	
	always_comb begin
		for (k = width - 1; k > 0; k --)
			nData[k] = Data[k - 1];
		nData[0] = tail;
	end
endmodule
