`timescale 1ns/1ns

module registerFileTB();
    reg clk, regWrite;
    reg[31:0] address;
    reg[31:0] writeData;
    reg[4:0] writeRegister;
    reg[4:0] readRegister1;
    reg[4:0] readRegister2;

    wire[31:0] register1;
    wire[31:0] register2;

    registerFile R(clk, readRegister1, readRegister2, writeRegister, writeData, regWrite, register1, register2);

    initial begin
        clk = 0;
        regWrite = 1;
        writeData = 32'd69;
        writeRegister = 32'd1;
        readRegister1 = 32'd0;
        readRegister2 = 32'd1;
        
        #10
        clk = 1;
        #10
        clk = 0;
	#10

        regWrite = 0;
        writeData = 32'd85;

        #10
        clk = 1;
        #10
        clk = 0;
	#10

        regWrite = 1;
        writeData = 32'd85;
        writeRegister = 32'd3;
        
        #10
        clk = 1;
        #10
        clk = 0;

        
 
        #10
        clk = 1;
        #10
        clk = 0;
        #10

	readRegister1 = 32'd3;

        #10
        clk = 1;
        #10
        clk = 0;
        
    end
endmodule


module memoryTB();
    reg clk, memWrite, memRead;
    reg[31:0] address;
    reg[31:0] writeData;
    wire[31:0] memoryData;

    memory M(clk, address, writeData, memWrite, memRead, memoryData);

    initial begin
        clk = 0;
        address = 32'b0;
        writeData = 32'b10101010101010101010101010101010;
        memWrite = 1;
        memRead = 0;
        
        #10
        clk = 1;
        #10
        clk = 0;
	#10

        address = 32'd4;
        writeData = 32'b01010101010101010101010101010101;
        memWrite = 1;
        memRead = 0;
        
        #10
        clk = 1;
        #10
        clk = 0;
	#10

        address = 32'b0;
        memWrite = 0;
        memRead = 1;
        
        #10
        clk = 1;
        #10
        clk = 0;

        address = 32'd4;
 
        #10
        clk = 1;
        #10
        clk = 0;
    end
endmodule

