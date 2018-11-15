
module datapath(clk, rst, regDst, branch, bne, memRead, memWrite, memToReg, ALUSrc, ALUOp, regWrite, regWriteDataSrc, jump, link, multLoad,
				zero, instOpcode, instFunc);
	input wire clk, rst;
	input wire[1:0] regDst, ALUOp, regWriteDataSrc, jump;
	input wire branch, bne, memRead, memWrite, memToReg, ALUSrc, regWrite, link, multLoad;
	output wire zero;
	output wire[5:0] instOpcode, instFunc;



endmodule // datapath