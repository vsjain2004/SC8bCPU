module Circular_Shifter #(parameter SHIFT_BITS = 5) (IN, ShiftAmt, ShiftDir, Out);
	localparam N = 2**SHIFT_BITS;

	input [N-1:0] IN;
	input [SHIFT_BITS-1:0] ShiftAmt;
	input ShiftDir;
	output [N-1:0] Out;

	assign Out = {IN, IN} >> (N - ShiftAmt);
endmodule