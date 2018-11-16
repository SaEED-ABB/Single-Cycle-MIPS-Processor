
module multer(a, b, 
				a_mult_b);
	input wire[31:0] a, b;
	output wire[63:0] a_mult_b;

	assign a_mult_b = a * b;

endmodule // multer