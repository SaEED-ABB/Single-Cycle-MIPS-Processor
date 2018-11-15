
module data_memory(clk, rst, memRead, memWrite, address, writeData, 
					readData);
	input wire clk, rst;
	input wire memRead, memWrite;
	input wire[31:0] address, writeData;
	output wire[31:0] readData;

    reg[7:0] memory[0:4095];
    always @(posedge clk) begin
        if (memWrite) begin
            memory[address[11:0]] = writeData[7:0];
            memory[address[11:0]+1] = writeData[15:8];
            memory[address[11:0]+2] = writeData[23:16];
            memory[address[11:0]+3] = writeData[31:24];
        end
    end
    
    assign readData = memRead ? {memory[address[11:0]+3], memory[address[11:0]+2], memory[address[11:0]+1], memory[address[11:0]]} : 32'b00000000000000000000000000000000;

endmodule // data_memory
