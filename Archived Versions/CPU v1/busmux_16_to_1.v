module busmux_16_to_1(S, A, B, C, D, E, FI, G, H, I, J, K, L, M, N, O, P, F);
	input [3:0] S;
	input [15:0] A, B, C, D, E, FI, G, H, I, J, K, L, M, N, O, P;
	output [15:0]F;
	
	assign F = S[3] ? (S[2] ? (S[1] ? (S[0] ? P : O) : (S[0] ? N : M)) : (S[1] ? (S[0] ? L : K) : (S[0] ? J : I))) : (S[2] ? (S[1] ? (S[0] ? H : G) : (S[0] ? FI : E)) : (S[1] ? (S[0] ? D : C) : (S[0] ? B : A)));
endmodule