
module register_file(clk, rst, regWrite, readRegister1, readRegister2, writeRegister, writeData, 
					readData1, readData2);
	input wire clk, rst;
	input wire regWrite;
	input wire[4:0] readRegister1, readRegister2, writeRegister;
	input wire[31:0] writeData;
	output wire[31:0] readData1, readData2;

	

endmodule // register_file