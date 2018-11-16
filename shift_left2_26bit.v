
module shift_left2_26bit(a, 
						shifted_a);
	input wire[25:0] a;
	output wire[27:0] shifted_a;

	assign shifted_a = {a[25:0], 2'b00};

endmodule // shift_left2_26bit 