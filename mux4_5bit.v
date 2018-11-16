
module mux4_5bit(sel, a0, a1, a2, a3, 
					which_a);
	input wire[1:0] sel;
	input wire[4:0] a0, a1, a2, a3;
	output wire[4:0] which_a;

	assign which_a = (sel == 2'b00) ? a0 : 
			(sel == 2'b01) ? a1 : 
			(sel == 2'b10) ? a2 : a3;

endmodule // mux4_5bit