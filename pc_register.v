
module pc_register(clk, rst, pc_in, 
					pc_out);
	input wire clk, rst;
	input reg[31:0] pc_in;
	output wire[31:0] pc_out;

    always @(posedge clk) begin
        pc_out = pc_in;
    end

endmodule // pc_register
