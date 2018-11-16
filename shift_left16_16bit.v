
module shift_left16_16bit(a, 
						shifted_a);
	input wire[15:0] a;
	output wire[31:0] shifted_a;

	assign shifted_a = {a[15:0], 16'b0};

endmodule // shift_left16_16bit