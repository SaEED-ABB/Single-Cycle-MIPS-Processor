
module datapath(clk, rst, regDst, branch, bne, memRead, memWrite, memToReg, ALUSrc, ALUOp, regWrite, regWriteDataSrc, jump, link, multLoad,
				zero, instOpcode, instFunc);
	input wire clk, rst;
	input wire[1:0] regDst, ALUOp, regWriteDataSrc, jump;
	input wire branch, bne, memRead, memWrite, memToReg, ALUSrc, regWrite, link, multLoad;
	output wire zero;
	output wire[5:0] instOpcode, instFunc;

	wire[31:0] pc_in, pc_out;
	pc_register PC(.clk(clk), .rst(rst), .pc_in(pc_in), .pc_out(pc_out));
	
	wire[31:0] inst;
	instruction_memory INST_MEM(.clk(clk), .rst(rst), .address(pc_out), .instruction(inst));
	assign instOpcode = inst[31:26];
	assign instFunc = inst[5:0];

	wire[4:0] write_register;
	wire[31:0] to_be_written_data;
	wire[31:0] read_data1, read_data2;
	register_file REG_FILE(.clk(clk), .rst(rst), .regWrite(regWrite), .readRegister1(inst[25:21]), .readRegister2(inst[20:16]), .writeRegister(write_register), .writeData(to_be_written_data), .readData1(read_data1), .readData2(read_data2));

	wire[2:0] alu_operation;
	alu_control ALU_CNTRL(.clk(clk), .rst(rst), .instFunc(instFunc), .ALUOp(ALUOp), .opcode(instOpcode), .ALUOperation(alu_operation));

	wire[31:0] alu_in2;
	wire[31:0] alu_result;
	alu ALU(.ALUOperation(alu_operation), .a(read_data1), .b(alu_in2), .zero(zero), .ALUResult(alu_result));

	wire[31:0] read_mem_result;
	data_memory DATA_MEM(.clk(clk), .rst(rst), .memRead(memRead), .memWrite(memWrite), .address(alu_result), .writeData(read_data2), .readData(read_mem_result));

	wire[31:0] mem_or_alu;
	mux2_32bit MEM_ALU(.sel(memToReg), .a0(alu_result), .a1(read_mem_result), .which_a(mem_or_alu));

	wire[31:0] pc_plus_4;
	wire[31:0] link_or_mem_or_alu;
	mux2_32bit LINK_MEM_ALU(.sel(link), .a0(mem_or_alu), .a1(pc_plus_4), .which_a(link_or_mem_or_alu));

	wire[31:0] lo_out, hi_out, shifted_lui_address;
	mux4_32bit LINK_MEM_ALU_LO_HI_LUIADRR(.sel(regWriteDataSrc), .a0(link_or_mem_or_alu), .a1(lo_out), .a2(hi_out), .a3(shifted_lui_address), .which_a(to_be_written_data));

	wire[63:0] mult_result;
	multer MULTER(.a(read_data1), .b(read_data2), .a_mult_b(mult_result));

	hi_lo_register HI_REG(.clk(clk), .rst(rst), .multLoad(multLoad), .hi_lo_in(mult_result[63:32]), .hi_lo_out(hi_out));
	hi_lo_register LO_REG(.clk(clk), .rst(rst), .multLoad(multLoad), .hi_lo_in(mult_result[31:0]), .hi_lo_out(lo_out));

	mux4_5bit READ2_WRITE_31(.sel(regDst), .a0(inst[20:16]), .a1(inst[15:11]), .a2(5'b11111), .a3(5'bz), .which_a(write_register));

	shift_left16_16bit LUI_SHIFT(.a(inst[15:0]), .shifted_a(shifted_lui_address));

	wire[31:0] sign_extended_beq_addr;
	sign_extend SIGN_EX(.a(inst[15:0]), .sign_extended_a(sign_extended_beq_addr));

	wire[31:0] relative_jump_addr, pc_plus_4_plus_relative_jump_addr;
	adder PC_ADDR_ADDER(.a(pc_plus_4), .b(relative_jump_addr), .a_plus_b(pc_plus_4_plus_relative_jump_addr));

	wire[31:0] pc_plus_4_or_jump;
	wire beq_or_bne;
	assign beq_or_bne = (zero & branch) | (~zero & bne);
	mux2_32bit CONTINUE_JUMP(.sel(beq_or_bne), .a0(pc_plus_4), .a1(pc_plus_4_plus_relative_jump_addr), .which_a(pc_plus_4_or_jump));

	wire[27:0] shifted_j_addr;
	shift_left2_26bit SHIFT_J_ADDR(.a(inst[25:0]), .shifted_a(shifted_j_addr));

	wire[31:0] final_j_addr;
	assign final_j_addr = {pc_out[31:28], shifted_j_addr};
	mux4_32bit PCP4JUMP_J_READ1(.sel(jump), .a0(pc_plus_4_or_jump), .a1(final_j_addr), .a2(read_data1), .a3(32'bz), .which_a(pc_in));

	mux2_32bit READDATA2_ADDR(.sel(ALUSrc), .a0(read_data2), .a1(sign_extended_beq_addr), .which_a(alu_in2));
	shift_left2_32bit SHL232(.a(sign_extended_beq_addr), .shifted_a(relative_jump_addr));
	adder PC_4_ADDER(.a(pc_out), .b(32'd4), .a_plus_b(pc_plus_4));

endmodule // datapath