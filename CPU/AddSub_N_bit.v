module AddSub_N_bit #(parameter N = 32) (Cin, X, Y, S, Cout, Ov);
	input Cin;
	input [N-1:0] X, Y;
	output [N-1:0] S;
	output Cout, Ov;
	
	wire [N-1:0] Yi;
	
	assign Yi = Cin ? ~Y : Y;

	assign {Cout, S[N-1:0]} = X + Yi + Cin;
	
	assign Ov = Cin ? ((X[N-1] ^ Y[N-1]) & (X[N-1] ^ S[N-1])) : ((~X[N-1] & ~Y[N-1] & S[N-1]) | (X[N-1] & Y[N-1] & ~S[N-1]));
endmodule