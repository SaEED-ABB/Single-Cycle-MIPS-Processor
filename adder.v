
module adder(a, b, 
			a_plus_b);
	input wire[31:0] a, b;
	output wire[31:0] a_plus_b;

	assign a_plus_b = a + b;

endmodule // adder