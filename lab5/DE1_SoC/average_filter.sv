// The module keeps accepting input values and
// outputs the average of the last 8 inputs
module average_filter (reset, read, data_in, data_out, clk);
	input logic signed [23:0] data_in;  // input data
	input logic clk, read, reset;
	output logic signed [23:0] data_out;  // output average
	// previous values
	logic signed [23:0] data1, data2, data3, data4, data5, data6, data7;
	
	// s1: wait to read signal
	// s2: wait for read to go to 0 & hold the value
	enum {s1, s2} ps, ns;
	
	always_comb begin
		if (read) ns = s2;
		else ns = s1;
	end
	
	always_ff@(posedge clk) begin
		// clears all values at reset
		if (reset) begin
			data1 <= 0;
			data2 <= 0;
			data3 <= 0;
			data4 <= 0;
			data5 <= 0;
			data6 <= 0;
			data7 <= 0;
			data_out <= 0;
			ps <= s1;
		end
		// reads one new data at when read goes to 1
		else begin
			if (ps == s1 && read) begin
				data1 <= data_in;
				data2 <= data1;
				data3 <= data2;
				data4 <= data3;
				data5 <= data4;
				data6 <= data5;
				data7 <= data6;
				data_out <= (data_in >>> 3) + (data1 >>> 3) + (data2 >>> 3) + (data3 >>> 3)
								+ (data4 >>> 3) + (data5 >>> 3) + (data6 >>> 3) + (data7 >>> 3);
			end
			ps <= ns;
		end
	end
endmodule

// tests the previous module
module average_filter_testbench ();
	logic signed [23:0] data_in, data_out;
	logic clk, read, reset;
	
	average_filter af (.*);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		read <= 1; data_in <= 1000; @(posedge clk);
		read <= 0;						 @(posedge clk);			 
		read <= 1; data_in <= 2000; @(posedge clk);
		read <= 0;						 @(posedge clk);
		read <= 1; data_in <= 3000; @(posedge clk);
		read <= 0;						 @(posedge clk);
		read <= 1; data_in <= 2000; @(posedge clk);
		read <= 0;						 @(posedge clk);
		read <= 1; data_in <= 4000; @(posedge clk);
		read <= 0;						 @(posedge clk);
		read <= 1; data_in <= 5000; @(posedge clk);
		read <= 0;						 @(posedge clk);
		read <= 1; data_in <= 6000; @(posedge clk);
		read <= 0;						 @(posedge clk);
		read <= 1; data_in <= 7000; @(posedge clk);
		read <= 0;						 @(posedge clk);
		read <= 1; data_in <= 8000; @(posedge clk);
		read <= 0;						 @(posedge clk);
		read <= 1; data_in <= 9000; @(posedge clk);
		read <= 0;	        			 @(posedge clk);
		read <= 1; data_in <= 5000; @(posedge clk);
		read <= 0;						 @(posedge clk);
		read <= 1; data_in <= 4400; @(posedge clk);
		$stop;
	end
endmodule
