module Decoder2to4(
	input S1, S0, EN,
	output Y0, Y1, Y2, Y3
);
	
	assign Y0 = EN & ~S1 & ~S0;
	assign Y1 = EN & ~S1 & S0;
	assign Y2 = EN & S1 & ~S0;
	assign Y3 = EN & S1 & S0;
		
endmodule