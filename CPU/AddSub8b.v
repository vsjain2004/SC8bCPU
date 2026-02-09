module AddSub8b(Cin, X, Y, S, Cout, Ov);
	input Cin;
	input [7:0] X, Y;
	output [7:0] S;
	output Cout, Ov;
	
	wire [7:0] Yi;
	
	assign Yi = Cin ? ~Y : Y;

	assign {Cout, S[7:0]} = X + Yi + Cin;
	
	assign Ov = Cin ? ((X[7] ^ Y[7]) & (X[7] ^ S[7])) : ((~X[7] & ~Y[7] & S[7]) | (X[7] & Y[7] & ~S[7]));
endmodule