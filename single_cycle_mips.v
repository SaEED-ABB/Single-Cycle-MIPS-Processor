
module single_cycle_mips(clk, rst);
	input wire clk, rst;
	wire[1:0] regDst, ALUOp, regWriteDataSrc, jump;
	wire branch, bne, memRead, memWrite, memToReg, ALUSrc, regWrite, link, multLoad;
	wire zero;
	wire[5:0] instOpcode, instFunc;

	datapath DP(.clk(clk), .rst(rst), .regDst(regDst), .branch(branch), .bne(bne), .memRead(memRead), .memWrite(memWrite), .memToReg(memToReg), .ALUSrc(ALUSrc), .ALUOp(ALUOp), .regWrite(regWrite), .regWriteDataSrc(regWriteDataSrc), .jump(jump), .link(link), .multLoad(multLoad), 
				.zero(zero), .instOpcode(instOpcode), .instFunc(instFunc));
	controller CU(.clk(clk), .rst(rst), .zero(zero), .instOpcode(instOpcode), .instFunc(instFunc), 
				.regDst(regDst), .branch(branch), .bne(bne), .memRead(memRead), .memWrite(memWrite), .memToReg(memToReg), .ALUSrc(ALUSrc), .ALUOp(ALUOp), .regWrite(regWrite), .regWriteDataSrc(regWriteDataSrc), .jump(jump), .link(link), .multLoad(multLoad));

endmodule // single_cycle_mips