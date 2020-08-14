// This module runs a detector at a parking lot.
// When a vehicle passes the two detectors from the entering direction
// the module outputs an enter signal.
// When a vehicle passes the two detectors from the exiting direction
// the module outputs an exiting signal.
module detectors(clk, a, b, enter, exit);
	input logic clk, a, b;
	output logic enter, exit;
	enum {noCar, exit1, exit2, exit3, enter1, enter2, enter3} ps, ns;
	
	always_comb begin
		case(ps)
			noCar: if (a & ~b) ns = enter1;  // vehicle starts entering
					 else if (b & ~a) ns = exit1;  // vehicle starts exitiing
					 else ns = noCar;  // nothing happens
			exit1: if (b & a) ns = exit2;  // the vehicle passes both detectors
					 else if (b & ~a) ns = exit1;  // hold
					 else ns = noCar;  // pedestrian pass
			exit2: if (a & ~b) ns = exit3;  // passes the detector at the entrance side
					 else if (b & a) ns = exit2;  // hold
					 else ns = noCar;  // pedestrian pass
			exit3: if (b & ~a) ns = exit1;  // a vehicle follows immediately after
					 else ns = noCar;  // car exits the lot
			enter1: if (a & b) ns = enter2;  // the vehicle passes both detectors
					  else if (a & ~b) ns = enter1;  // hold
					  else ns = noCar;  // pedestrian pass
			enter2: if (b & ~a) ns = enter3;  // passes detector at the exit side
					  else if (a & b) ns = enter2;  // hold
					  else ns = noCar;  // pedestrian
			enter3: if (a & ~b) ns = enter1;  // a vehicle follows immediately after
					  else ns = noCar;  // car enters the lot
		endcase
	end
	
	assign enter = ps == enter3;  // gives enter signal when a vehicle enters
	assign exit = ps == exit3;  // gives exit signal when a vehicle exits
	
	always_ff@(posedge clk) begin
		ps <= ns;
	end
endmodule

// This module tests the previous module under different scenarios.
module detectors_testbench();
	logic clk, a, b, enter, exit;
	detectors d(clk, a, b, enter, exit);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		a <= 0; b <= 0; @(posedge clk);
		a <= 1;			 @(posedge clk);
				  b <= 1; @(posedge clk);
		a <= 0;			 @(posedge clk);
				  b <= 0; @(posedge clk);
							 @(posedge clk);
				  b <= 1; @(posedge clk);
		a <= 1;			 @(posedge clk);
				  b <= 0; @(posedge clk);
		a <= 0; b <= 1; @(posedge clk);
		a <= 1;			 @(posedge clk);
				  b <= 0; @(posedge clk);
		a <= 0; 			 @(posedge clk);
							 @(posedge clk);
		$stop;
	end
endmodule
