module decoder4to16(
	input [3:0] S,
	output [15:0] O
);
	
	assign O = 1 << S;
endmodule