module busmuxN_8_to_1 #(parameter = 32;) (S, W0, W1, W2, W3, W4, W5, W6, W7, F);
	input [2:0] S;
	input [N-1:0] W0, W1, W2, W3, W4, W5, W6, W7;
	output [N-1:0] F;
	
	assign F = S[2] ? (S[1] ? (S[0] ? W7 : W6) : (S[0] ? W5 : W4)) : (S[1] ? (S[0] ? W3 : W2) : (S[0] ? W1 : W0));
endmodule