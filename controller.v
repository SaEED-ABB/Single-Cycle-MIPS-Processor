
module controller(clk, rst, zero, instOpcode, instFunc,  
				regDst, branch, bne, memRead, memWrite, memToReg, ALUSrc, ALUOp, regWrite, regWriteDataSrc, jump, link, multLoad);
	input wire clk, rst;
	input wire zero;
	input wire[5:0] instOpcode, instFunc;
	output wire[1:0] regDst, ALUOp, regWriteDataSrc, jump;
	output wire branch, bne, memRead, memWrite, memToReg, ALUSrc, regWrite, link, multLoad;



endmodule // controller