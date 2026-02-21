module Circular_Shifter #(parameter SHIFT_BITS = 5) (IN, ShiftAmt, ShiftDir, Out);
	localparam N = 2**SHIFT_BITS;

	input [N-1:0] IN;
	input [SHIFT_BITS-1:0] ShiftAmt;
	input ShiftDir;
	output [N-1:0] Out;

	assign Out = ShiftDir ? {IN, IN} >> ShiftAmt : {IN, IN} >> (N - ShiftAmt);

	// 0101 1011 -> 1010 1101 = CSR by 1 ==> 01011011{01011011} Shift Right by 1 ==> 0101101{10101101}1
endmodule