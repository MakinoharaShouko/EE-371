module divider_modified #(parameter n = 8) (clk, reset, s, DataA, DataB, R, Q, Done);
	input logic clk, reset, s;
	input logic [n-1:0] DataA, DataB;
	output logic [n-1:0] R, Q;
	output logic Done;
	logic z, QTail;
	logic [n-1:0] A, B;
	logic [2 * n - 1:0] extendedA, nExtendedA;
	logic [n - 1:0] count, nQ;
	
	enum {S1, S2, S3} ps, ns;
	
	always_comb	begin
		case (ps)
			S1:	if (s == 0) ns = S1;
				else ns = S2;
			S2:	if (z == 0) ns = S2;
				else ns = S3;
			S3:	if (s == 1) ns = S1;
				else ns = S3;
			//default: ns = 2'bxx;
		endcase
	end
	
	always_ff@(posedge clk, negedge reset) begin
		if (reset == 0)
			ps <= S1;
		else
			ps <= ns;
			
		case (ps)
			S1: begin
				 extendedA[n - 1:0] <= DataA;
				 extendedA[2*n - 1:n] <= 0;
				 count <= n;
				 Done <= 0;
				 Q <= 0;
				 QTail <= 0;
				 end
			S2: begin
				 count <= count - 1;
				 if (nExtendedA[2 * n - 1:n] >= DataB) begin
					QTail <= 1;
					extendedA[2 * n - 1:n] <= nExtendedA[2 * n - 1:n] - DataB;
				 end
				 else begin
					QTail <= 0;
					extendedA <= nExtendedA;
				 end
				 Q <= nQ;
				 end
			S3: begin
				 Done <= 1;
				 R <= extendedA[2 * n - 1:n];
				 end
		endcase
	end
	
	shiftLeft #(.width(2 * n)) exAShift(extendedA, nExtendedA, 0);
	shiftLeft rShift (Q, nQ, QTail);
	
	assign z = (count == 0);
endmodule

module divider_modified_testbench ();
	logic clk, reset, s;
	logic [7:0] DataA, DataB, R, Q;
	logic Done;
	
	divider_modified d (.*);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 0; s <= 0; DataA <= 20; DataB <= 4; @(posedge clk);
		reset <= 1; s <= 1;									@(posedge clk);
						s <= 0;									@(posedge clk);
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
																   @(posedge clk);
		$stop;
	end
endmodule
