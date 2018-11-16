
module alu(ALUOperation, a, b, 
			zero, ALUResult);
	input wire[2:0] ALUOperation;
	input wire[31:0] a, b;
	output wire zero;
	output wire[31:0] ALUResult;
	
	assign ALUResult = (ALUOperation == 3'b010) ? a + b :
						(ALUOperation == 3'b110) ? a - b :
						(ALUOperation == 3'b000) ? a & b :
						(ALUOperation == 3'b001) ? a | b :
						(ALUOperation == 3'b111) ? a - b :
						32'bx;

	assign zero = (ALUOperation == 3'b111 && ALUResult == 32'b0) ? 1'b1 : 1'b0;
	
endmodule // alu