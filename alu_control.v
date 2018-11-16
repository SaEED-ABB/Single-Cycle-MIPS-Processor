//opcodes
`define OPCODE_RTYPE    6'b000000
`define OPCODE_ADDI     6'b001000
`define OPCODE_ANDI     6'b001100
`define OPCODE_ORI      6'b001101
`define OPCODE_XORI		6'b001110


// ALU operations
`define OP_AND 3'b000
`define OP_OR  3'b001
`define OP_XOR 3'b011  // by convention
`define OP_ADD 3'b010
`define OP_SUB 3'b110
`define OP_SLT 3'b111

// Functions
`define FUNC_ADD     6'b100000
`define FUNC_AND     6'b100100
`define FUNC_JR      6'b001000
`define FUNC_OR      6'b100101
`define FUNC_XOR	 6'b100110
`define FUNC_SLT     6'b101010
`define FUNC_SUB     6'b100010
`define FUNC_MULT	 6'b011000
`define FUNC_MFLO	 6'b010010
`define FUNC_MFHI	 6'b010000

module alu_control(clk, rst, opcode, instFunc, ALUOp, 
					ALUOperation);
	input wire clk, rst;
	input wire[5:0] instFunc;
	input wire[5:0] opcode;
	input wire[1:0] ALUOp;
	output wire[2:0] ALUOperation;


	assign ALUOperation = 	(opcode == `OPCODE_ADDI) ? `OP_ADD :
				(opcode == `OPCODE_ORI) ? `OP_OR :
				(opcode == `OPCODE_XORI) ? `OP_XOR :
				(opcode == `OPCODE_ANDI) ? `OP_AND : 
						((ALUOp == 2'b00) ? `OP_ADD :  
						(ALUOp[0] == 1'b1) ? `OP_SUB : 
						(ALUOp[1] == 1'b1) ? (instFunc == `FUNC_ADD ? `OP_ADD :
											instFunc == `FUNC_SUB ? `OP_SUB :
											instFunc == `FUNC_AND ? `OP_AND :
											instFunc == `FUNC_OR ? `OP_OR :
											instFunc == `FUNC_SLT ? `OP_SLT :
											3'bxxx) :
						3'bxxx);

endmodule // alu_control