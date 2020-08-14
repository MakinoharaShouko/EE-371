module sync_rom #(parameter width = 8)
	(
	 input logic clk,
	 input logic [2 * width - 1:0] addr,
	 output logic [width - 1:0] data
	);
	
	logic [width - 1:0] rom [0:2 ** (2 * width) - 1];
	logic [width - 1:0] data_reg;
	
	initial
		$readmemh("truthtable8.txt", rom);
		
	always_ff@(posedge clk)
		data_reg <= rom[addr];
		
	assign data = data_reg;
endmodule

/*module sync_rom_testbench_4();
	parameter width = 4;
	logic clk;
	logic [width - 1:0] data;
	logic [2 * width - 1:0] addr;
	
	sync_rom#(.width(width)) sr(clk, addr, data);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		addr <= 8'b00000000; @(posedge clk);
		addr <= 8'b01010101; @(posedge clk);
		addr <= 8'b11010001; @(posedge clk);
		addr <= 8'b11111111; @(posedge clk);
		addr <= 8'b10000111; @(posedge clk);
		addr <= 8'b01110111; @(posedge clk);
		addr <= 8'b10001000; @(posedge clk);
		$stop;
	end
endmodule*/

module sync_rom_testbench_8();
	parameter width = 8;
	logic clk;
	logic [width - 1:0] data;
	logic [2 * width - 1:0] addr;
	
	sync_rom#(.width(width)) sr(clk, addr, data);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		addr <= 16'b0000000000000000; @(posedge clk);
		addr <= 16'b1000000101011101; @(posedge clk);
		addr <= 16'b1101000101001001; @(posedge clk);
		addr <= 16'b1111111111111111; @(posedge clk);
		addr <= 16'b1000011100000011; @(posedge clk);
		addr <= 16'b0111011101111011; @(posedge clk);
		addr <= 16'b1000100000011100; @(posedge clk);
		$stop;
	end
endmodule
