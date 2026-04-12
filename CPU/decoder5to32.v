module decoder5to32(
	input [4:0] S,
	input EN,
	output [31:0] O
);
	
	
	assign O = {32{EN}} & (1 << S);
endmodule