// Code from "FPGA prototyping by SystemVerilog examples" by P. Chu

module reg_file
   #(
    parameter DATA_WIDTH = 8, // number of bits
              ADDR_WIDTH = 2  // number of address bits
   )
   (
    input  logic clk,
    input  logic wr_en,
    input  logic [ADDR_WIDTH-1:0] w_addr, r_addr,
    input  logic [2 * DATA_WIDTH-1:0] w_data,
    output logic [DATA_WIDTH-1:0] r_data
   );

   // signal declaration
   logic [DATA_WIDTH-1:0] array_reg [0:2**ADDR_WIDTH-1];
	logic first;

   // body
   // write operation
   always_ff @(posedge clk)
      if (wr_en)
         {array_reg[w_addr + 1], array_reg[w_addr]} <= w_data;
   // read operation
	assign r_data = array_reg[r_addr];
endmodule

module reg_file_testbench();
	logic clk, wr_en;
	logic [1:0] w_addr, r_addr;
	logic [15:0] w_data;
	logic [7:0] r_data;
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	reg_file rf (.*);
	
	initial begin
		wr_en <= 1; r_addr <= 2'b00; w_addr <= 2'b00; w_data <= 16'b1111111100001010; @(posedge clk);
		wr_en <= 0; 																						@(posedge clk);
						r_addr <= 2'b01; w_addr <= 2'b10; w_data <= 16'b1010111100111100; @(posedge clk);
						r_addr <= 2'b10;												  					@(posedge clk);
						r_addr <= 2'b11;																	@(posedge clk);
		$stop;
	end
endmodule
