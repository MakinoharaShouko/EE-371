// Listing 7.8
module fifo
   #(
    parameter DATA_WIDTH=8, // number of bits in a word
              ADDR_WIDTH=4  // number of address bits
   )
   (
    input  logic clk, reset,
    input  logic rd, wr,
    input  logic [2 * DATA_WIDTH-1:0] w_data,
    output logic empty, full,
    output logic [DATA_WIDTH-1:0] r_data
   );

   //signal declaration
   logic [ADDR_WIDTH-1:0] w_addr, r_addr;
   logic wr_en, full_tmp;

   // body
   // write enabled only when FIFO is not full
   assign wr_en = wr & ~full_tmp;
   assign full = full_tmp;
   
   // instantiate fifo control unit
   fifo_ctrl #(.ADDR_WIDTH(ADDR_WIDTH)) c_unit
      (.*, .full(full_tmp));

   // instantiate register file
   reg_file 
      #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) f_unit (.*);
endmodule

module fifo_testbench();
	logic clk, reset;
	logic wr, rd;
	logic [15:0] w_data;
	logic empty, full;
	logic [7:0] r_data;
	
	fifo f(.*);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1;																	  @(posedge clk);
		reset <= 0; wr <= 1; rd <= 0; w_data <= 16'b1100110011111111; @(posedge clk);
						wr <= 0;	rd <= 1; w_data <= 16'b1010010111000011; @(posedge clk);
																						  @(posedge clk);
																						  @(posedge clk);
																						  @(posedge clk);
																						  @(posedge clk);
																						  @(posedge clk);
																						  @(posedge clk);
		reset <= 1;				rd <= 0;											  @(posedge clk);
		reset <= 0; wr <= 1; 			w_data <= 16'b0000111111110010; @(posedge clk);
						wr <= 0;	rd <= 1;											  @(posedge clk);
									rd <= 0;											  @(posedge clk);
						wr <= 1;														  @(posedge clk);
																						  @(posedge clk);
																						  @(posedge clk);
																						  @(posedge clk);
																						  @(posedge clk);
																						  @(posedge clk);
																						  @(posedge clk);
																						  @(posedge clk);
																						  @(posedge clk);
																						  @(posedge clk);
																						  @(posedge clk);
		$stop;
	end
endmodule
