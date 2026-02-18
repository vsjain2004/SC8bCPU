module Logic_Arithmetic_Shifter #(parameter SHIFT_BITS = 5) (IN, ShiftAmt, ShiftDir, Arithmetic, Out);
	localparam N = 2**SHIFT_BITS;

	input [N-1:0] IN;
	input [SHIFT_BITS-1:0] ShiftAmt;
	input ShiftDir, Arithmetic;
	output [N-1:0] Out;

	assign Out = Arithmetic ? ($signed(IN) >>> ShiftAmt) : (ShiftDir ? (IN >> ShiftAmt) : (IN << ShiftAmt));
	
endmodule