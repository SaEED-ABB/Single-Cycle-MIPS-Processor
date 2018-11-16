
module shift_left2_32bit(a, 
						shifted_a);
	input wire[31:0] a;
	output wire[31:0] shifted_a;

	assign shifted_a = {a[29:0], 2'b00};

endmodule // shift_left2_32bit 
