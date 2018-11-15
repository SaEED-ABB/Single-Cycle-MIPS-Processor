
module data_memory(clk, rst, memRead, memWrite, address, writeData, 
					readData);
	input wire clk, rst;
	input wire memRead, memWrite;
	input wire[31:0] address, writeData;
	output wire[31:0] readData;

	

endmodule // data_memory