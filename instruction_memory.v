
module instruction_memory(clk, rst, address, 
							instruction);
	input wire clk, rst;
	input wire[31:0] address;
	output wire[31:0] instruction;

    reg[7:0] instructions[0:4096];
/*
	initial begin

		//addi r1, r0, 40
		{instructions[3], instructions[2], instructions[1], instructions[0]}   = {6'b001000, 5'd0, 5'd1, 16'd40};
		//addi r2, r0, 0
		{instructions[7], instructions[6], instructions[5], instructions[4]}   = {6'b001000, 5'd0, 5'd2, 16'd0};
		//addi r3, r0, 0
		{instructions[11], instructions[10], instructions[9], instructions[8]}  = {6'b001000, 5'd0, 5'd3, 16'd0};
		//LOOP:	beq r1,r2, END
		{instructions[15], instructions[14], instructions[13], instructions[12]} = {6'b000100, 5'd1, 5'd2, 16'd4};
		//	lw r4, 1000(r2)
		{instructions[19], instructions[18], instructions[17], instructions[16]} = {6'b100011, 5'd2, 5'd4, 16'd1000};
		//	add r3, r3, r4
		{instructions[23], instructions[22], instructions[21], instructions[20]} = {6'b000000, 5'd3, 5'd4, 5'd3, 11'b00000100000};
		//	addi r2, r2, 4
		{instructions[27], instructions[26], instructions[25], instructions[24]} = {6'b001000, 5'd2, 5'd2, 16'd4};
		//	J LOOP
		{instructions[31], instructions[30], instructions[29], instructions[28]} = {6'b000010, 26'd3};
		//END:	sw r3, 2000(r0)
		{instructions[35], instructions[34], instructions[33], instructions[32]} = {6'b101011, 5'd0, 5'd3, 16'd2000};
		
	end
*/

	initial begin

		//addi r1, r0, 0
		{instructions[3], instructions[2], instructions[1], instructions[0]}   = {6'b001000, 5'd0, 5'd1, 16'd0};
		//addi r2, r0, 0
		{instructions[7], instructions[6], instructions[5], instructions[4]}   = {6'b001000, 5'd0, 5'd2, 16'd0};
		//addi r3, r0, 0
		{instructions[11], instructions[10], instructions[9], instructions[8]}  = {6'b001000, 5'd0, 5'd3, 16'd0};
		//addi r4, r0, 0
		{instructions[15], instructions[14], instructions[13], instructions[12]} = {6'b001000, 5'd0, 5'd4, 16'd0};
		//addi r7, r0, 20
		{instructions[19], instructions[18], instructions[17], instructions[16]} = {6'b001000, 5'd0, 5'd7, 16'd20};
		//LOOP:	beq r1,r7, END
		{instructions[23], instructions[22], instructions[21], instructions[20]} = {6'b000100, 5'd1, 5'd7, 16'd8};
		//	lw r5, 1000(r2)
		{instructions[27], instructions[26], instructions[25], instructions[24]} = {6'b100011, 5'd2, 5'd5, 16'd1000};
		//	slt r6, r3, r5
		{instructions[31], instructions[30], instructions[29], instructions[28]} = {6'b000000, 5'd3, 5'd5, 5'd6, 11'b00000101010};
		//	beq r6,r0, SML
		{instructions[35], instructions[34], instructions[33], instructions[32]} = {6'b000100, 5'd6, 5'd0, 16'd2};
		//	add r4, r0, r1
		{instructions[39], instructions[38], instructions[37], instructions[36]} = {6'b000000, 5'd0, 5'd1, 5'd4, 11'b00000100000};
		//	add r3, r0, r5
		{instructions[43], instructions[42], instructions[41], instructions[40]} = {6'b000000, 5'd5, 5'd0, 5'd3, 11'b00000100000};
		//SML:	addi r1, r1, 1
		{instructions[47], instructions[46], instructions[45], instructions[44]} = {6'b001000, 5'd1, 5'd1, 16'b1};
		//	addi r2, r2, 4
		{instructions[51], instructions[50], instructions[49], instructions[48]} = {6'b001000, 5'd2, 5'd2, 16'd4};
		//	J LOOP
		{instructions[55], instructions[54], instructions[53], instructions[52]} = {6'b000010, 26'd4};
		//END:	sw r3, 2000(r0)
		{instructions[59], instructions[58], instructions[57], instructions[56]} = {6'b101011, 5'd0, 5'd3, 16'd2000};
		//	sw r4, 2004(r0)
		{instructions[63], instructions[62], instructions[61], instructions[60]} = {6'b101011, 5'd0, 5'd4, 16'd2004};
	
	end


    assign instruction = {instructions[address[11:0]+3], instructions[address[11:0]+2], instructions[address[11:0]+1], instructions[address[11:0]]};

endmodule // instruction_memory
