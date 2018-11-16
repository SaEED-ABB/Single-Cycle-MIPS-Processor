
module data_memory(clk, rst, memRead, memWrite, address, writeData, 
					readData);
	input wire clk, rst;
	input wire memRead, memWrite;
	input wire[31:0] address, writeData;
	output wire[31:0] readData;


    	reg[7:0] memory[0:4095];
	
	initial begin
		{memory[1003], memory[1002], memory[1001], memory[1000]} = 32'd10;
		{memory[1007], memory[1006], memory[1005], memory[1004]} = 32'd10;
		{memory[1011], memory[1010], memory[1009], memory[1008]} = 32'd10;
		{memory[1015], memory[1014], memory[1013], memory[1012]} = 32'd10;
		{memory[1019], memory[1018], memory[1017], memory[1016]} = 32'd10;
		{memory[1023], memory[1022], memory[1021], memory[1020]} = 32'd10;
		{memory[1027], memory[1026], memory[1025], memory[1024]} = 32'd10;
		{memory[1031], memory[1030], memory[1029], memory[1028]} = 32'd10;
		{memory[1035], memory[1034], memory[1033], memory[1032]} = 32'd10;
		{memory[1039], memory[1038], memory[1037], memory[1036]} = 32'd10;

	end


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
