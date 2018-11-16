
module sign_extend(a, 
					sign_extended_a);
	input wire[15:0] a;
	output wire[31:0] sign_extended_a;

	assign sign_extended_a = a[15] ? {16'b1111111111111111, a[15:0]} : {16'b0000000000000000, a[15:0]}; 

endmodule // sign_extend