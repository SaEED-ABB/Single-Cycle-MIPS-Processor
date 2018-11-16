
`define OP_AND 3'b000
`define OP_OR  3'b001
`define OP_XOR 3'b011  // by convention
`define OP_ADD 3'b010
`define OP_SUB 3'b110
`define OP_SLT 3'b111

module alu(ALUOperation, a, b, 
			zero, ALUResult);
	input wire[2:0] ALUOperation;
	input wire[31:0] a, b;
	output wire zero;
	output wire[31:0] ALUResult;
	
	assign ALUResult = (ALUOperation == `OP_ADD) ? a + b :
						(ALUOperation == `OP_SUB) ? a - b :
						(ALUOperation == `OP_AND) ? a & b :
						(ALUOperation == `OP_OR) ? a | b :
						(ALUOperation == `OP_XOR) ? a ^ b :
						(ALUOperation == `OP_SLT) ? ((a < b) ? 32'b1 : 32'b0) :
						32'bx;

	assign zero = (ALUResult == 32'b0) ? 1'b1 : 1'b0;
	
endmodule // alu