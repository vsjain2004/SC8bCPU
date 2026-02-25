module busmuxN_32_to_1 #(parameter = 32;) 
	(
		input [4:0] S,
		input [N-1:0] W [0:31],
		output [N-1:0] F
	);
	
	assign F = W[S];
endmodule