
module hi_lo_register(clk, rst, multLoad, hi_lo_in, 
						hi_lo_out);
	input wire clk, rst;
	input wire multLoad;
	input wire[31:0] hi_lo_in;
	output reg[31:0] hi_lo_out;

	always @(posedge clk) begin
		if (multLoad)
			hi_lo_out = hi_lo_in;
	end

endmodule // hi_lo_register