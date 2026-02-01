module busmuxN_2_to_1 #(parameter N = 8)(In1, In2, S, Out);
	input [N-1:0] In1;
	input [N-1:0] In2;
	input S;
	output [N-1:0] Out;
	
	assign Out = S ? In2 : In1;
	
endmodule