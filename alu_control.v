
module alu_control(clk, rst, instFunc, ALUOp, 
					ALUOperation);
	input wire clk, rst;
	input wire[5:0] instFunc;
	input wire[1:0] ALUOp;
	output wire[2:0] ALUOperation;


	assign ALUOperation = (ALUOp == 2'b00) ? 3'b010 :  // add
						(ALUOp[0] == 1'b1) ? 3'b110 :  // sub
						(ALUOp[1] == 1'b1) ? (instFunc[3:0] == 4'b0000 ? 3'b010 :  // add
											instFunc[3:0] == 4'b0010 ? 3'b110 :  // sub
											instFunc[3:0] == 4'b0100 ? 3'b000 :  // and
											instFunc[3:0] == 4'b0101 ? 3'b001 :  // or
											instFunc[3:0] == 4'b1010 ? 3'b111 :  // slt
											3'bxxx) :
						3'bxxx;

endmodule // alu_control