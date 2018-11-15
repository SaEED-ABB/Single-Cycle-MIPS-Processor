
module instruction_memory(clk, rst, address, 
							instruction);
	input wire clk, rst;
	input wire[31:0] address;
	output wire[31:0] instruction;

    reg[7:0] instructions[0:4096];

    assign instruction = {instructions[address[11:0]+3], instructions[address[11:0]+2], instructions[address[11:0]+1], instructions[address[11:0]]};

endmodule // instruction_memory
