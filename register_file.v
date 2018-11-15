
module register_file(clk, rst, regWrite, readRegister1, readRegister2, writeRegister, writeData, 
					readData1, readData2);
	input wire clk, rst;
	input wire regWrite;
	input wire[4:0] readRegister1, readRegister2, writeRegister;
	input wire[31:0] writeData;
	output wire[31:0] readData1, readData2;
    
    reg[31:0] regs[0:31];
    assign readData1 = regs[readRegister1];
    assign readData2 = regs[readRegister2];

    always @(posedge clk) begin
        regs[32'b0] = 0;
        if (regWrite) regs[writeRegister] = writeData;
    end
	

endmodule // register_file
