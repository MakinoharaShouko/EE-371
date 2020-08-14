// This module contains a system that takes 3 inputs
// and gives 2 outputs that represent the sum of numbers
// corresponded by the 3 inputs
module fullAdder (a, b, cin, sum, cout);

	input logic a, b, cin;  // inputs of the system
	output logic cout, sum;  // outputs of the system
	
	assign sum = a ^ b ^ cin;  // assign value for output sum
	assign cout = (a & b) | (cin & (a ^ b));  // assign value for output cout

endmodule

// This module contains a program that tests the previous
// system with all combinations of inputs
module fullAdder_testbench();
	
	// values used in the test
	logic a, b, cin, sum, cout;
	
	fullAdder dit(a, b, cin, sum, cout);
	
	initial begin  // go through all input combinations
	
		a = 0; b = 0; cin = 0; #10;
						  cin = 1; #10;
				 b = 1; cin = 0; #10;
				        cin = 1; #10;
		a = 1; b = 0; cin = 0; #10;
		              cin = 1; #10;
			    b = 1; cin = 0; #10;
				        cin = 1; #10;
						
		$stop;
		
		end  // initial
		
endmodule
