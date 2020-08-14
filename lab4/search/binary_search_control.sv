// This module handles the comparison of the current read value
// from the ram with the target value and updates search address
// based on the comparsion. When the search is finished, the module
// stays at the final state unless the start signal is turned off or reset
// then the module goes back to the initial state
module binary_search_control #(parameter data_width = 8, addr_width = 5) (reset, s, clk, q, in, addr, z);
	input logic s, clk, reset;
	input logic [data_width - 1:0] q, in;
	output logic [addr_width - 1:0] addr;
	output logic z;
	logic [addr_width - 1:0] start, end_point, new_start, new_end, new_addr;
	logic [data_width - 1:0] data;

	// S1: initial state, does nothing
	// S2: read from ram & compare to target
	// S2_5: update search address
	// S3: finish searching
	enum {S1, S2, S2_5, S3} ps, ns;
	
	always_comb begin
		case (ps)
			S1: if (s) ns = S2;  // start search
				 else ns = S1;
			S2: if (q == data || start >= end_point) ns = S3;  // end search
				 else ns = S2_5;  // update address
			S2_5: ns = S2;  // compare
			S3: if (s) ns = S3;
				 else ns = S1;  // goes back to initial state
		endcase
	end
	
	always_comb begin
		z = (q == data);  // signal of whether the value is found or not
		case (ps)
			S1: begin  // initialize the search range and the address
					new_start = 0;
					new_end = 31;
					new_addr = 15;
				 end
			S2: begin  // keeps range and address unchanged
					new_start = start;
					new_end = end_point;
					new_addr = addr;
				 end
			S2_5: begin
						if (z) begin  // found; keeps address and range unchanged
							new_start = start;
							new_end = end_point;
							new_addr = addr;
						end
						else if (q > data) begin  //searches the smaller part
							new_end = addr - 1;
							new_start = start;
							new_addr = (start + addr - 1) / 2;
						end
						else begin  // searches the larger part
							new_end = end_point;
							new_start = addr + 1;
							new_addr = (end_point + addr + 1) / 2;
						end
					end
			S3: begin  // stays at the current address
					new_start = start;
					new_end = end_point;
					new_addr = addr;
				 end
		endcase
	end
	
	always_ff@(posedge clk) begin
		if (~reset)  // negative edge reset
			ps <= S1;
		else
			ps <= ns;
	end
	
	always_ff@(posedge clk) begin
		if (~reset) begin  // reset the search range and the address
			start <= 0;
			end_point <= 31;
			addr <= 15;
		end
		else begin  // updates the search 
			start <= new_start;
			end_point <= new_end;
			addr <= new_addr;
		end
		if (ps == S1)  // loads target value at S1
			data <= in;
	end
endmodule
