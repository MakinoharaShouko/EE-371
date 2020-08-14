module Ram32x8_4port (
	input logic clk, reset, wr_en, startCyc, // WriteEnable, startCycle(partB)
	input logic [7:0] w_data, // write data
	input logic [4:0] w_addr, // write address
	input logic [4:0] r_addr1, // read port 1 address
	input logic [4:0] r_addr2, // read port 2 address
	input logic [4:0] r_addr3, // read port 3 address
	output logic [7:0] r_port1, // read data output of port 1
	output logic [31:0] r_port2, // read data output of port 2
	output logic [3:0] r_port3 // read data output of port 3
	);
	// I changed this part. Instead of 2 distinct read values
	// I used them as 2 separate addresses
	logic [4:0] rp1a, rp1b; // ReadPort1A, ReadPort1B
	logic [4:0] rp2a, rp2b; // ReadPort2A, ReadPort2B
	logic [4:0] rp3a, rp3b; // ReadPort3A, ReadPort3B
	logic [4:0] ctr, nctr; // Counter, nextCounterValue
	logic [7:0] ram [0:31];
	enum {normal, cycling} ps, ns;
	
	always_comb begin
		if (ps == normal) begin
			if (startCyc)
				ns = cycling;
			else
				ns = normal;
			nctr = ctr + 1;
		end
		else begin
			if (ctr == 31 || reset) begin
				nctr = 0;
				ns = normal;
			end
			else begin
				nctr = ctr + 1;
				ns = cycling;
			end
		end
		rp1a = r_addr1;
		rp2a = r_addr2;
		rp3a = r_addr3;
		rp1b = ctr;
		rp2b = ctr;
		rp3b = 0;
	end
	
	always_ff@(posedge clk) begin
		if (ps == cycling) begin
			ctr <= nctr;
			r_port1 <= ram[rp1b];
			if (ctr % 4 == 0)
				r_port2 <= {ram[rp2b], ram[rp2b + 1], ram[rp2b + 2], ram[rp2b + 3]};
			r_port3 <= ram[rp3b][3:0];
		end
		else begin
			ctr <= 0;
			r_port1 <= ram[rp1a];
			r_port2 <= {ram[rp2a], ram[rp2a + 1], ram[rp2a + 2], ram[rp2a + 3]};
			// read second half (less significant bits)
			r_port3 <= ram[rp3a][3:0];
		end
		if (wr_en)
			ram[w_addr] <= w_data;
		if (reset) begin
			ctr <= 0;
			ps <= normal;
		end
		else
			ps <= ns;
	end
endmodule

module Ram32x8_4port_testbench ();
	logic clk, reset, wr_en, startCyc;
	logic [7:0] w_data, r_port1;
	logic [4:0] w_addr, r_addr1, r_addr2, r_addr3;
	logic [31:0] r_port2;
	logic [3:0] r_port3;
	
	Ram32x8_4port ram(clk, reset, wr_en, startCyc, w_data, w_addr,
							r_addr1, r_addr2, r_addr3, r_port1, r_port2,
							r_port3);
							
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 0; wr_en <= 1; startCyc <= 0; w_data = 8'b11001100; w_addr <= 5'b00000; r_addr1 <= 5'b00000; r_addr2 <= 5'b00000; r_addr3 <= 5'b00000; @(posedge clk);
																																																		@(posedge clk);
															w_data = 8'b11000000; w_addr <= 5'b00001; r_addr1 <= 5'b00001; r_addr2 <= 5'b00001; r_addr3 <= 5'b00001; @(posedge clk);
										startCyc <= 1; w_data = 8'b00000011; w_addr <= 5'b00010; r_addr1 <= 5'b00010; r_addr2 <= 5'b00010; r_addr3 <= 5'b00010; @(posedge clk);
										startCyc <= 0;																																				@(posedge clk);
																						 w_addr <= 5'b00011;																						@(posedge clk);
														   w_data = 8'b11111111; w_addr <= 5'b00100;																						@(posedge clk);
						wr_en <= 0;													 w_data <= 5'b00101;																						@(posedge clk);
																																																		@(posedge clk);
		reset <= 1;																								r_addr1 <= 5'b00011; r_addr2 <= 5'b00011; r_addr3 <= 5'b00011; @(posedge clk);
		reset <= 0;																																													@(posedge clk);
																																																		@(posedge clk);
																													r_addr1 <= 5'b00101; r_addr2 <= 5'b00101; r_addr3 <= 5'b00100; @(posedge clk);
																																																		@(posedge clk);
		$stop;
	end
endmodule

