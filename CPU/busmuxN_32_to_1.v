module busmuxN_32_to_1 #(parameter N = 32) (
	input [4:0] S,
	input [32*N-1:0] W ,
	output [N-1:0] F
);
	
	assign F = W[S*N +: N];
endmodule