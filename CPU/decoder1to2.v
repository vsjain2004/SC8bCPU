module decoder1to2(S, X, XO, IO);
	input S;
	input [7:0] X;
	output reg [7:0] XO, IO;
	
	always @*
	begin
	XO = 7'b0000000;
	IO = 7'b0000000;
	case({S})
	1'b0: XO=X;
	1'b1:	IO=X;
	endcase
	end
endmodule