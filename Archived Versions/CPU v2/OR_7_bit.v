module OR_7_bit(In1, In2, In3, In4, In5, In6, In7, Out);
	input In1, In2, In3, In4, In5, In6, In7;
	output Out;
	
	or(Out, In1, In2, In3, In4, In5, In6, In7);
	
endmodule