module Arithmetic_Shifter #(parameter SHIFT_BITS = 5) (IN, ShiftAmt, Out);
	localparam N = 2**SHIFT_BITS;
	
	input signed [N-1:0] IN;
	input [SHIFT_BITS:0] ShiftAmt;
	output [N-1:0] Out;
	
	assign Out = IN >>> ShiftAmt;
endmodule