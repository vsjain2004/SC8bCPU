module busmuxN_4_to_1 #(parameter N = 32) (
	input [N-1:0] In1, In2, In3, In4,
	input s1, s0,
	output [N-1:0] Out
);
	
	assign Out = s1 ? (s0 ? In4 : In3) : (s0 ? In2 : In1);
	
endmodule