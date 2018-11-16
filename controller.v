
/*
instructions have the same opcode:
		- add, sub, and, or, xor, slt, mult, mflo, mfhi, jr

		- addi
		- andi
		- ori
		- xor i

		- lw 
		- sw

		- lui

		- j
		- jal
		- beq
		- bne
*/	


// Opcodes
`define OPCODE_RTYPE    6'b000000
`define OPCODE_ADDI     6'b001000
`define OPCODE_ANDI     6'b001100
`define OPCODE_BEQ      6'b000100
`define OPCODE_BNE      6'b000101
`define OPCODE_LW       6'b100011
`define OPCODE_ORI      6'b001101
`define OPCODE_XORI		6'b001110
`define OPCODE_SW       6'b101011
`define OPCODE_JAL      6'b000011
`define OPCODE_J        6'b000010
`define OPCODE_LUI		6'b001111

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


module controller(clk, rst, zero, instOpcode, instFunc,  
				regDst, branch, bne, memRead, memWrite, memToReg, ALUSrc, ALUOp, regWrite, regWriteDataSrc, jump, link, multLoad);
	input wire clk, rst;
	input wire zero;
	input wire[5:0] instOpcode, instFunc;
	output reg[1:0] regDst, ALUOp, regWriteDataSrc, jump;
	output reg branch, bne, memRead, memWrite, memToReg, ALUSrc, regWrite, link, multLoad;

	always @(instOpcode, instFunc) begin
		{regDst, ALUOp, regWriteDataSrc, jump, branch, bne, memRead, memWrite, memToReg, ALUSrc, regWrite, link, multLoad} = 17'bx;
		case (instOpcode)
			`OPCODE_RTYPE: begin
				regDst <= 2'b01;
				ALUSrc <= 0;
				memToReg <= 0;
				regWrite <= 1;
				memRead <= 0;
				memWrite <= 0;
				branch <= 0;
				ALUOp <= 2'b10;
				jump <= 2'b00;
				regWriteDataSrc <= 2'b00;
				link <= 0;
				bne <= 0;
				multLoad <= 0;

				case (instFunc)
					`FUNC_JR: begin
						// regDst <= 2'b00;
						// ALUSrc <= 1;
						// memToReg <= 1;
						regWrite <= 0;
						memRead <= 0;
						memWrite <= 0;
						// branch <= 0;
						// ALUOp <= 2'b00;
						jump <= 2'b10;
						// regWriteDataSrc <= 2'b00;
						// link <= 0;
						// bne <= 0;
						multLoad <= 0;
					end
					`FUNC_MFLO: begin
						regDst <= 2'b01;
						// ALUSrc <= 1;
						// memToReg <= 1;
						regWrite <= 1;
						memRead <= 0;
						memWrite <= 0;
						branch <= 0;
						// ALUOp <= 2'b00;
						jump <= 2'b00;
						regWriteDataSrc <= 2'b01;
						// link <= 0;
						bne <= 0;
						multLoad <= 0;
					end
					`FUNC_MFHI: begin
						regDst <= 2'b01;
						// ALUSrc <= 1;
						// memToReg <= 1;
						regWrite <= 1;
						memRead <= 0;
						memWrite <= 0;
						branch <= 0;
						// ALUOp <= 2'b00;
						jump <= 2'b00;
						regWriteDataSrc <= 2'b10;
						// link <= 0;
						bne <= 0;
						multLoad <= 0;
					end

					`FUNC_MULT: begin
						// regDst <= 2'b01;
						// ALUSrc <= 0;
						// memToReg <= 0;
						regWrite <= 0;
						memRead <= 0;
						memWrite <= 0;
						branch <= 0;
						// ALUOp <= 2'b10;
						jump <= 2'b00;
						// regWriteDataSrc <= 2'b00;
						link <= 0;
						bne <= 0;
						multLoad <= 1;
					end
				endcase
			end
			`OPCODE_LW: begin
				regDst <= 2'b00;
				ALUSrc <= 1;
				memToReg <= 1;
				regWrite <= 1;
				memRead <= 1;
				memWrite <= 0;
				branch <= 0;
				ALUOp <= 2'b00;
				jump <= 2'b00;
				regWriteDataSrc <= 2'b00;
				link <= 0;
				bne <= 0;
				multLoad <= 0;
			end
			`OPCODE_SW: begin
				// regDst <= 2'b01;
				ALUSrc <= 1;
				// memToReg <= 0;
				regWrite <= 0;
				memRead <= 0;
				memWrite <= 1;
				branch <= 0;
				ALUOp <= 2'b00;
				jump <= 2'b00;
				// regWriteDataSrc <= 2'b00;
				// link <= 0;
				bne <= 0;
				multLoad <= 0;
			end
			`OPCODE_BEQ: begin
				// regDst <= 2'b01;
				ALUSrc <= 0;
				// memToReg <= 0;
				regWrite <= 0;
				memRead <= 0;
				memWrite <= 0;
				branch <= 1;
				ALUOp <= 2'b01;
				jump <= 2'b00;
				// regWriteDataSrc <= 2'b00;
				// link <= 0;
				bne <= 0;
				multLoad <= 0;
			end
			`OPCODE_BNE: begin
				// regDst <= 2'b01;
				ALUSrc <= 0;
				// memToReg <= 0;
				regWrite <= 0;
				memRead <= 0;
				memWrite <= 0;
				branch <= 0;
				ALUOp <= 2'b01;
				jump <= 2'b00;
				// regWriteDataSrc <= 2'b00;
				// link <= 0;
				bne <= 1;
				multLoad <= 0;
			end
			`OPCODE_J: begin
				// regDst <= 2'b01;
				// ALUSrc <= 0;
				// memToReg <= 0;
				regWrite <= 0;
				memRead <= 0;
				memWrite <= 0;
				// branch <= 0;
				// ALUOp <= 2'b10;
				jump <= 2'b01;
				// regWriteDataSrc <= 2'b00;
				// link <= 0;
				// bne <= 0;
				multLoad <= 0;	
			end
			`OPCODE_JAL: begin
				regDst <= 2'b10;
				// ALUSrc <= 0;
				// memToReg <= 0;
				regWrite <= 1;
				memRead <= 0;
				memWrite <= 0;
				// branch <= 0;
				// ALUOp <= 2'b10;
				jump <= 2'b01;
				regWriteDataSrc <= 2'b00;
				link <= 1;
				// bne <= 0;
				multLoad <= 0;
			end
			`OPCODE_LUI: begin
				regDst <= 2'b01;
				// ALUSrc <= 1;
				// memToReg <= 1;
				regWrite <= 1;
				memRead <= 0;
				memWrite <= 0;
				branch <= 0;
				// ALUOp <= 2'b00;
				jump <= 2'b00;
				regWriteDataSrc <= 2'b11;
				// link <= 0;
				bne <= 0;
				multLoad <= 0;
			end
			`OPCODE_ADDI: begin
				regDst <= 2'b01;
				ALUSrc <= 1;
				memToReg <= 0;
				regWrite <= 1;
				memRead <= 0;
				memWrite <= 0;
				branch <= 0;
				ALUOp <= 2'b10;
				jump <= 2'b00;
				regWriteDataSrc <= 2'b00;
				link <= 0;
				bne <= 0;
				multLoad <= 0;
			end
			`OPCODE_ANDI: begin
				regDst <= 2'b01;
				ALUSrc <= 1;
				memToReg <= 0;
				regWrite <= 1;
				memRead <= 0;
				memWrite <= 0;
				branch <= 0;
				ALUOp <= 2'b10;
				jump <= 2'b00;
				regWriteDataSrc <= 2'b00;
				link <= 0;
				bne <= 0;
				multLoad <= 0;
			end
			`OPCODE_ORI: begin
				regDst <= 2'b01;
				ALUSrc <= 1;
				memToReg <= 0;
				regWrite <= 1;
				memRead <= 0;
				memWrite <= 0;
				branch <= 0;
				ALUOp <= 2'b10;
				jump <= 2'b00;
				regWriteDataSrc <= 2'b00;
				link <= 0;
				bne <= 0;
				multLoad <= 0;
			end
			`OPCODE_XORI: begin
				regDst <= 2'b01;
				ALUSrc <= 1;
				memToReg <= 0;
				regWrite <= 1;
				memRead <= 0;
				memWrite <= 0;
				branch <= 0;
				ALUOp <= 2'b10;
				jump <= 2'b00;
				regWriteDataSrc <= 2'b00;
				link <= 0;
				bne <= 0;
				multLoad <= 0;
			end		
		endcase
	end
endmodule // controller