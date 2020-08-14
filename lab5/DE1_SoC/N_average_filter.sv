// writes input data divided by the size of a fifo into the fifo
// accumulates the input data, if the fifo is full, reads from the
// fifo and subtract the read value form the accumulation
// outputs the accumulation result 
module N_average_filter #(ADDR_WIDTH = 3) (data_in, clk, read, reset, data_out);
	input logic signed [23:0] data_in;  // input
	input logic clk, read, reset;
	output logic signed [23:0] data_out;  // output
	
	logic rd, wr, empty, full;
	logic signed [23:0] r_data, w_data;
	
	// s1: wait for read signal to read
	// s2: wait for read signal to go back to 0 & hold the value
	enum {s1, s2} ps, ns;
	assign w_data = data_in >>> ADDR_WIDTH;
	
	// uses a fifo buffer to store the data to calculate average from	
	fifo #(24, ADDR_WIDTH) f (.clk, .reset, .rd, .wr, .w_data, .empty,
									  .full, .r_data);
	
	always_comb begin
		if (read) ns = s2;
		else ns = s1;
	end
									  
	// reads when the fifo is full
	assign rd = full && (ps == s1) && read;
	// writes when read new data
	assign wr = (ps == s1) && read;
	
	always_ff@(posedge clk) begin
		if (reset) begin // resets the sum at reset
			ps <= s1;
			data_out <= 0;
		end
		else begin
			// updates the output one clock cycle after
			// the signal to deal with the delay from the fifo
			if (ps == s2 && ~read) begin
				if (full)
					data_out <= w_data + data_out - r_data;
				else
					data_out <= w_data + data_out;
			end			
			ps <= ns;
		end
	end
endmodule

// tests the previous module
module N_average_filter_testbench ();
	logic signed [23:0] data_in, data_out;
	logic clk, reset, read;
	
	N_average_filter naf (.*);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; read <= 0;													  	 @(posedge clk);
		reset <= 0;	read <= 1; data_in <= 20; @(posedge clk);
						read <= 0;														 @(posedge clk);
						read <= 1; data_in <= 30; @(posedge clk);
						read <= 0;														 @(posedge clk);
						read <= 1; data_in <= 100; @(posedge clk);
						read <= 0; 														 @(posedge clk);
						read <= 1; data_in <= 40; @(posedge clk);
						read <= 0;														 @(posedge clk);
						read <= 1; data_in <= 30; @(posedge clk);
						read <= 0;														 @(posedge clk);
						read <= 1; data_in <= 25; @(posedge clk);
						read <= 0; 														 @(posedge clk);
						read <= 1; data_in <= 50; @(posedge clk);
						read <= 0; 														 @(posedge clk);
						read <= 1; data_in <= 60; @(posedge clk);
						read <= 0; 														 @(posedge clk);
						read <= 1; data_in <= 70; @(posedge clk);
						read <= 0; 														 @(posedge clk);
						read <= 1; data_in <= 80; @(posedge clk);
						read <= 0; 														 @(posedge clk);
						read <= 1; data_in <= 90; @(posedge clk);
						read <= 0; 														 @(posedge clk);
						read <= 1; data_in <= 100; @(posedge clk);
						read <= 0; 														 @(posedge clk);
						read <= 1; data_in <= 0; @(posedge clk);
						read <= 0;                                          @(posedge clk);
						read <= 1; data_in <= 50; @(posedge clk);
						read <= 0;														 @(posedge clk);
						read <= 1; data_in <= 70; @(posedge clk);
						read <= 0;                                          @(posedge clk);
		$stop;
	end
endmodule
